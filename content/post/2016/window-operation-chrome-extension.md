+++
Categories = ["技術"]
Description = " http://dotinstall.com/lessons/basic_chrome_v2dotinstall.com  前回の記事でスターをつけてくださった方のブログを眺めていたらChromeの拡張機能を作っていて、Chromeの拡張機"
Tags = ["chrome", "web", "ネタ", "実装", "javascript"]
date = "2016-08-12T00:21:00+09:00"
title = "Chrome extensionに入門した"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/08/12/window-operation-chrome-extension", "/2016/08/window-operation-chrome-extension"]
+++

{{< rawhtml >}}
<body>
<p><a href="http://dotinstall.com/lessons/basic_chrome_v2">http://dotinstall.com/lessons/basic_chrome_v2</a><cite class="hatena-citation"><a href="http://dotinstall.com/lessons/basic_chrome_v2">dotinstall.com</a></cite></p>

<p>前回の記事でスターをつけてくださった方のブログを眺めていたら<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a>の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>を作っていて、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a>の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>ってHTML/<a class="keyword" href="http://d.hatena.ne.jp/keyword/CSS">CSS</a>/JSだけで作れるのか！ということを知りました。せっかくの機会なので入門して自分なりに簡単な<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>を作ってみました。</p>

<h2>モチベーション</h2>

<p>シンプルに<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a>を使っていて不便だと思う部分を解決するために作りました。</p>

<h2>私の考える問題点</h2>

<p>例えば、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a>で<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D6%A5%E9%A5%A6%A5%B8%A5%F3%A5%B0">ブラウジング</a>していて、最初はあることについて調べていたんだけど、気づいたら全く違うテーマのページを開いていた、なんてことありませんか？特に自分は学校の課題で調べ事してたんだけど退屈すぎていつの間にかネットサーフィンしてた、みたいなのがよくあります。</p>

<p>そんな時、そのウィンドウには、もともと調べていたテーマに関するタブと、新しく調べ始めたテーマに関するタブが混在してしまっている状態です。こういう時、テーマによってウィンドウを分けたくなります。そんなときみなさんどうしますか？単純にやるとこう↓なりませんか。</p>

<p>（左側3つのタブと右側2つのタブを切り分ける様子）</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160811/20160811231648.gif" alt="f:id:bonhito:20160811231648g:plain" title="f:id:bonhito:20160811231648g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>このようにブラウザって複数のタブに対してはあまり柔軟に操作できないなと感じます。とくにウィンドウをまたぐと辛い。そこでタブ（ウィンドウ）操作を柔軟にする<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>をつくりました。
　</p>

<h2>つくったもの</h2>

<p><iframe src="//hatenablog-parts.com/embed?url=https%3A%2F%2Fgithub.com%2Fpiyo56%2Ftabs_splitter" title="piyo56/tabs_splitter" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="https://github.com/piyo56/tabs_splitter">github.com</a></cite></p>

<p>　そのような流れで<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a><a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>の入門として↑を作りました。インポートすると右上にタブっぽいアイコンが出てきますので、これをクリックすると使うことができます。この<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>は、タブのかたまりに対して主に分割する機能（<code>split</code>）と、保存する機能（<code>store</code>、<code>bookmark</code>）で合計3つの機能を備えています。</p>

<h2>
<code>split</code>: 現在開いているタブを含め右側のタブを新しいウィンドウで開く</h2>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160811/20160811231649.gif" alt="f:id:bonhito:20160811231649g:plain" title="f:id:bonhito:20160811231649g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>一つのウィンドウに存在する異なるテーマのタブ群を分割(<code>split</code>)します。<code>split</code>ボタンを押すと、今開いている(activeな)タブを含め、そこから右側にあるタブを新しいウィンドウで開きます。</p>

<h2>
<code>store</code>: 今開いているウィンドウをWebStorageに一時保存</h2>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160811/20160811231650.gif" alt="f:id:bonhito:20160811231650g:plain" title="f:id:bonhito:20160811231650g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>保存したいタブ群をまず<code>split</code>で切り出した後に、保存したいウィンドウで<code>store</code>ボタンを押すとあなたのlocalStorageにウィンドウが保存されます。</p>

<p>他のデ<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D0%A5%A4">バイ</a>スで見たりするわけじゃないけど、少しの間しまっておきたい時に使います。取り出すときは、先ほどの<code>store</code>ボタンが<code>retrieve</code>ボタンになっているのでそれを押して下さい。</p>

