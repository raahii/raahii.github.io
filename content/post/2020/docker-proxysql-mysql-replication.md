+++
title = "ProxySQLでMySQLの負荷分散をする"
date = 2020-05-31T17:20:27+09:00
categories = ["開発"] # 技術, 研究, 読書, レビュー, 旅行
tags = ["proxysql", "mysql", "replication", "grafana", "prometheus"]
images = ["https://www.google.com/url?sa=i&url=https%3A%2F%2Ftech.actindi.net%2F2019%2F09%2F19%2F101237&psig=AOvVaw2nTGrUCQ5AhUnAC8zDTcXr&ust=1591000615223000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCLiqoKfZ3ekCFQAAAAAdAAAAABAD"]
keywords = ["proxysql", "mysql", "replication", "grafana", "prometheus", "load balancing"]
description = "ProxySQLでMySQLを負荷分散する "
draft = false

+++




## TL;DR
- Docker上にProxySQLとMySQL（構成: master1 + slave2）を構築
- sysbenchを使ってリクエストを送り、負荷分散されることを確認
- 様子を Prometheus + Grafana を使ってモニタリングしてみる



{{< image src="https://user-images.githubusercontent.com/13511520/83347412-e2c4f280-a35f-11ea-8048-2b0645e99245.png"
          width="90%" alt="overview"
          link="https://user-images.githubusercontent.com/13511520/83347412-e2c4f280-a35f-11ea-8048-2b0645e99245.png" >}}




