---
title: "HugoのビルドをGithub Actionで自動化する"
date: 2019-10-12T18:20:16+09:00
draft: true
---

台風が来て家に籠もるしかなくなったので，ブログのデザインをかえつつ，ビルドをGithub Actionsで自動化した．公開にはGithub Pagesを使っている．

<a class="dont-hightlight" href="https://github.com/raahii/raahii.github.io"><img src="https://gh-card.dev/repos/raahii/raahii.github.io.svg"></a>

基本的に [GitHub Actions による GitHub Pages への自動デプロイ](https://qiita.com/peaceiris/items/d401f2e5724fdcb0759d) のとおりにWorkflowを作ってやればできる．記事書いてくださった方自身が下記のワークフローのモジュールを公開されてるので神．

- [peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages) 
- [peaceiris/actions-hugo](https://github.com/peaceiris/actions-hugo)

付け加えるとすれば，公開に `<username>.github.io` の直下？を使っている方は注意．このURLを使うには，名前を `<username>.github.io` としたリポジトリでGithub Pagesを設定する必要があるが，公開するソースは`master` ブランチのルートでなければならない（本来であれば他のブランチや特定のディレクトリを指定できる）．そのため，そもそものビルド前のソースを `source` ブランチで管理することにして，workflowは `source` ブランチをビルドして `master` にプッシュするように変更した．

- [raahii.github.io/gh-pages.yml - GitHub](https://github.com/raahii/raahii.github.io/blob/source/.github/workflows/gh-pages.yml)

最近，研究に使ってるリポジトリにもGithub Actionsを設定したが，Dockerfileを使えば大体のことはできるし，直感的で使いやすい印象．ドキュメントはあまり充実してないので複雑なことはできないかもしれないが．今後も積極的に使っていこうと思う．
