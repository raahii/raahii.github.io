+++
Categories = ["技術"]
Description = " タイトルの通りwebサービス作りました。またしてもGoogle Mapを使ってしまった。  https://fashion-shop-map.herokuapp.com/  サービス概要  今回作ったものは、ファッションのショップの位置情"
Tags = ["作品", "web", "ファッション", "rails", "ruby"]
date = "2016-11-26T01:36:00+09:00"
title = "Fashion Shop Mapというwebサービスをつくった"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/11/26/web-service-fashion-shop-map", "/2016/11/web-service-fashion-shop-map"]
+++

{{< rawhtml >}}
<body>
<p>タイトルの通り<a class="keyword" href="http://d.hatena.ne.jp/keyword/web%A5%B5%A1%BC%A5%D3%A5%B9">webサービス</a>作りました。またしても<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Mapを使ってしまった。</p>

<p><a href="https://fashion-shop-map.herokuapp.com/">https://fashion-shop-map.herokuapp.com/</a></p>

<h1>サービス概要</h1>

<p>今回作ったものは、ファッションのショップの位置情報を検索することができるサービスです。これを使うことで、複数のショップの位置を同時に地図にプロットして見ることができます。</p>

<p>ユーザーの操作はとてもシンプルで、検索したいショップと<a class="keyword" href="http://d.hatena.ne.jp/keyword/%C5%D4%C6%BB">都道</a>府県を選択してボタンを押すと、選択された<a class="keyword" href="http://d.hatena.ne.jp/keyword/%C5%D4%C6%BB">都道</a>府県内にある店舗が地図上に<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%DE%A5%C3%A5%D4%A5%F3%A5%B0">マッピング</a>されます。</p>

<p>機能としてはシングルページのwebサイトに近いくらいシンプルです。現在は主に<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%BB%A5%EC%A5%AF%A5%C8%A5%B7%A5%E7%A5%C3%A5%D7">セレクトショップ</a>を取り扱っており、以下のようなショップが登録されています。</p>