<h2>
<code>bookmark</code>: 今開いているウィンドウのタブを全てブックマークする</h2>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160811/20160811231651.gif" alt="f:id:bonhito:20160811231651g:plain" title="f:id:bonhito:20160811231651g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p><code>store</code>機能は使っている端末のlocalStorageに保存するので、他の端末では開くことができません。もちろん<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%DE%A5%DB">スマホ</a>の<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a>では<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>自体が使えないので共有できません。そんなとき今開いているウィンドウの全てのタブを一括ブックマークできるのが<code>bookmark</code>ボタンです。</p>

<p><code>bookmark</code>ボタンを押すとパスの設定画面が現れます。新しいフォルダ名とそのフォルダをどこに置くかを決めて<code>save</code>ボタンを押してください。もしフォルダ名が空であった場合、新しくフォルダは作らずそのまま展開してブックマークされます。</p>

<h2>課題</h2>

<ul>
<li>
<p><code>store</code>機能の改善</p>

<p>  保持したウィンドウの情報を見れる機能、もう要らないって場合に捨てられる機能があったらよいかも。</p>
</li>
<li>
<p><code>split</code>できるなら<code>join</code>も？</p>

<p>  splitの逆で複数のwindowを1つにまとめられる機能があってもよいかも。</p>
</li>
<li>
<p>バグの修正</p>

<ul>
<li>初回のウィンドウに限って<code>split</code>がうまく動かない時がある。</li>
<li>jsの非同期処理による弊害をあんまり考慮せず作ったのでそのあたりを見直したい。</li>
</ul>
</li>
<li>
<p>popup.htmlを改良する</p>

<p>  最低限のデザインにしていきたいんだけど、レイアウトの仕方について要勉強。この手のページを作るとき、大体<code>HTML/CSS</code>を書くのに<code>JavaScript</code>と同じくらい時間かかるのもどうにかしたい。
  　</p>
</li>
<li>
<p>名前</p>

<p>  tabs_splitterなんかしっくりこない。英語的にもおかしい気がするしtabをキーワードとして残したい。</p>
</li>
</ul>


<h2>所感</h2>

<ul>
<li>
<p>ボタンの名前をどう表記するのがベスト？</p>

<p>  単に <code>split</code>？それとももっと詳しく <code>open right tabs in a new window</code>？あるいは日本語で <code>◯◯◯</code>？どれがわかりやすいんだろう。</p>
</li>
<li>
<p>機能をどの程度柔軟なものにするか</p>

<p>  現在の<code>store</code>機能と<code>bookmark</code>機能は、今開いているウィンドウの全てのタブに適用するので固定になっている。なので、ユーザーは任意のタブにたいしてこれらの機能を適用したい時には、</p>

<ol>
<li> ユーザー自身が保存したいタブをかためて右に寄せる。</li>
<li> 境界タブで<code>split</code>して保存したいタブを新しいウィンドウに切り出す。</li>
<li> <code>bookmark</code>を押してそのウィンドウを保存する。</li>
</ol>


<p>  というステップを踏む必要がある。もしこれが今開いているタブの一覧から選択できるようになれば、より柔軟で良い気がするんだけど、今の<code>split</code>との組み合わせで実現できるというのも結構シンプルで良いと思うので迷う。この方が<code>split</code>機能の良さを感じてもらえる気がする...。どうなんだろうか。</p>
</li>
<li>
<p>extensionに付与する権限って限定はできないのか？</p>

<p>  bookmarkを編集する権限ってかなり重いと思う。例えば「ためになる<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%C8%C4%A5%B5%A1%C7%BD">拡張機能</a>作りました！」と公開して<code>chrome.bookmark.remove(all)</code>みたいなことしたとしたらかなり深刻だと思う。bookmarkがいきなり消えて「え、あ、あらら」と慌てている間にあらゆるデ<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D0%A5%A4">バイ</a>スで一斉に同期が始まって...という光景は想像すると面白いけど（最低）。</p>

<p>  なのでユーザーがtabは良いけどbookmarkはダメ、みたいに権限の委譲を部分的に制限することはできないのか？と思ったり。まぁ仮にできたとしても、今回であれば<code>bookmark</code>ボタンを押して何も起こらなくなるだけなので万々歳だけど、世のextensionには複数の権限が必要な単一の機能ってのもいくらあるでしょうからね…。</p>
</li>
<li>
<p>時間をかけすぎた</p>

<p>   やってることはとてもシンプルなのに、考え始めてからページをつくり、中身を実装するのに結局丸3日くらい使ったので残念。もっとスピードがほしい。</p>
</li>
<li>
<p>普通に既出かな？</p>

<p>  特に新規性を求めたわけではないので良いけれど、既にこういう機能を提供するものはいくらでもあると思う。あるいは<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a>に元々こういう機能があるかもしれない。もしご存知のかたいたらコメントで教えていただけるとありがたいです。結構使いたいです。笑</p>
</li>
</ul>

</body>
{{< /rawhtml >}}