## はじめに
前回、[MySQLのmaster slave構成をDockerで作ってみた](https://raahii.github.io/posts/docker-mysql-master-slave-replication/) が、実際の開発では複数DBをアプリケーションから使うには一工夫必要である。もっとも素朴な方法は使用するDBの接続情報をアプリケーションですべて保持しておき、read系/write系で使い分けることだと思う。しかし、これは次のような問題がある。

* DBの接続情報は途中で変わりうる
* アプリケーションのロジックにDBの使い分けが入るのは面倒（だし複雑）

そこで、今回は [ProxySQL](https://proxysql.com/) を試してみる。ProxySQLは アプリケーションとDBの間に入って、次のようなことをしてくれる。

- クエリに応じたmaster / slave への自動プロキシ
- 負荷分散
- シームレスな接続設定の変更

どの程度メジャーなのかはいまいちわかっていないが、公式の [mysql-proxy](https://github.com/mysql/mysql-proxy)よりは使われているようだったので選んだ。ちなみにProxySQLはMysQL以外のDBでも使える。

## MySQLのセットアップ
前回に続いてMySQL8.0を使い、masterを1つ、slaveを2つ用意してレプリケーション設定を組んでおいた。

```docker
version: "3"

services:
  mysql-master:
    image: mysql:8.0
    container_name: proxysql-mysql-replication-master
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: sbtest
    volumes:
      - ./master/my.cnf:/etc/mysql/my.cnf
      - ./master/data:/var/lib/mysql
      - ./master/init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - 3306:3306

  mysql-slave1:
    image: mysql:8.0
    container_name: proxysql-mysql-replication-slave1
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: sbtest
    volumes:
      - ./slave/my-slave1.cnf:/etc/mysql/my.cnf
      - ./slave/data/slave1:/var/lib/mysql
      - ./slave/init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - 3307:3306
    depends_on:
      - mysql-master

  mysql-slave2:
    image: mysql:8.0
    container_name: proxysql-mysql-replication-slave2
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: sbtest
    volumes:
      - ./slave/my-slave2.cnf:/etc/mysql/my.cnf
      - ./slave/data/slave2:/var/lib/mysql
      - ./slave/init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - 3308:3306
    depends_on:
      - mysql-master
```

立ち上げて、masterとslaveの状態を確認。まずmaster。

```shell
❯ docker-compose exec mysql-master sh -c "export MYSQL_PWD=password; mysql -u root sbtest -e 'show master status\G'"
*************************** 1. row ***************************
             File: mysql-bin.000001
         Position: 156
     Binlog_Do_DB: sbtest
 Binlog_Ignore_DB:
Executed_Gtid_Set: 0efd14cd-a27a-11ea-9d90-0242ac1a0002:1-67
```

slave1。もう一つも同様。

```shell
❯ docker-compose exec mysql-slave1 sh -c "export MYSQL_PWD=password; mysql -u root sbtest -e 'show slave status\G'"
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: mysql-master
                  Master_User: slave_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000003
          Read_Master_Log_Pos: 196
               Relay_Log_File: mysql-relay-bin.000007
                Relay_Log_Pos: 411
        Relay_Master_Log_File: mysql-bin.000003
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
...
```

良さそう。



## ProxySQLのセットアップ

次にProxySQL。設定ファイルは次のようにした。

```docker
# proxysql.cnf
datadir="/var/lib/proxysql"

admin_variables=
{
    admin_credentials="admin:admin;admin2:pass2"
    mysql_ifaces="0.0.0.0:6032"
    refresh_interval=2000
    stats_credentials="stats:admin"
}

mysql_variables=
{
    threads=4
    max_connections=2048
    default_query_delay=0
    default_query_timeout=36000000
    have_compress=true
    poll_timeout=2000
    interfaces="0.0.0.0:6033;/tmp/proxysql.sock"
    default_schema="information_schema"
    stacksize=1048576
    server_version="8.0"
    connect_timeout_server=10000
    monitor_history=60000
    monitor_connect_interval=200000
    monitor_ping_interval=200000
    ping_interval_server_msec=10000
    ping_timeout_server=200
    commands_stats=true
    sessions_sort=true
    monitor_username="monitor"
    monitor_password="monitor"
}

mysql_replication_hostgroups =
(
    { writer_hostgroup=10 , reader_hostgroup=20 , comment="host groups" }
)

mysql_servers =
(
    { address="mysql-master" , port=3306 , hostgroup=10, max_connections=100 , max_replication_lag = 5 },
    { address="mysql-slave1" , port=3306 , hostgroup=20, max_connections=100 , max_replication_lag = 5 },
    { address="mysql-slave2" , port=3306 , hostgroup=20, max_connections=100 , max_replication_lag = 5 }
)

mysql_query_rules =
(
    {
        rule_id=100
        active=1
        match_pattern="^SELECT .* FOR UPDATE"
        destination_hostgroup=10
        apply=1
    },
    {
        rule_id=200
        active=1
        match_pattern="^SELECT .*"
        destination_hostgroup=20
        apply=1
    },
    {
        rule_id=300
        active=1
        match_pattern=".*"
        destination_hostgroup=10
        apply=1
    }
)

mysql_users =
(
    { username = "root" , password = "password" , default_hostgroup = 10 , active = 1 }
)
```

色々書かれているけど、まず`mysql_replication_hostgroups` でmaster / slaveのホストグループを設定し、実際の接続情報を `mysql_servers` に記述している。



さらに、`mysql_query_rules` ではクエリ毎にどのホストグループへとリクエストを流すのか記述できる。`SELECT` クエリをslaveに、それ以外はmasterへと送るように設定した。

設定ファイル以外に必要なことは、接続先のMySQLでProxySQL用のユーザーを作ること。

```sql
CREATE USER IF NOT EXISTS 'monitor'@'%' IDENTIFIED BY 'monitor';
```

ちなみに、[MySQL 8.0](https://proxysql.com/documentation/MySQL-8.0/)のデフォルトの認証プラグインである `caching_sha2_password` はProxySQLでは非対応なので、`my.cnf`に下記を追加しておく必要もある。

```
[mysqld]
...
default_authentication_plugin=mysql_native_password
```

docker-compose に追加して、ProxySQLを立ち上げてみる。

```docker
version: "3"

services:
  ...

  proxysql:
    image: proxysql/proxysql:2.0.12
    container_name: proxysql-mysql-replication-proxysql
    ports:
      - 6032:6032
      - 6033:6033
    volumes:
      - ./proxysql/proxysql.cnf:/etc/proxysql.cnf
    depends_on:
      - mysql-master
      - mysql-slave1
      - mysql-slave2
```


```shell
❯ $ mysql -h 0.0.0.0 -P 6032 -u admin2 -p -e 'select * from mysql_servers'
  Enter password:
  +--------------+--------------+------+-----------+--------+--------+-------------+-----------------+---------------------+---------+----------------+---------+
  | hostgroup_id | hostname     | port | gtid_port | status | weight | compression | max_connections | max_replication_lag | use_ssl | max_latency_ms | comment |
  +--------------+--------------+------+-----------+--------+--------+-------------+-----------------+---------------------+---------+----------------+---------+
  | 10           | mysql-master | 3306 | 0         | ONLINE | 1      | 0           | 100             | 5                   | 0       | 0              |         |
  | 20           | mysql-slave1 | 3306 | 0         | ONLINE | 1      | 0           | 100             | 5                   | 0       | 0              |         |
  | 20           | mysql-slave2 | 3306 | 0         | ONLINE | 1      | 0           | 100             | 5                   | 0       | 0              |         |
  +--------------+--------------+------+-----------+--------+--------+-------------+-----------------+---------------------+---------+----------------+---------+
```

きちんとmasterとslaveが認識されている！あとは、ProxySQLの6033ポートをDBの宛先として使えばオッケー :tada:




## sysbenchで負荷をかけてみる
ここまでProxySQLを使って複数DBを扱えているので、[sysbench](https://github.com/akopytov/sysbench)でベンチマークを取ってみる。同時に、負荷分散が行われているか確認するために、[mysqld-exporter](https://github.com/prometheus/mysqld_exporter) を使ってMySQLの各種メトリクスを[Prometheus](https://prometheus.io/)で取得し、[Grafana](https://grafana.com/)で可視化してみる。

これらのセットアップについては本筋から逸れるので割愛する。簡単に説明すると、mysqld-exporterをすべてのMySQLに設定し、Prometheusのtargetとして登録、あとはGrafanaからPrometheusのデータをimportすればよい。詳細はコードを見てほしい。

また、Grafanaのダッシュボードは [percona/grafana-dashboards](https://github.com/percona/grafana-dashboards) に良い感じのものが上がっているので、ありがたく使わせていただく。[MySQL_Overview](https://github.com/percona/grafana-dashboards/blob/master/dashboards/MySQL_Overview.json) をロードすると、初期状態はこんな感じ。ProxySQLのmonitorユーザーからのアクセスだろうか、QPSは4前後を推移している。

{{< image src="https://user-images.githubusercontent.com/13511520/83348222-73ea9800-a365-11ea-9162-acf5c99c76e5.png"
          width="100%" alt="master"
          link="https://user-images.githubusercontent.com/13511520/83348222-73ea9800-a365-11ea-9162-acf5c99c76e5.png" >}}

まずは、masterの `sb_test` データベースに対し、テーブル数10、各10000個のレコードを生成する。

```shell
❯ sysbench --db-driver=mysql \
        --mysql-host=0.0.0.0 \
        --mysql-port=6033 \
        --mysql-user=root \
        --mysql-password=password \
        --mysql-db=sbtest \
        --threads=10 \
        --tables=10 \
        --table-size=10000 \
        oltp_read_only \
        prepare
```

今回は、ProxySQLでDB構成を変更しながら、次のような4つのベンチマークを取ってみた。

1. master単体に対して、同時接続数100で1分間readクエリをかける
2. master単体に対して、同時接続数50で1分間readクエリをかける
3. master + slave x2 に対して、同時接続数100で1分間readクエリをかける
4. master + slave x2 に対して、同時接続数60で1分間readクエリをかける

ベンチマークのコマンド例。
```shell
❯ sysbench --db-driver=mysql \
        --mysql-host=0.0.0.0 \
        --mysql-port=6033 \
        --mysql-user=root \
        --mysql-password=password \
        --mysql-db=sbtest \
        --threads=<同時接続数> \
        --time=<時間[s]＞ \
        oltp_read_only \
        run
```

すると、結果は次のようになった。（詳細は最後に記載）
1. MaxConnectionを超えたためエラー
2. 成功（Average Latency= 643.54 [ms]）
3. 成功（Average Latency = 1825.77 [ms]）
4. 成功（Average Latency = 917.97 [ms]）

どうやら、今回のdocker環境では、master単体では同時接続数100は耐えられないらしい。しかし、slave2つを加えた構成にすることで耐えることが出来た。

ちなみに、1のエラーの原因だが、MaxConnectionsは151に設定されており、これを超えたことがGrafanaでも確認できた。（なぜ同時接続数100のベンチでそこまで大きな値をとるのか謎で調べてみたが、わからなかった。とにかくProxySQLを介すると本来の接続数の2倍近い値が出てしまうようだ。Connection Poolがうまく再利用できていないのだろうか…？要調査）

MaxConnectionの値は変更可能だが、今回これを限界だと捉えれば、冗長化によってより多くの同時リクエストを捌けたと言える。Slaveにもきちんとリクエストが飛んでいるのが確認できた。

- master
  {{< image src="https://user-images.githubusercontent.com/13511520/83347951-a5626400-a363-11ea-9d60-dfd75c12ee28.png"
            width="90%" alt="master"
            link="https://user-images.githubusercontent.com/13511520/83347951-a5626400-a363-11ea-9d60-dfd75c12ee28.png" >}}
  
- slave1
	{{< image src="https://user-images.githubusercontent.com/13511520/83347954-a7c4be00-a363-11ea-87b8-b1d7466d2b5e.png"
	          width="90%" alt="master"
	          link="(https://user-images.githubusercontent.com/13511520/83347954-a7c4be00-a363-11ea-87b8-b1d7466d2b5e.png" >}}


- slave2

  {{< image src="https://user-images.githubusercontent.com/13511520/83347956-aa271800-a363-11ea-942e-a13efcd58128.png"
            width="90%" alt="master"
            link="https://user-images.githubusercontent.com/13511520/83347956-aa271800-a363-11ea-942e-a13efcd58128.png" >}}

  


ちなみに、Grafanaのダッシュボードは簡単にsnapshotが取れたので掲載しておく。
- [masterのダッシュボード](https://snapshot.raintank.io/dashboard/snapshot/Ve4OefZud4ZchPoYuyrZCYnrKQ8fJIEw?orgId=2)
- [slave1のダッシュボード](https://snapshot.raintank.io/dashboard/snapshot/j8iLJRXhnz0JGMn5Zl5onpLS66Yfs73x?orgId=2)
- [slave2のダッシュボード](https://snapshot.raintank.io/dashboard/snapshot/IEH258Pt3AXPYWOlMKZ4eFz55nwxaVdS?orgId=2&refresh=5s)


## おわりに
アプリケーションから使う場合を想定して、MySQLのmaster-slaveノードをProxySQLで使う構成を試してみた。ProxySQLは簡単にセットアップできて様々な恩恵を受けられるものの、実用ではこれ自体のチューニングやクラスター化をしていかないと、新たなボトルネックが生まれそうな気もする。

次は時間があったらfailoverについて調べてみたい。



{{< image src="https://user-images.githubusercontent.com/13511520/83348184-1bb39600-a365-11ea-9fe9-768be9470fc8.png"
          width="60%" alt="repo image"
          link="https://github.com/raahii/proxysql-mysql-replication" >}}




## Appendix
sysbenchの詳細な結果。
1. master単体に対して、同時接続数100で1分間
```
FATAL: mysql_stmt_execute() returned error 9001 (Max connect timeout reached while reaching hostgroup 20 after 10004ms) for query 'SELECT SUM(k) FROM sbtest1 WHERE id BETWEEN ? AND ?'
FATAL: mysql_stmt_execute() returned error 9001 (Max connect timeout reached while reaching hostgroup 20 after 10004ms) for query 'SELECT c FROM sbtest1 WHERE id=?'
FATAL: `thread_run' function failed: ...al/Cellar/sysbench/1.0.20/share/sysbench/oltp_common.lua:419: SQL error, errno = 9001, state = 'HY000': Max connect timeout reached while reaching hostgroup 20 after 10004ms
FATAL: `thread_run' function failed: ...al/Cellar/sysbench/1.0.20/share/sysbench/oltp_common.lua:432: SQL error, errno = 9001, state = 'HY000': Max connect timeout reached while reaching hostgroup 20 after 10004ms
FATAL: mysql_stmt_execute() returned error 9001 (Max connect timeout reached while reaching hostgroup 20 after 10009ms) for query 'SELECT c FROM sbtest1 WHERE id=?'
(last message repeated 1 times)
FATAL: `thread_run' function failed: ...al/Cellar/sysbench/1.0.20/share/sysbench/oltp_common.lua:419: SQL error, errno = 9001, state = 'HY000': Max connect timeout reached while reaching hostgroup 20 after 10009ms
FATAL: mysql_stmt_execute() returned error 9001 (Max connect timeout reached while reaching hostgroup 20 after 10009ms) for query 'SELECT c FROM sbtest1 WHERE id=?'
FATAL: `thread_run' function failed: ...al/Cellar/sysbench/1.0.20/share/sysbench/oltp_common.lua:419: SQL error, errno = 9001, state = 'HY000': Max connect timeout reached while reaching hostgroup 20 after 10009ms
(last message repeated 1 times)
FATAL: mysql_stmt_execute() returned error 9001 (Max connect timeout reached while reaching hostgroup 20 after 10000ms) for query 'SELECT c FROM sbtest1 WHERE id BETWEEN ? AND ?'
FATAL: `thread_run' function failed: ...al/Cellar/sysbench/1.0.20/share/sysbench/oltp_common.lua:432: SQL error, errno = 9001, state = 'HY000': Max connect timeout reached while reaching hostgroup 20 after 10000ms
```

2. master単体に対して、同時接続数50で1分間
```
SQL statistics:
    queries performed:
        read:                            65422
        write:                           0
        other:                           9346
        total:                           74768
    transactions:                        4673   (77.50 per sec.)
    queries:                             74768  (1240.08 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.2910s
    total number of events:              4673

Latency (ms):
         min:                                  111.09
         avg:                                  643.54
         max:                                 3138.66
         95th percentile:                     1533.66
         sum:                              3007283.24

Threads fairness:
    events (avg/stddev):           93.4600/4.89
    execution time (avg/stddev):   60.1457/0.09
```

3. master + slave x2 に対して、同時接続数100で1分間
```
SQL statistics:
    queries performed:
        read:                            46298
        write:                           0
        other:                           6614
        total:                           52912
    transactions:                        3307   (54.54 per sec.)
    queries:                             52912  (872.63 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.6335s
    total number of events:              3307

Latency (ms):
         min:                                  213.29
         avg:                                 1825.77
         max:                                 5333.50
         95th percentile:                     3267.19
         sum:                              6037808.20

Threads fairness:
    events (avg/stddev):           33.0700/3.55
    execution time (avg/stddev):   60.3781/0.16
```


4. master + slave x2 に対して、同時接続数50で1分間
```
SQL statistics:
    queries performed:
        read:                            46354
        write:                           0
        other:                           6622
        total:                           52976
    transactions:                        3311   (53.75 per sec.)
    queries:                             52976  (859.98 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          61.5994s
    total number of events:              3311

Latency (ms):
         min:                                  133.54
         avg:                                  917.97
         max:                                 3431.71
         95th percentile:                     2159.29
         sum:                              3039408.90

Threads fairness:
    events (avg/stddev):           66.2200/8.72
    execution time (avg/stddev):   60.7882/0.55
```