<table>
<thead>
<tr>
<th style="text-align:center;">ロゴ</th>
<th style="text-align:center;">名前</th>
<th style="text-align:center;">ロゴ</th>
<th style="text-align:center;">名前</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161124/20161124230822.png" alt="f:id:bonhito:20161124230822p:plain" title="f:id:bonhito:20161124230822p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;"><a class="keyword" href="http://d.hatena.ne.jp/keyword/BEAMS">BEAMS</a></td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161124/20161124230835.png" alt="f:id:bonhito:20161124230835p:plain" title="f:id:bonhito:20161124230835p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;"><a class="keyword" href="http://d.hatena.ne.jp/keyword/UNITED%20ARROWS">UNITED ARROWS</a></td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005139.png" alt="f:id:bonhito:20161125005139p:plain" title="f:id:bonhito:20161125005139p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">
<a class="keyword" href="http://d.hatena.ne.jp/keyword/UNITED%20ARROWS">UNITED ARROWS</a> BEAUTY&amp;YOUTH</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161124/20161124230852.png" alt="f:id:bonhito:20161124230852p:plain" title="f:id:bonhito:20161124230852p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">
<a class="keyword" href="http://d.hatena.ne.jp/keyword/UNITED%20ARROWS">UNITED ARROWS</a> <a class="keyword" href="http://d.hatena.ne.jp/keyword/green%20label%20relaxing">green label relaxing</a>
</td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005211.png" alt="f:id:bonhito:20161125005211p:plain" title="f:id:bonhito:20161125005211p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;"><a class="keyword" href="http://d.hatena.ne.jp/keyword/URBAN%20RESEARCH">URBAN RESEARCH</a></td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005216.png" alt="f:id:bonhito:20161125005216p:plain" title="f:id:bonhito:20161125005216p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">
<a class="keyword" href="http://d.hatena.ne.jp/keyword/URBAN%20RESEARCH">URBAN RESEARCH</a> DOORS</td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005220.png" alt="f:id:bonhito:20161125005220p:plain" title="f:id:bonhito:20161125005220p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;"><a class="keyword" href="http://d.hatena.ne.jp/keyword/SHIPS">SHIPS</a></td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005311.png" alt="f:id:bonhito:20161125005311p:plain" title="f:id:bonhito:20161125005311p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">EDIFICE</td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005319.png" alt="f:id:bonhito:20161125005319p:plain" title="f:id:bonhito:20161125005319p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">417 EDIFICE</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005224.png" alt="f:id:bonhito:20161125005224p:plain" title="f:id:bonhito:20161125005224p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">JOURNAL STANDARD</td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005228.png" alt="f:id:bonhito:20161125005228p:plain" title="f:id:bonhito:20161125005228p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">coen</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005233.png" alt="f:id:bonhito:20161125005233p:plain" title="f:id:bonhito:20161125005233p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;"><a class="keyword" href="http://d.hatena.ne.jp/keyword/A.P.C.">A.P.C.</a></td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005237.png" alt="f:id:bonhito:20161125005237p:plain" title="f:id:bonhito:20161125005237p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">BShop</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005242.png" alt="f:id:bonhito:20161125005242p:plain" title="f:id:bonhito:20161125005242p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">SENSE OF PLACE by <a class="keyword" href="http://d.hatena.ne.jp/keyword/URBAN%20RESEARCH">URBAN RESEARCH</a>
</td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005246.png" alt="f:id:bonhito:20161125005246p:plain" title="f:id:bonhito:20161125005246p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">HARE</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005252.png" alt="f:id:bonhito:20161125005252p:plain" title="f:id:bonhito:20161125005252p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">RAGEBLUE</td>
</tr>
<tr>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005257.png" alt="f:id:bonhito:20161125005257p:plain" title="f:id:bonhito:20161125005257p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;"><a class="keyword" href="http://d.hatena.ne.jp/keyword/GLOBAL%20WORK">GLOBAL WORK</a></td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125005345.png" alt="f:id:bonhito:20161125005345p:plain" title="f:id:bonhito:20161125005345p:plain" class="hatena-fotolife" itemprop="image"></span></td>
<td style="text-align:center;">
<a class="keyword" href="http://d.hatena.ne.jp/keyword/FREAK">FREAK</a>'S STORE</td>
</tr>
</tbody>
</table>


<h1>モチベーション</h1>

<p>まず服が好きなので、それに関わるサービスを作りたいなと思っていました。</p>

<p>一番コアな動機としては、いろんなショップがどこにあるのかもっと手軽に見たい！と普段から感じていたことでした。私が服を見ようと思ったら、まず一覧性のあるWebで見て、その後チェックした服を実際に見に行きたいなと思うのですが、大体</p>

<p><b>「よっしゃ、週末服見に行こう。できれば1か所で<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D3%A1%BC%A5%E0%A5%B9">ビームス</a>と<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%E6%A5%CA%A5%A4%A5%C6%A5%C3%A5%C9%A5%A2%A5%ED%A1%BC%A5%BA">ユナイテッドアローズ</a>とアーバンリサーチは見たいよな」</b></p>

<p>という流れ（あくまで例ですが）になります。しかしこの時、現状だとそれらのショップがどこにあるのか、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Mapや各ショップの公式ページを見て一つずつ探さななければなりません。</p>

<p>この体験から<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> MapはAND検索に弱いなと感じ、ファッションに特化した地図を作ろうと思いました。これはサイトの<a href="https://fashion-shop-map.herokuapp.com/about">aboutページ</a>にも簡単に書いています。</p>

