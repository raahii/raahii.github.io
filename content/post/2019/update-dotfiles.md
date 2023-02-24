+++
title = "dotfilesを整備した"
date = 2019-02-13T00:13:24+09:00
categories = ["技術"]
tags = ["dotfile", "golang", "インターン"]
draft = false
description = "デフォルトシェルをfishに変えて，makefileで自動インストールできるようにdotfileを改善した"
aliases = ["/2019/02/13/update-dotfiles", "/2019/02/update-dotfiles"]
canonicalUrl = "https://raahii.me/posts/update-dotfiles/"
+++



最近インターンが始まり、そのとき開発環境の構築に手間取ったので「やらねば…」となった．正直始まる前にやっとけやという感じなので反省．

前々からGithubで管理はしていたものの、`fish`に移行してからほったらかしになっていたので、今回、要らないものをぶち消して、`make`と`setup.sh`で自動的にインストール、アンインストール、更新など出来るようにした．

ついでに、deinの設定をtomlにして、そこに各パッケージの設定を書くことで`.vimrc`をスッキリさせた．久しく触ってなかったBrewfileも更新して、iTermの設定もダンプしたので、大分環境構築しやすくなったと思う．めでたし．

ところで前は`zsh`だったけれど`fish`はデフォルトでも使える感じなのが良いですね．若干気になる点もあって，まず`tmux`との相性が良くない印象です．コマンドの補完や`peco`の画面から戻った後にコンソールがずれるのは自分だけ…？

あとは…文法が違うのもたまに気になりますが、これは慣れですね．ブラウザやSlackからコピーして実行したらシンタックスエラーでコケてあれっとなります．でも最近`&&`や`||`が[サポートされたよう](https://github.com/fish-shell/fish-shell/issues/4620)ですし，全体的にとても使いやすいので良い感じです．

ついでに，プロンプトのテーマは今んとこ[pure](https://github.com/brandonweiss/pure.fish)をちょっと改造したやつを使ってます．個人的に2行のやつが良くて、1行目にカレントディレクトリやgitの情報、2行目にインプットのが使いやすいと思ってます．カレントディレクトリを深く掘っても入力のスペースに影響がないからです．もしおすすめがあったら教えてください．



てな感じで、相変わらず`tmux`+`vim`で開発してます．インターンではGoを書いていて，やっぱりシンプルなところがいいなと思います．がんばります．



{{< rawhtml >}}
<div style="height:10px;"></div>

<div style="display: flex;justify-content: center;align-items: center; height:160px;">
  <div class="github-card" data-github="raahii/dotfiles" data-width="70%" data-height="150" data-theme="default" style="margin: 0 auto;"></div>
</div>
<script src="//cdn.jsdelivr.net/github-cards/latest/widget.js"></script>

{{< /rawhtml >}}
