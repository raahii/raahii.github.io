+++
Categories = ["技術"]
Description = " 近況   夏休みが今週いっぱいで終わる  今週rubyとrailsに入門した   開発環境  ruby、railsは現在チュートリアルをやってるような感じで特に書くことはないのだけれど、それらを始めてから急に同時に多くのファイルを編集する"
Tags = ["vim", "web","ruby","rails","インターン"]
date = "2016-09-30T02:02:00+09:00"
title = "最近の開発環境におけるTips"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/09/30/recent-reports-sep", "/2016/09/recent-reports-sep"]
+++

{{< rawhtml >}}
<body>
<h2>近況</h2>

<ul>
<li>夏休みが今週いっぱいで終わる</li>
<li>今週<a class="keyword" href="http://d.hatena.ne.jp/keyword/ruby">ruby</a>と<a class="keyword" href="http://d.hatena.ne.jp/keyword/rails">rails</a>に入門した</li>
</ul>


<h2>開発環境</h2>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/ruby">ruby</a>、<a class="keyword" href="http://d.hatena.ne.jp/keyword/rails">rails</a>は現在<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C1%A5%E5%A1%BC%A5%C8%A5%EA%A5%A2%A5%EB">チュートリアル</a>をやってるような感じで特に書くことはないのだけれど、それらを始めてから急に<b>同時に多くのファイルを編集する機会が多くなってきました</b>。なので、最近気づいたコードを書くときのコツ、<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>のいい感じの使い方を少しメモしておきます。</p>

<h2>① NERDTreeと画面分割を使う</h2>

<p>プロジェクトのルートでNerdTreeを開きながら水平分割(s)を使うといろんなファイルをすぐ開けて便利です。加えてNERDTreeはファイルの作成/削除などの基本操作もできるので<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>の中で結構完結します。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160930/20160930011827.png" alt="f:id:bonhito:20160930011827p:plain" title="f:id:bonhito:20160930011827p:plain" class="hatena-fotolife" itemprop="image"></span></p>

<h2>② タブページ機能を使ってファイルをうまく仕分ける</h2>

<p>Model、View、Controller、設定ファイルといったコードのかたまりをタブを利用して分けてあげると使いやすい。もちろんタブ間の移動は使いやすいキーに<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D0%A5%A4">バイ</a>ンドしておく必要があります。ファイルを新しいタブで開くときもNERDTreeはtでできるので楽ちんです。
<span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160930/20160930012918.png" alt="f:id:bonhito:20160930012918p:plain" title="f:id:bonhito:20160930012918p:plain" class="hatena-fotolife" itemprop="image"></span></p>

<h2>③ 作業の中断・開始にはセッションを使う</h2>

<p>これまで書いたようにファイルは整理しながらたくさん開くので、必然的にその状況を保存したいなぁとなります。以下の記事にわかりやすく書いてあるのですが、<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>では<code>:mks</code>で現在開いているバッファやウィンドウの状態を保存してくれます。記事では~/.Session.<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>に保存されると書いてあるのですが、私の環境では標準でカレント<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リ（./Session.<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>）に作成されました。この方がわかりやすいので私は好きです。
<iframe src="http://keyamb.hatenablog.com/embed/2013/07/12/020730" title="Vimでセッションの保存と読込み - weblog of key_amb" class="embed-card embed-blogcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 190px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="http://keyamb.hatenablog.com/entry/2013/07/12/020730">keyamb.hatenablog.com</a></cite></p>

<h2>④ エディタとシェルはもう分けちゃったほうがよい</h2>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>を開いている状態から<a class="keyword" href="http://d.hatena.ne.jp/keyword/rails">rails</a>やgitのコマンドを打つためにシェルに戻るのは結構めんどくさいです。今までは<code>:shell</code>と打って抜けるやり方が好きでしたが、最近<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>を抜けてから<a class="keyword" href="http://d.hatena.ne.jp/keyword/zsh">zsh</a>が入力を受け付けるまでが結構遅いことに気づき、iTermのウィンドウをそもそも分けることにしました。<a class="keyword" href="http://d.hatena.ne.jp/keyword/zsh">zsh</a>がちょっと重いらしく、あんまり使いこなせてもいないので<a class="keyword" href="http://d.hatena.ne.jp/keyword/bash">bash</a>にしようかなと思ってます。あと、VimShellとかfugitiveはあんまり合いませんでした。</p>

<hr>

<h2>所感</h2>

<ul>
<li>やっぱり大きめのモニタあると捗る</li>
<li>エディタとシェルを分けちゃうと<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>の存在意義が薄れてきている気が</li>
<li>
<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>は操作といい色々柔軟できるけどそろそろ<a class="keyword" href="http://d.hatena.ne.jp/keyword/IDE">IDE</a>も試してみようかな…</li>
</ul>

</body>
{{< /rawhtml >}}
