+++
Categories = ["技術"]
Description = " こんにちは。EURO2016盛り上がってますね。みなさん見ていますか。明後日からはトーナメントが始まりますが僕の予想はコレです。    フランス優勝とイタリアが勝ち上がるとこがミソです。山が違っていたら決勝はイタリアvsフランスにしてまし"
Tags = ["macbook", "ネタ", "python"]
date = "2016-06-23T17:28:00+09:00"
title = "外部モニターで動画を見ると辛い"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/06/23/euro2016-result-prediction", "/2016/06/euro2016-result-prediction"]
+++

{{< rawhtml >}}
<body>
<p>こんにちは。<a href="http://jp.uefa.com/uefaeuro/season=2016/standings/index.html">EURO2016</a>盛り上がってますね。みなさん見ていますか。明後日からはトーナメントが始まりますが僕の予想はコレです。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160623/20160623154947.png" alt="f:id:bonhito:20160623154947p:plain:w500" title="f:id:bonhito:20160623154947p:plain:w500" class="hatena-fotolife" style="width:500px" itemprop="image"></span></p>

<p>フランス優勝とイタリアが勝ち上がるとこがミソです。山が違っていたら決勝はイタリアvsフランスにしてました。まぁぼく欧州サッカー全然知りませんけど笑</p>

<p>という感じで、最近はEURO2016の試合ハイライトをよく見るのですが、動画鑑賞においては<a class="keyword" href="http://d.hatena.ne.jp/keyword/Macbook%20Air">Macbook Air</a>が思ったより非力で辛いです。</p>

<p><b>特に、外部モニタで視聴すると、うなる。</b></p>

<p>ちなみに自分の<a class="keyword" href="http://d.hatena.ne.jp/keyword/MBA">MBA</a>は2013年モデルの11インチで、cpuはi7の方なのですが、普通に<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>のモニタで見ている分には特にcpu（ファン）は暴走しません。反対に、外部接続しているモニタは23インチで、これで見ているとcpuファンがかなり回り始めます。でかいモニタを使うとやはり<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%EC%A5%F3%A5%C0%A5%EA%A5%F3%A5%B0">レンダリング</a>とかの関係で重いんですかね？</p>

<p>ということで、ちょっと気になったので簡単に可視化してみました。</p>

<p>方法は<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>モニタと外部モニタでそれぞれ動画を最大化して視聴し、<a class="keyword" href="http://d.hatena.ne.jp/keyword/cpu%BB%C8%CD%D1%CE%A8">cpu使用率</a>を計測します。ちなみに<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google%20Chrome">Google Chrome</a>で<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%CB%A5%B3%A5%CB%A5%B3%C6%B0%B2%E8">ニコニコ動画</a>を見ました🍺。シンプル。</p>

<p>一応少し頑張って<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>を…。<a class="keyword" href="http://d.hatena.ne.jp/keyword/cpu%BB%C8%CD%D1%CE%A8">cpu使用率</a>を取得するのはshellscriptで、グラフ化は<a class="keyword" href="http://d.hatena.ne.jp/keyword/python">python</a>でやりました。</p>

<script src="https://gist.github.com/piyo56/9c752c7704845a154fd4036202309464.js"></script>


<p>んで結果、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>モニタの場合
<span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160623/20160623165841.png" alt="f:id:bonhito:20160623165841p:plain:w500" title="f:id:bonhito:20160623165841p:plain:w500" class="hatena-fotolife" style="width:500px" itemprop="image"></span>
外部モニタの場合
<span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20160623/20160623165839.png" alt="f:id:bonhito:20160623165839p:plain:w500" title="f:id:bonhito:20160623165839p:plain:w500" class="hatena-fotolife" style="width:500px" itemprop="image"></span></p>

<p>という感じでした。グラフの背景が白で汚い…。</p>

