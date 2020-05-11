+++
title = "coc.nvim で golint を使う"
date = 2020-05-11T11:34:15+09:00
categories = ["技術"] # 技術, 研究, 読書, レビュー, 旅行
tags = ["golang", "golint", "coc.nvim", "vim"]
images = [""]
keywords = ["coc.nvim", "golint", "LSP", "Language Server", "coc-diagnostic"]
description = "coc.nvimでgolintを使えるようにする"
draft = false

+++



[coc.nvim](https://github.com/neoclide/coc.nvim) は VimのLSPプラグインの一つで、コード補完や定義ジャンプを提供したり、ドキュメントを良い感じに出してくれる。cocはプラグインであるにも関わらず、それ自体が拡張機能（エクステンション）を持っており、使いたい言語の拡張を入れるだけで細かい設定が要らないのが大きな特徴である。あとFloating Windowの表示がとても見やすい。

<div style="text-align: center;">
  <figure>
    <img src="/images/2020/setup-golint-coc-nvim/document.png" alt="thumbnail" width="100%">
	</figure>
</div>

ただ、個人的にLSPプラグインはリンティング・フォーマッティングとの組み合わせ方が難しいと思っている。なぜなら、cocはいずれの機能も提供するものの、特定のフォーマッタをピンポイントで入れるのはなかなか難しいからである。エクステンションが設定を用意していない限り、カスタマイズが難しい。



なので自分は、LSPには基本的な補完機能とリンティングを、[ale](https://github.com/dense-analysis/ale)にフォーマッティングを任せている。こうすることで、cocの快適な機能を享受しつつも、aleで非同期に（カーソル動作をブロックせずに）コードフォーマットも行えている。



本題になるが、今、自分はGoのLSPとして標準の [gopls](https://github.com/golang/go/wiki/gopls) を使っており、これは [coc-go](https://github.com/josa42/coc-go) が提供するが、残念がら golint を使うことができない。リントにLSPを使っている以上、golintもLSPとして連携されなければならない、という問題がある。



こう言うときに使えるのが [diagnostic-languageserver](https://github.com/iamcco/diagnostic-languageserver) である。これは、任意のコマンドをLSP化してくれるもので、coc向けには [coc-diagnostic](https://github.com/iamcco/coc-diagnostic) が提供されている。これを活用することで、例えば JSのeslintやdockerfileのhadolintなんかもLSPとして組み込むことができる（！）



以下、導入方法を順に説明すると、



1. coc-diagnosticをインストールする。

    ```
    :CocInstall coc-diagnostic
    ```

    でも良いし、 Vim Plugで管理しているのであれば

    ```
    Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile && yarn build'}
    ```

    と書くこともできる。




2. golintをインストールする。

    地味に気づかなかったりするのですが、当然入っていないと動きません。

    ```
    go get github.com/golang/lint
    ```

3. `coc-settings.json` に下記を設定する

    ```
    {
     ...
       
     "languageserver": {
       "dls": {
         "command": "diagnostic-languageserver",
         "args": ["--stdio"],
         "filetypes": [ "go" ],
         "initializationOptions": {
           "linters": {
             "golint": {
               "command": "golint",
               "rootPatterns": [],
               "isStdout": true,
               "isStderr": false,
               "debounce": 100,
               "args": ["%filepath"],
               "offsetLine": 0,
               "offsetColumn": 0,
               "sourceName": "golint",
               "formatLines": 1,
               "formatPattern": [
                 "^[^:]+:(\\d+):(\\d+):\\s(.*)$",
                 {
                   "line": 1,
                   "column": 2,
                   "message": [3]
                 }
               ]
             }
           },
           "formatters": {},
           "filetypes": {
             "go": "golint"
           },
           "formatFiletypes": {}
         }
       }
     }
    }
    ```


そうするとこんな感じで coc経由できちんとgolintの出力が見れると思います。 golintは出力にlevelがないので、すべてerrorとして表示されるのが少し気になるけど。

<div style="text-align: center;">
  <figure>
    <img src="/images/2020/setup-golint-coc-nvim/result.png" alt="thumbnail" width="100%">
	</figure>
</div>

こんな感じで意外と楽に任意のリンタが追加できます。また[Wiki](https://github.com/iamcco/diagnostic-languageserver/wiki/Linters)に設定例がたくさん紹介されているので、そちらも参考まで。
以上です。
