+++
title = "Vim ALE と sql-formatter で SQL を整形する"
date = 2022-09-20T00:30:00+09:00
categories = ["技術"] # 技術, 研究, 読書, レビュー, 旅行
tags = ["mysql", "coc.nvim", "vim", "ale"]
images = ["https://user-images.githubusercontent.com/3518142/59195920-2c339500-8b85-11e9-9c22-f6b7f69637b8.jpg"]
keywords = ["Neovim", "sql-formatter", "vim", "ALE", "フォーマッター"]
description = "Vim ALE と sql-formatter で SQL を整形する"
draft = false
+++


最近データベーススペシャリストの勉強をしながら SQL を書いている中で、フォーマッタがほしいなと思ったので色々調査していた。Vim に [ALE](https://github.com/dense-analysis/ale) というリンタプラグインがあるが、公式でサポートしている SQL 向けのフォーマットは下記の4つだ（2022/09 時点）。

- [dprint](https://dprint.dev/)
- [pgformatter](https://github.com/darold/pgFormatter)
- [sqlfmt](https://github.com/jackc/sqlfmt)
- [sqlformat](https://github.com/andialbrecht/sqlparse)

[ale/ale-sql.txt · dense-analysis/ale](https://github.com/dense-analysis/ale/blob/master/doc/ale-sql.txt)



一通り使ってみた中では `pgformatter` が良かった。設定が豊富で、それらを `~/.pg_format` で管理することもできる。特に、コンマを行頭に持ってこれる整形オプションが好きで、こんなSQLが、

```sql
SELECT po.id product_order_id, p.id product_id, p.name product_name, po.num_orders
FROM product_order po
JOIN product p ON p.id = po.product_id
WHERE p.is_set_product = TRUE
```

こんな風にフォーマットされて良い。

```sql
SELECT
    po.id product_order_id
    , p.id product_id
    , p.name product_name
    , po.num_orders
FROM
    product_order po
    JOIN product p ON p.id = po.product_id
WHERE
    p.is_set_product = TRUE
```



ところが、使っている中でコメント周りやサブクエリ周りの整形が微妙なことがわかったのと、`pgformatter` は PostgreSQL 向けなのに対し、私は MySQL 向けのSQLを書くことが多いので、代替を探していた。



すると、巷では明らかに [sql-formatter-org/sql-formatter](https://github.com/sql-formatter-org/sql-formatter) が使われているようだった。例えば[coc-sql](https://github.com/fannheyward/coc-sql) も採用している。サポートしているクエリ言語も手広いので、これを採用して ALE に組み込むことにした。



ALE では次のように任意のコマンドを組み込める。`-l` の言語指定はお好みで。

```
let g:ale_fixers = {
  ...
  \ 'sql': [
  \   { buffer -> {
  \       'command': 'sql-formatter -l mysql'
  \   }},
  \ ]
\}
```


{{< rawhtml >}}
<script id="asciicast-tGeh0GTOtzwjyVMlT9oI8KNSi" src="https://asciinema.org/a/tGeh0GTOtzwjyVMlT9oI8KNSi.js" async></script>
{{< /rawhtml >}}



これでめっちゃ快適にSQLを書けるようになった。



余談だが、仕事でもクエリを管理するためのレポがあって、DBオペの度にそこでレビュー受けてから実行するような運用なのだけれど、書き方が結構バラバラなので導入してみようかな。そういうチョットしたものでも、フォーマッタがある方が書く側もレビューする側も余計な時間を使わずに済んで良い。



あと、LSP があるのでなぜ未だに ALE つかっているの？と思う人もいるかも知れない。私は coc.nvim を使っているが、フォーマッタは自由に選んで差し替えられるようにしたいので、フォーマッタだけ ALE を使う運用を続けている。coc でフォーマットもやる場合は何もかもプラグインの実装次第なのだが、大体フォーマッタが無くて足したいとか、別のものを使いたいとか、そいつだけ無効にしたい、となり、でも設定が提供されていないとそこで詰むという感じで柔軟性に欠けるので止めた、という経緯です。
