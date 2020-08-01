+++
Categories = ["技術"]
Description = " 近況  インターンに行ってJavaを用いたWebアプリケーション開発を経験してきました。  もともとサーバーサイドの方の知識は0に近く、データベースとかサーバーってめんどくさそう…くらいの認識でした。今回その辺りのコーディングをいくつか担"
Tags = ["macbook","python","ネタ","cli","imgcat"]
date = "2016-09-21T23:10:00+09:00"
title = "imgcatコマンドで遊ぶ"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/09/21/show-lgtm-using-giphy-and-imgcat", "/2016/09/show-lgtm-using-giphy-and-imgcat", "/2016/09/231012"]
+++

{{< rawhtml >}}
<body>
<h1>近況</h1>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%F3%A5%BF%A1%BC%A5%F3">インターン</a>に行って<a class="keyword" href="http://d.hatena.ne.jp/keyword/Java">Java</a>を用いたWebアプリケーション開発を経験してきました。</p>

<p>もともとサーバーサイドの方の知識は0に近く、データベースとかサーバーってめんどくさそう…くらいの認識でした。今回その辺りのコーディングをいくつか担当させて頂き、Webアプリの全体像が見えた気がします。とりあえず、Webアプリ開発を一通り経験したというのはとても大きな意味がありました。</p>

<p>また、チーム開発が初めてだったこともあり、Gitを初めて実践的に使った他、かんばんや<a class="keyword" href="http://d.hatena.ne.jp/keyword/KPT">KPT</a>といった<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A2%A5%B8%A5%E3%A5%A4%A5%EB">アジャイル</a>的な開発手法にも触れられたのも楽しかったです。</p>

<h1>imgcatコマンド</h1>

<p>がらっと話は変わりますが本題。みなさんimgcatというコマンドをご存知でしょうか。おそらくiTerm上でしか動かない…と思いますが、ターミナル上で画像を表示するコマンドです。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160921/20160921220429.png" alt="f:id:bonhito:20160921220429p:plain" title="f:id:bonhito:20160921220429p:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>これ、一見ネタのようなコマンドですが、Qiitaにはこんな記事が投稿されています。</p>

<p><iframe src="//hatenablog-parts.com/embed?url=http%3A%2F%2Fqiita.com%2Fuiureo%2Fitems%2Fbe92c8fdaeaec9b506e4" title="画像処理をするときに、iTermの画像表示機能が便利 - Qiita" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="http://qiita.com/uiureo/items/be92c8fdaeaec9b506e4">qiita.com</a></cite></p>

<p><s>いや、やっぱりネタかもしれない。</s></p>

<p>こんなimgcatですが、もしかしたらこれってすごい力を秘めているのではないかと私は思いました。というのも、黒い画面というのはどうしても地味になりがちで、長時間コーディングをすると精神的に良くないと感じるからです。これを使えばもしかしたらターミナルが賑やかになるかもしれない...！</p>

<h1>GIPHYからGIF画像を取得して表示する</h1>

<p>ということで、いつまでも自分の手元にある画像を見ていても面白くないのでネットから拾ってきます。最初は<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a>画像検索を使おうと思っていましたが、最終的に<a href="http://giphy.com/">GIPHY</a>というサイトの<a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>を使って<b>GIF画像</b>を取ることにしました。そうです、imgcatでGIF画像を表示するとちゃんと動くんです！できたものはこんな感じ。</p>

<p>猫。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160921/20160921221902.gif" alt="f:id:bonhito:20160921221902g:plain" title="f:id:bonhito:20160921221902g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D4%A5%AB%A5%C1%A5%E5%A5%A6">ピカチュウ</a>。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160921/20160921221919.gif" alt="f:id:bonhito:20160921221919g:plain" title="f:id:bonhito:20160921221919g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>カートマン。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160921/20160921221936.gif" alt="f:id:bonhito:20160921221936g:plain" title="f:id:bonhito:20160921221936g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>GIPHYは海外サイトなので日本語では検索できませんが、結構素材は豊富っぽいです。</p>