<p>最後にもう一つ理由があり、比較的取り扱うエンティティがシンプルだったことがあります。<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D5%A5%EC%A1%BC%A5%E0%A5%EF%A1%BC%A5%AF">フレームワーク</a>を使って動的なアプリケーションを作るのはほとんど初めてだったので、DB設計が難しそうな<a class="keyword" href="http://d.hatena.ne.jp/keyword/SNS">SNS</a>などは考えていませんでした。</p>

<h1>開発の話</h1>

<p>このサービスは<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby%20on%20Rails">Ruby on Rails</a>、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Map、Bootstrap、<a class="keyword" href="http://d.hatena.ne.jp/keyword/jQuery">jQuery</a>を用いて作成しました。デプロイはherokuなのでスリープしてしまうと最初のページ読み込みが遅いです。</p>

<p>制作を始めてから現在までおよそ2ヵ月くらい経過しています。後ほど触れますが時間をかけてすぎてしまったのは反省点の一つです。</p>

<p>流れとしてはまず、9月末に<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>と<a class="keyword" href="http://d.hatena.ne.jp/keyword/Rails">Rails</a>に同時に入門しました。<a class="keyword" href="http://d.hatena.ne.jp/keyword/Rails">Rails</a>は<a href="https://techacademy.jp/magazine/5910">おすすめのチュートリアル集</a>で紹介されているものの内、短めのものを4つくらいこなすとすぐに流れがつかめました。夏の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%F3%A5%BF%A1%BC%A5%F3">インターン</a>で<a class="keyword" href="http://d.hatena.ne.jp/keyword/MVC">MVC</a>の考え方をつかんでいたのも良かったなと思っています。</p>

<p>その後この開発に着手し、毎日1〜3コミットずつくらいのペースで進めていきました。</p>

<h2>サーバーサイド</h2>

<p>本サービスは一見、位置を検索したいショップ毎に<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Mapで検索をかけ、結果を重ねただけのように見えますが、実際にはちゃんとデータを集めてDBに収め、そこから引っ張ってプロットしています。その理由としては、</p>

<ul>
<li><p>そもそも店舗の情報を集める適当な<a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>はない</p></li>
<li><p>ユーザーの検索のたびに<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Map <a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>を使うとすぐに制限を食らってしまう</p></li>
<li><p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Map自体の検索を使ってしまうと取り出したい・表示したい情報をコン<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C8%A5%ED%A1%BC%A5%EB">トロール</a>できない</p></li>
</ul>


<p>などがありました（若干うろ覚え）。なので、とにかくショップの店舗情報を集めるべく一つずつ公式ショップから<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EC%A5%A4%A5%D4%A5%F3%A5%B0">スクレイピング</a>することにしました。</p>

<p>今gitのcommit logを確認すると、作り始めてから<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C1%A5%E5%A1%BC%A5%C8%A5%EA%A5%A2%A5%EB">チュートリアル</a>で学んだことをこれに当てはめながら開発を進め、サイトのシステム的な部分に関してはDBの設計と合わせても10/6に終わっていました。<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EC%A5%A4%A5%D4%A5%F3%A5%B0">スクレイピング</a>のやり方もそのあたりで並行して学びました。</p>

<p></p>
<blockquote class="twitter-tweet" data-lang="ja">
<p lang="ja" dir="ltr"><a class="keyword" href="http://d.hatena.ne.jp/keyword/Rails">Rails</a>の入門として作ってるアプリ、試作は1、2日出てきたのにデータを集めるのがだるすぎて完全にモチベを奪われている。そしてページレイアウト・デザインのブラッシュアップという苦手なやつも待ち受けている…。</p>— raahii (piyo56) (@piyo56_net) <a href="https://twitter.com/piyo56_net/status/783993373321416704?ref_src=twsrc%5Etfw">2016年10月6日</a>
</blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<p>なのでこれ以降はフロントエンドの開発と並行して毎日少しずつ<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EC%A5%A4%A5%D4%A5%F3%A5%B0">スクレイピング</a>し、取扱ショップを増やしていきました。</p>

<h2>フロントエンド</h2>

