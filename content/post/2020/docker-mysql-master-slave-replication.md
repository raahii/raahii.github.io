+++
title = "MySQLのmaster slave構成をDockerで試す"
date = 2020-05-28T23:43:16+09:00
categories = ["技術"] # 技術, 研究, 読書, レビュー, 旅行
tags = ["mysql", "database", "web", "docker"]
images = ["https://miro.medium.com/max/900/1*5JgbHNxldQcCocld6mfEkQ.jpeg"]
keywords = ["mysql", "master slave", "replication", "docker", "docker-compose"]
description = "MySQLのmaster slave構成をDockerで試す"
draft = false
+++



研修で触ったときにサクッと動かなかったので追試的に。MySQLは8.0を使う。

{{< image src="https://user-images.githubusercontent.com/13511520/83156887-ec6f1000-a13d-11ea-80d7-cb4619751706.png"
          width="60%" alt="repo image"
          link="https://github.com/raahii/docker-mysql-master-slave"
          >}}

レプリケーション自体の仕組みは [進化を続けるMySQLのド定番機能　MySQLレプリケーション最新機能](https://www.slideshare.net/yoyamasaki/mysqlmysql) がわかりやすかった。


## 必要なこと
[How To Set Up Master Slave Replication in MySQL | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-in-mysql)

このページを見ながらmasterとslaveのmysqldを1つずつ用意して、設定を行う。異なる点は下記。

- master, slave共に `bind-address`を`0.0.0.0`として、dockerのネットワークエイリアスで繋ぐ

- masterのMySQLにレプリケーション用のユーザーを作成するが、[MySQL8.0ではGRANT構文でユーザを作成できない](https://www7390uo.sakura.ne.jp/wordpress/archives/456) ので下記のようにする

```
create user 'slave_user'@'%' identified by 'password';
grant replication slave on *.* to 'slave_user'@'%' with grant option;
flush privileges;
```

- GTIDを有効にして `MASTER_LOG_FILE` と `MASTER_LOG_POS` は自動で検知されるようにする。


```
CHANGE MASTER TO MASTER_HOST='mysql-master',MASTER_USER='slave_user',MASTER_PASSWORD='password',MASTER_AUTO_POSITION=1;
START SLAVE;
```



## レプリケーションを確認する

```shell
$ git clone https://github.com/raahii/docker-mysql-master-slave.git
$ cd docker-mysql-master-slave
$ docker-compose up -d
```

```shell
$ docker-compose ps
    Name                 Command             State                 Ports
--------------------------------------------------------------------------------------
mysql-master   docker-entrypoint.sh mysqld   Up      0.0.0.0:3306->3306/tcp, 33060/tcp
mysql-slave    docker-entrypoint.sh mysqld   Up      0.0.0.0:3307->3306/tcp, 33060/tcp

```

- masterのステータスを確認
```shell
$ docker-compose exec mysql-master sh -c "export MYSQL_PWD=password; mysql -u root app -e 'show master status\G'" 
*************************** 1. row ***************************
             File: mysql-bin.000001
         Position: 156
     Binlog_Do_DB: app
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 
```

- slaveのステータスを確認
```shell
$ docker-compose exec mysql-slave sh -c "export MYSQL_PWD=password; mysql -u root app -e 'show slave status\G'" 
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: mysql-master
                  Master_User: slave_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000001
          Read_Master_Log_Pos: 156
               Relay_Log_File: mysql-relay-bin.000004
                Relay_Log_Pos: 371
        Relay_Master_Log_File: mysql-bin.000001
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
                            :
                            :
```

- masterにテーブルを作ってレコードをinsert
```shell
$ docker-compose exec mysql-master sh -c “export MYSQL_PWD=password; mysql -u root app -e ‘create table code(code int); insert into code values (100), (200)’”
```


- 変更が slave に反映されていることを確認
```shell
$ docker-compose exec mysql-slave sh -c "export MYSQL_PWD=password; mysql -u root app -e 'select * from code \G'"
*************************** 1. row ***************************
code: 100
*************************** 2. row ***************************
code: 200
```

テーブルも作られているし、レコードも入っている。良さそう。


## 参考

- [MySQL入門　レプリケーション編 - Qiita](https://qiita.com/Tocyuki/items/c224cef57493f536a941)
- [漢(オトコ)のコンピュータ道: MySQLレプリケーションの運用が劇的変化！！GTIDについて仕組みから理解する](http://nippondanji.blogspot.com/2014/12/mysqlgtid.html)