<h1><a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%BD%A1%BC%A5%B9%A5%B3%A1%BC%A5%C9">ソースコード</a></h1>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>で書きました。簡単ですが...。
コレくらいだったら<a class="keyword" href="http://d.hatena.ne.jp/keyword/wget">wget</a>とかで<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%EF%A5%F3%A5%E9%A5%A4%A5%CA%A1%BC">ワンライナー</a>で書けたりしそう。どうだろう。</p>

<p>手順はこんな感じです。</p>

<ol>
<li><p><a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B3%A5%DE%A5%F3%A5%C9%A5%E9%A5%A4%A5%F3">コマンドライン</a>引数で検索ワードを受け取る</p></li>
<li><p>GIPHYの<a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>を使って画像を検索し、結果からランダムに一つをピックアップする</p></li>
<li><p>選んだ画像のURLにHTTPリクエストを投げてかえってきた画像データをそのまま<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D0%A5%A4">バイ</a>ナリで標準出力に流す</p></li>
<li><p>imgcatにリダイレクトする</p></li>
</ol>


<p><a href="https://api.giphy.com/">GIPHYのAPI</a>は<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a>のCustom Search <a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>と違って（おそらく）制限がないのと、現在public beta keyを出してくれてるので使うのが楽でした。</p>

<p>また、今回使った検索以外にもトレンドの画像の取得や絵文字からGIFへの変換など色々できるようで今度使ってみたいなと思います。</p>

<script src="https://gist.github.com/piyo56/16677e921788d9c911546e577ca303d5.js"></script>


<h1>応用例</h1>

<p>さて、そもそもこれを作ったワケというのは、黒い画面を眺め続け疲弊した心に安らぎをあたえてやることでした。</p>

<p>一つ考えた例として<b><code>git commit</code>する度に好きなテーマの画像が表示されるようにします</b>。zshrcに以下を追加。</p>

<script src="https://gist.github.com/piyo56/6fd9e6213422f4c620cbc95e537dbd16.js"></script>


<p>すると…</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160921/20160921222816.gif" alt="f:id:bonhito:20160921222816g:plain" title="f:id:bonhito:20160921222816g:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>予想外に地味😇。　今回は検索ワードを"LGTM"にしましたが、猫でいいかも。<code>git commit</code>を<code>mycommit</code>に置き換えなきゃいけないのはスマートじゃないですね。</p>

<p>ということで、みなさんもくれぐれも心のケアは大切にして下さい（適当）。</p>

<h1>終わりに</h1>

<p>こういうの作ってる最中はいいんだけど、作り終わった後の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B8%AD%BC%D4%A5%BF%A5%A4%A5%E0">賢者タイム</a>の辛さ…ね…。</p>

<h1>所感</h1>

<ul>
<li>
<p>拾ってくる画像</p>

<p>  <a class="keyword" href="http://d.hatena.ne.jp/keyword/Twitter">Twitter</a>からとってきても面白いかも。</p>
</li>
<li>
<p>最後の使い方の例のところ改良の余地有り</p>

<p>  元々<code>git commit</code>したら画像を表示するというのは、たまたま見かけた<a href="http://qiita.com/b4b4r07/items/8cf5d1c8b3fbfcf01a5d">cdしたらlsする</a>という記事にヒントを得たものでした。なので本当は<code>git commit() { \gitcommit "$@" &amp;&amp; [GIF画像表示}</code>のような感じにしたかったのですが、ちょっとうまくいきませんでした。今後改良したい。
  　</p>
</li>
<li>
<p>画像が表示されるまで1〜3秒かかる</p>

<p>  お茶でも飲んで一息つきましょう...。</p>
</li>
</ul>

</body>
{{< /rawhtml >}}