<p>サーバーサイドが一段落ついてから画面の実装に取り掛かりました。試作時点での画面はこんな感じで全くデザインが当たっていませんでした（サービス名すらも違う）。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125002121.png" alt="f:id:bonhito:20161125002121p:plain" title="f:id:bonhito:20161125002121p:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>そして現在のこの画面になるまでにおそらく約1ヶ月くらいはかかったと思います。まぁちょうどその頃から開発にかける時間も少なくなってしまったのも一つ原因なのですが。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161122/20161122160642.png" alt="f:id:bonhito:20161122160642p:plain" title="f:id:bonhito:20161122160642p:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>当初はモノクロな検索画面と地図表示画面の2つしか作っていませんでしたが、そこからBootstrapを導入し、検索条件部のドロップダウン・検索条件ラベル・地図表示画面を実装し、そのあと地図の横のリストや当サイトについてのページ、お問い合わせのページなどを作りました。このあたりではまだサーバーサイドからもらう情報が足りなかったりして、サーバーサイドのコーディングのやり直しだとか、DB設計のやり直し（カラムの追加）とかもあり手戻りが多かった気がします。</p>

<p>そして、シェアボタンと<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google%20Analytics">Google Analytics</a>なども付けました。デザインの改良はその都度その都度行いました。振り返ってみると、なにか新しいものを追加する度に<a class="keyword" href="http://d.hatena.ne.jp/keyword/css">css</a>の調整が必要だったり、jsを書かなければいけなかったり、小さなバグを潰したりと大変でした。また、最後になってから付け焼刃的にレスポンシブデザインを実装したり、前回のエントリで書いたように<a href="http://ganbaro.hateblo.jp/entry/2016/11/17/204148">ロゴの使用の問題</a>にぶつかったり、使っていた画像が実は改変禁止の素材だったりと、<b>もうとにかく自分でバグを作り込むケースが非常に多く目立ちました</b>。</p>

<p>今回の開発を通じてもっともっと知識を付けなければなぁと思いました。それにしてもフロントエンド地獄って感じでした。まじで時間食われた…笑</p>

<h2>インフラ</h2>

<p>簡単で無料なのでherokuにしました。ルート<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C9%A5%E1%A5%A4%A5%F3">ドメイン</a>が使えないとは知らずに<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C9%A5%E1%A5%A4%A5%F3">ドメイン</a>を取得してしまい悲しい気持ちになりました。</p>

<p>できればシェルログインできるサーバーを借りてちゃんとデプロイしたいのですが、<a class="keyword" href="http://d.hatena.ne.jp/keyword/rails">rails</a>アプリは<a class="keyword" href="http://d.hatena.ne.jp/keyword/WEBrick">WEBrick</a>なるwebサーバを使っておりなんだかめんどくさそうだったのでとりあえずまたの機会にしました。</p>

<h1>振り返り</h1>

<h2>発見</h2>

<ul>
<li>
<p>フロントエンドは大変</p>

<p>  自分の実力不足でもありますが、シンプルだからと高を括って設計などをまったくせずに着手してしまったのが原因。振り返ると、機能やページを追加する度にスタイルが崩れたり、違うデ<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D0%A5%A4%A5%B9">バイス</a>でサービスを使ってみて初めておかしい所に気づいたりと、fixのコミットが頻繁に入っていました。現在もなおモバイルに対するデザイン方法がわからない上、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Chrome">Chrome</a>以外のブラウザでテストしたりもしていないので、フロントエンド開発自体に対する理解を深める必要があると感じました。</p>
</li>
<li>
<p>プロトタイプは仕様や設計を明確にする上で効果的</p>

<p>  今回プロトタイプを1つ作ってから開発を始めたのですが、これは純粋に良かったです。ただプロトタイプをどの程度の粒度（大きさ、正確さ）で作るべきか、あるいはどのような点に注目しながら作るべきなのかが明確でなく、設計のブラッシュアップが十分に行われませんでした。</p>
</li>
<li>
<p>MVPで公開した方が良い</p>