<p>とりあえず、外部モニタの場合，<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>のモニタに比べて30%近く<a class="keyword" href="http://d.hatena.ne.jp/keyword/cpu%BB%C8%CD%D1%CE%A8">cpu使用率</a>が高いという結果に。今回は<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>を起動した後に、<a class="keyword" href="http://d.hatena.ne.jp/keyword/GoogleChrome">GoogleChrome</a>だけを立ち上げて動画を視聴という流れで揃えたので、これでも<a class="keyword" href="http://d.hatena.ne.jp/keyword/cpu%BB%C8%CD%D1%CE%A8">cpu使用率</a>は差が出てない方だと思います。普段からなんとなーく<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A2%A5%AF%A5%C6%A5%A3%A5%D3%A5%C6%A5%A3%A5%E2%A5%CB%A5%BF">アクティビティモニタ</a>を開いて見たりしていますが、他のタブや他のアプリケーションを同時に開いていると、二倍近く差が出る時もあった気がします。やっぱりcpuが非力だと外部モニタって負荷でかいんですね…。</p>

<p>あと、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>は<a class="keyword" href="http://d.hatena.ne.jp/keyword/Intel">Intel</a>のcpuを積んでいるので、いい感じに<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AA%A1%BC%A5%D0%A1%BC%A5%AF%A5%ED%A5%C3%A5%AF">オーバークロック</a>して処理性能を上げる「Turbo Boost」という機能がついているみたい。ただ、排熱効率に優れない<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>の場合これが原因でcpu温度がみるみる上昇していきます。cpu負荷が大きいプロセスを実行すると、このおせっかい機能によって<a class="keyword" href="http://d.hatena.ne.jp/keyword/%C7%AE%CB%BD%C1%F6">熱暴走</a>がおきてcpuファンの回転に拍車をかける─ これも原因の一つかなぁ。まぁそんな感じです。</p>

<p>あと今回書いた<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>の方は、<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B7%A5%A7%A5%EB%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">シェルスクリプト</a>でpsコマンドの出力をcutできなくてちょっと躓きました。結局<a class="keyword" href="http://d.hatena.ne.jp/keyword/awk">awk</a>で解決したので、もっと<a class="keyword" href="http://d.hatena.ne.jp/keyword/awk">awk</a>を使いこなしたい。あと、<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B7%A5%A7%A5%EB%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">シェルスクリプト</a>はスペースが入る文字列を扱うときにわけわからなくなったりするので"と'の違いとかをちゃんと覚えないとダメかも。日頃からもっと頻繁に書いていきたいです。</p>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>の方は去年一年間使ったのでわりとスラスラ書けた。最近は<a class="keyword" href="http://d.hatena.ne.jp/keyword/C/C%2B%2B">C/C++</a>ばっかり使っているのであれだけど、やっぱりメソッドチェーンは慣れないと読みづらい気がする。matplotlibはとても使いやすいので好き。</p>

<p></p>
<div class="hatena-asin-detail">
<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4879667943/hatena-blog-22/"><img src="http://ecx.images-amazon.com/images/I/21QeHe0bIqL._SL160_.jpg" class="hatena-asin-detail-image" alt="grep,sed,awk" title="grep,sed,awk"></a><div class="hatena-asin-detail-info">
<p class="hatena-asin-detail-title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4879667943/hatena-blog-22/">grep,sed,awk</a></p>
<ul>
<li>
<span class="hatena-asin-detail-label">作者:</span> 美吉明浩</li>
<li>
<span class="hatena-asin-detail-label">出版社/メーカー:</span> <a class="keyword" href="http://d.hatena.ne.jp/keyword/%BD%A8%CF%C2%A5%B7%A5%B9%A5%C6%A5%E0">秀和システム</a>
</li>
<li>
<span class="hatena-asin-detail-label">発売日:</span> 1998/05/29</li>
<li>
<span class="hatena-asin-detail-label">メディア:</span> 単行本</li>
<li><a href="http://d.hatena.ne.jp/asin/4879667943/hatena-blog-22" target="_blank">この商品を含むブログを見る</a></li>
</ul>
</div>
<div class="hatena-asin-detail-foot"></div>
</div>

<p>コレ読みたい。それでは。</p>
</body>
{{< /rawhtml >}}
