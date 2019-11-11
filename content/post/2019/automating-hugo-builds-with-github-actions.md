+++
title = "HugoのビルドをGithub Actionで自動化する"
date = 2019-10-12T18:20:16+09:00
categories = ["技術"]
tags = ["golang", "Github Actions", "Hugo"]
draft = false
description = "Github Actionを使って，git push時に自動でhugoのリソースをビルドして公開する方法について"
aliases = ["/2019/10/12/automating-hugo-builds-with-github-actions", "/2019/10/automating-hugo-builds-with-github-actions"]
+++

台風が来て家に籠もるしかなくなったので，ブログのデザインをかえつつ，HugoのビルドをGithub Actionsで自動化した．公開にはGithub Pagesを使っている．

<a class="dont-hightlight" href="https://github.com/raahii/raahii.github.io"><img src="https://gh-card.dev/repos/raahii/raahii.github.io.svg"></a>

基本的に

> [GitHub Actions による GitHub Pages への自動デプロイ](https://qiita.com/peaceiris/items/d401f2e5724fdcb0759d) 

のとおりにWorkflowを作ればできます．記事書いてくださった方自身が次のようなモジュールを公開されてるので神．

- [peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages) 
- [peaceiris/actions-hugo](https://github.com/peaceiris/actions-hugo)

あえて注意点を上げるとすると，公開に `<username>.github.io` の直下？を使っている場合．このURLを使うには，名前を `<username>.github.io` としたリポジトリでGithub Pagesを設定する必要があるが，公開するソースは`master` ブランチのルートでなければならない（本来であれば他のブランチや特定のディレクトリを指定できる）．よって先の記事のような `gh-pages` ブランチにプッシュするやり方では実現できない．

そこで今回は，そもそも `source` ブランチをデフォルトブランチとすることにして，workflowでビルドしたものを `master` にプッシュするように変更した．

- [raahii.github.io/gh-pages.yml - GitHub](https://github.com/raahii/raahii.github.io/blob/source/.github/workflows/gh-pages.yml)

最近，研究に使ってるリポジトリにもGithub Actionsを設定したが，Dockerfileを使えば大体のことはできるし，直感的で使いやすい印象．ただドキュメントはあまり充実してないので複雑なことはできないかもしれない（以前もDockerfileのbuildのキャッシングがまだできないようだった）．今後も積極的に使っていこうと思う．



最後に，これは余談ですが，今回採用した[Lithium](https://themes.gohugo.io/hugo-lithium-theme/)というテーマにコードブロックのデザインが無かったので足してみました．Hugoのバージョン0.28以降には[Chroma](https://github.com/alecthomas/chroma)というGo製のシンタックスハイライターがついていて，設定ファイルに書き足すだけで色付けできるので便利ですね（今回はそもそも コードブロックの要素自体にcssが当たってなかったので外枠のデザインは作りました）．Hugoも相変わらずとっても良きです．

- [Syntax Highlighting | Hugo](https://gohugo.io/content-management/syntax-highlighting/#generate-syntax-highlighter-css)