<p>  よく言われている（？）かとは思いますが、MVP(Minimum Viable Product: 必要最低限機能)で公開したほうが良いなと思いました。ただ、ユーザーが初めてサービスを目にした時にあの機能この機能があれば素通りせずに止まってくれるのでは無いかと考えてしまうので難しい。これについてもリーンに関わる書籍などを読んで意図するところをきちんと理解したい。</p>
</li>
<li>
<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/CRUD">CRUD</a>の内のREAD操作のみをユーザーに提供するサービスは、セキュリティ的に比較的楽</p>

<p> 不安ではありますが、とりあえずセンシティブな情報はあまりないので大丈夫かなと思っています。</p>
</li>
</ul>


<h2>特に良かったこと</h2>

<ul>
<li>
<p>好きなテーマでサービスを作ったこと</p>

<p> 楽しかった。</p>
</li>
<li><p>こうしてある程度作りきってエントリを書いていること、それ自体</p></li>
<li>
<p>git使ったこと</p>

<p>  今回記事を書くときにも試作時点の状態にパッと戻せたり、草生やして満足感が得られました。あとherokuと連携してデプロイもできます。</p>

<p>  <span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161125/20161125004027.png" alt="f:id:bonhito:20161125004027p:plain" title="f:id:bonhito:20161125004027p:plain" class="hatena-fotolife" itemprop="image"></span></p>
</li>
<li>
<p>todoリスト的なものにカンバンアプリ（<a href="https://wekan.io/">https://wekan.io/</a>）を使ったこと</p>

<p>  一人だと効果は薄いですが、<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%F3%A5%BF%A1%BC%A5%F3">インターン</a>で教えてもらったので<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B8%AB%A4%A8%A4%EB%B2%BD">見える化</a>はせっせとやっていました。</p>
</li>
</ul>


<h2>特に悪かったところ</h2>

<ul>
<li>
<p>テストを書いてない</p>

<p> 勉強します…。</p>
</li>
<li>
<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/%C3%F8%BA%EE%B8%A2">著作権</a>、素材の商用利用などをちゃんと確認していない</p>

<p> わりと論外。今回は見落としがあったがいつも確認する癖をつける。曖昧な部分はある程度調べ、具体的な根拠を持って（すくなくとも個人的に）理解・解釈をする。</p>
</li>
<li>
<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/rails">rails</a>のデフォルトの<a class="keyword" href="http://d.hatena.ne.jp/keyword/sqlite">sqlite</a>をdbとして使っていたらデプロイでコケた</p>

<p> はじめてのデプロイでデータの<a class="keyword" href="http://d.hatena.ne.jp/keyword/mysql">mysql</a>移行とかその他config関係の設定とかで時間かかってしまいました。デプロイまで見据えた方がよい（？）</p>
</li>
<li>
<p>サービス（ア<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%C7%A5%A2">イデア</a>）は考えた時点で文書化するべき</p>

<p> サービス開発している途中で、「あれ、もしかしてこれって<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Mapのマイマップで良くないか」とか「<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Places <a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>使えば一発じゃないのか」とか思いついて<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A2%A5%A4%A5%C7%A5%F3%A5%C6%A5%A3%A5%C6%A5%A3">アイデンティティ</a>が揺らぎかけた。どの当たりに差別化のポイントがあるのか整理し、文書でまとめつつ、関係する技術要素は最初に徹底的に調べるべきでした。</p>
</li>
</ul>


<h1>今後のTODO</h1>

<ul>
<li>
<p>宣伝と集客</p>

<p> せっかく作ったのでチャレンジする。</p>
</li>
<li>
<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%DE%A5%DB">スマホ</a>（モバイル）ページを改良する</p>

