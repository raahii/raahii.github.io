+++
Categories = ["技術"]
Description = " タイトルの通りGoogle Maps APIを使って、出発地点から目的地点までの高低差を可視化する簡単なサイトを作ってみました。  ルートに沿った標高の可視化  github.com  きっかけとしては、新生活に伴い、家から大学までのルー"
Tags = ["web", "ネタ", "実装"]
date = "2016-07-24T15:50:00+09:00"
title = "Google Maps APIを使った標高の可視化"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/07/24/visualize-elevation-along-the-route", "/2016/07/visualize-elevation-along-the-route", "/2016/07/155027"]
+++

{{< rawhtml >}}
<body>
<p>タイトルの通り<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google%20Maps%20API">Google Maps API</a>を使って、出発地点から目的地点までの高低差を可視化する簡単なサイトを作ってみました。</p>

<p><a href="https://piyo56.github.io/elevation/">ルートに沿った標高の可視化</a></p>

<p><iframe src="//hatenablog-parts.com/embed?url=https%3A%2F%2Fgithub.com%2Fpiyo56%2Felevation" title="piyo56/elevation" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="https://github.com/piyo56/elevation">github.com</a></cite></p>

<p>きっかけとしては、新生活に伴い、家から大学までのルートの高低差を知りたかったからです。</p>

<p>個人的な話ですが、今年から大学に進学しまして一人暮らしを始めました。一人暮らしにあたっては家賃はもちろんですが、家から学校までの距離が一つ重要な要素ですよね。近いに越したことはないとは思いますが、スーパーやコンビニのあるなしで利便性が大きく変わるので、少々遠くても自転車で通えればOKです。まぁ10km前後になると夏は汗だくで授業を受けるはめになりますが...。</p>

<p>そんなとき、加えて重要なのが、<b>高低差</b>じゃないでしょうか。アップダウンが激しいと辛いですよね。そんな具合で春頃に実際にそれを調べたいなと思った時、何故かそういうサービスがあまりなかったので<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google%20Maps%20API">Google Maps API</a>を使って自分で作って可視化してみてました。</p>

<p>最近では<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%ED%A1%BC%A5%C9%A5%D0%A5%A4%A5%AF">ロードバイク</a>や<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AF%A5%ED%A5%B9%A5%D0%A5%A4%A5%AF">クロスバイク</a>に乗る人が増えて、<a href="http://gihyo.jp/book/pickup/2016/0047">ランニングする人</a>も多くなってきているので、結構使いたい人はいるんじゃないかと思っています。元々自分なりに春先には作っていたものを綺麗にしてWebサイト作りの練習として公開してみました。とはいってもHTML/<a class="keyword" href="http://d.hatena.ne.jp/keyword/CSS">CSS</a>/JSだけの本当に簡単な試作品のレベルですが。</p>

<p>先ほど言ったとおり、このサイトでは<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google%20Maps%20API">Google Maps API</a>を使っていて、出発地と目的地を入力すると自動でルート検索が行われて、ルートに沿った高低差が可視化されます。もともとそういう関数があるのでものすごく実装は簡単なんですが、<b>ルートにそって高低差が出せる</b>ってとこが重要です。<a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>は無料で使う分には<a href="https://developers.google.com/maps/pricing-and-plans/#details">up to 25,000 map loads per day</a>なのでサービスとしてはちゃんとしたものはできていませんが、今後ルートの<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B8%F5%CA%E4">候補</a>を選べるようにしたり、ルートごとの高低差の違いを同時に見れたりしたら便利かなと思っています。</p>

<p>とまぁ、そんなこんなで最近はWeb系に興味がでてきたので、夏に集中的に勉強できたらなと思います。制作実績がないと<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%F3%A5%BF%A1%BC%A5%F3">インターン</a>も厳しいので、コツコツ夏に勉強して冬の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%F3%A5%BF%A1%BC%A5%F3">インターン</a>を狙っていきたいと思います。それでは。</p>

<hr>

<p>今よくよく探してみると、</p>

<ul>
<li><p><a href="http://www.navitime.co.jp/maps/routeResult?start=%7b%22node%22%3a%2200006668%22%2c%22lon%22%3a503160751%2c%22name%22%3a%22%E6%9D%B1%E4%BA%AC%22%2c%22road-type%22%3a%22default%22%2c%22lat%22%3a128451742%7d&amp;start-time=2016-07-24T15%3a26%3a16&amp;goal=%7b%22node%22%3a%2200004254%22%2c%22lon%22%3a502922413%2c%22name%22%3a%22%E6%96%B0%E5%AE%BF%22%2c%22road-type%22%3a%22default%22%2c%22lat%22%3a128482502%7d&amp;bicycle=only.multi.turn">地図検索 - NAVITIME</a></p></li>
<li><p><a href="http://latlonglab.yahoo.co.jp/route/">ルートラボ - LatLongLab</a></p></li>
<li><p><a href="https://www.flattestroute.com/">Flattest Route</a></p></li>
</ul>


<p>と、機能や完成度・他サービスとの連携はまちまちですが既存のものも意外にありますね。(笑)</p>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/NAVITIME">NAVITIME</a>は坂の少ない／多いルートを選べ、かつ所要時間も出ていて素晴らしいです。ただちょっと図が小さめ。<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%EB%A1%BC%A5%C8%A5%E9%A5%DC">ルートラボ</a>はパッと検索するというよりは、ユーザー同士が作ったルートをシェアできる機能があって独特なサービスです。Flattest Routeはなんか動かない。とはいえ、今回の題材はコンセプトとしては意外と悪くなかったかなと思います。</p>
</body>
{{< /rawhtml >}}