<p>  画面狭いと本当に難しい。モバ<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%EB%A5%D5%A5%A1">イルファ</a>ーストを最初から実践したかった。</p>
</li>
<li>
<p>取扱いショップを増やす</p>

<p>  ウィメンズのショップをもっと増やしたい。あと、中には公式サイトの店舗検索がjsで動くようになっているところがあるので、<a class="keyword" href="http://d.hatena.ne.jp/keyword/selenium">selenium</a>を用いたjs対応の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EC%A5%A4%A5%D4%A5%F3%A5%B0">スクレイピング</a>も挑戦したい。</p>
</li>
<li>
<p>適当な頻度で最新の店舗情報を取得するクローラを作る</p>

<p>  </p>
<div class="hatena-asin-detail">
<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4797380357/hatena-blog-22/"><img src="https://images-fe.ssl-images-amazon.com/images/I/51Pvu7X75QL._SL160_.jpg" class="hatena-asin-detail-image" alt="Rubyによるクローラー開発技法 巡回・解析機能の実装と21の運用例" title="Rubyによるクローラー開発技法 巡回・解析機能の実装と21の運用例"></a><div class="hatena-asin-detail-info">
<p class="hatena-asin-detail-title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4797380357/hatena-blog-22/">Rubyによるクローラー開発技法 巡回・解析機能の実装と21の運用例</a></p>
<ul>
<li>
<span class="hatena-asin-detail-label">作者:</span> 佐々木拓郎,るびきち</li>
<li>
<span class="hatena-asin-detail-label">出版社/メーカー:</span> <a class="keyword" href="http://d.hatena.ne.jp/keyword/SB%A5%AF%A5%EA%A5%A8%A5%A4%A5%C6%A5%A3%A5%D6">SBクリエイティブ</a>
</li>
<li>
<span class="hatena-asin-detail-label">発売日:</span> 2014/08/23</li>
<li>
<span class="hatena-asin-detail-label">メディア:</span> 単行本</li>
<li><a href="http://d.hatena.ne.jp/asin/4797380357/hatena-blog-22" target="_blank">この商品を含むブログ (10件) を見る</a></li>
</ul>
</div>
<div class="hatena-asin-detail-foot"></div>
</div>
</li>
<li>
<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%BB%A5%EC%A5%AF%A5%C8%A5%B7%A5%E7%A5%C3%A5%D7">セレクトショップ</a>のサブブランドに対応する</p>

<p>  現在もいくつか対応していますが…。このあたりは難しいところです。</p>
</li>
<li>
<p>店舗に関して提供する情報をもっとリッチに</p>

<p>  今のままだと<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Mapで単体検索した場合に比べ、提供する情報が貧相です。例えばショップのブログのurlだとか、取扱がメンズ／ウィメンズのみの店舗があったりするのでその旨をに表示するとか…。ファッションサイトに特化したなりの情報が出せると良いです。気が遠くなります。</p>
</li>
<li>
<p>同位置のデパートのプロットを工夫する</p>

<p>  開発でかなりはまった要素として、<b>同じデパートに入っている複数のショップは位置情報が全く同一で、プロットすると毎回上書きされて最後にプロットしたものしか見えなくなる</b>というものがありました。現在はマーカーをプロットする時にすでにそこにマーカーがあれば一定幅位置を横にずらすようにしているのですが、これだと不正確な位置になってしまいます。正確かつわかりやすく表現する方法を模索したいです。</p>
</li>
</ul>


<h1>さいごに</h1>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/rails">rails</a>に対する知識はあまり増えなかったのですが、Web開発の基本的な流れが確認できた。開発はとても楽しかった。またコードを継続的に書く習慣ができたので、これからも継続していきたい。</p>

<p><a href="http://amzn.asia/2hmrg7W">http://amzn.asia/2hmrg7W</a><cite class="hatena-citation"><a href="http://amzn.asia/2hmrg7W">amzn.asia</a></cite></p>
</body>
{{< /rawhtml >}}
