+++
title = "2022年の振り返り"
description = "2022年の振り返り"
date = 2022-12-30T23:50:00+09:00
categories = ["振り返り"] # 技術, 研究, 読書, レビュー, 旅行
images = ["https://images-na.ssl-images-amazon.com/images/I/61l-Ez-KYPL.jpg"]
keywords = ["2022", "振り返り", "サウナ", "コーヒー", "ファッション"]
draft = true
canonicalUrl = "https://raahii.me/posts/retrospective-2022"
+++

{{< toc >}}

## エンジニアリング

### 仕事

これについては書くか迷ったのだけど一応。

2020年に就職してきちんとしたサービスのコードに関わるようになってから丸2年になるが、2021年は色々新しいこと、大きめのプロジェクトに関われた年であったのに対し、今年はプロダクトに新機能の開発がほとんどなく、ずっとリファクタリングしていたような年だった。

（詳しく書き始めたら長くなってしまったので割愛）

個人的にはそろそろ変化を求める時期かなぁという感じ。体外発表とかも全くできていないので、来年は新しいことをやる→アウトプットするの循環を良くしていきたいところ。


### 高度試験

これはエンジニアリングではないが、技術的な話として。

今年は業務で触れる領域について一通り基本を習得したい気持ちがあり、IPA の高度試験を受けた。

春に [ネットワークスペシャリスト（ネスペ）](https://www.jitec.ipa.go.jp/1_11seido/nw.html)、秋に [データベーススペシャリスト（デスペ）](https://www.jitec.ipa.go.jp/1_11seido/db.html) を受けて両方とも合格した。どちらも国家資格というだけあって簡単ということはなく、ネスペは100時間ほど、デスペは50時間ほどの準備が必要だった。

資格勉強というのは、合格のための対策と、業務にもつながるように知識を掘り下げることのバランスを取るのが難しいのだが、ひとまずこうしてまとまったインプットができたのは良かったと思う。また試験当日は緊張感もあってピシッとするので、新鮮なイベントでもあった。 こういうのもたまにはありかなと思う。（この辺の受験記も記事にしようと思って結局やらずじまい…）

特にネットワークスペシャリストは学びが多く、知らないことだらけだったことを痛感した。流石にL1、L2レベルの話を業務で触れることはほぼないが、L3〜くらいの知識はかなり生きると感じる。バックエンドエンジニアとしてはネットワークスペシャリストは学習の題材として良いと思う。

ちなみに自分は基本情報も応用情報も持っておらず、初回のネットワークスペシャリストでは午前1 から受けたのだが **圧倒的に退屈・虚無だった** ので、午前免除があるうちにセキュリティ系の資格も取ろうかな、と考えている。

ネットワーク・データーベース・セキュリティを押さえればウェブエンジニアの足回りとしては一通り良さそう。


### 個人開発

haraiai という LINE Bot を作った。

{{< rawhtml >}}
<a href="https://raahii.github.io/posts/haraiai-line/" target="_blank" rel="noopener noreferrer" style="all: unset; cursor: pointer;" >
<div style="width: 100%; max-width: 36rem; height: 9rem; border-width: 1px; border-style: solid; border-color: rgb(209, 213, 219); display: flex; background-color: rgb(255, 255, 255);" onMouseOut="this.style.background='rgb(255, 255, 255)'" onMouseOver="this.style.background='rgb(243, 244, 246)'">
  <div style="padding: 0.75rem; width: 75%; display: flex; flex-direction: column; justify-content: space-between;">
    <div>
      <div style="color: rgb(31, 41, 55); font-size: 1.0rem; line-height: 1.5rem; max-height: 3.0rem; overflow: hidden;">LINE上で手軽に割り勘できるサービスを作った</div>
      <div style="font-size: 0.8rem; line-height: 1.25rem; max-height: 2.5rem; color: rgb(107, 114, 128); overflow: hidden; text-overflow: ellipsis;">LINE上で手軽に割り勘できるサービスを作った</div>
    </div>
    <div style="font-size: 0.75rem; line-height: 1rem; color: rgb(31, 41, 55);">raahii.github.io</div>
  </div>
  <div style="border-left-width: 1px; width: 25%;">
    <img src=https://raahii.github.io/images/2022/haraiai-line/ogp.jpg alt="No Image" style="object-fit: cover; width: 100%; height: 100%; background-color: rgb(209, 213, 219);" loading="lazy" />
  </div>
</div></a>
{{< /rawhtml >}}


あとはもろもろ小粒なものとか、パーソナルトレーナーをやっている友人のサービス立ち上げのお手伝いをしていたりする。

今年は去年に比べると業務外でも手を動かした年だった。GitHub を見返すと、2021年は 155 contrib だったが今年は 309 contrib だった。

{{< image src="https://grass-graph.appspot.com/images/raahii.png" link="https://github.com/raahii" width="100%" alt="Github Contribution" >}}

就職してからプライベートでコードを書く時間が減り、今でもまだまだ量は足りていないのだが、これは特にやる気の問題とかではなく、作りたいテーマを如何にそばにおいておけるかが大事だと感じる。 来年もできるだけ「つくりたいものにワクワクする状態」を整えておきたい。


## ウェブサービス

自分が関わっているかに関係なく、今年一番良かったウェブサービスを選んだのですが、[自治体マイページ](https://mypg.jp/)です。

{{< rawhtml >}}
<a href="https://mypg.jp/" target="_blank" rel="noopener noreferrer" style="all: unset; cursor: pointer;" >
<div style="width: 100%; max-width: 36rem; height: 9rem; border-width: 1px; border-style: solid; border-color: rgb(209, 213, 219); display: flex; background-color: rgb(255, 255, 255);" onMouseOut="this.style.background='rgb(255, 255, 255)'" onMouseOver="this.style.background='rgb(243, 244, 246)'">
  <div style="padding: 0.75rem; width: 75%; display: flex; flex-direction: column; justify-content: space-between;">
    <div>
      <div style="color: rgb(31, 41, 55); font-size: 1.0rem; line-height: 1.5rem; max-height: 3.0rem; overflow: hidden;">自治体マイページ</div>
      <div style="font-size: 0.8rem; line-height: 1.25rem; max-height: 2.5rem; color: rgb(107, 114, 128); overflow: hidden; text-overflow: ellipsis;">ふるさと納税で寄附したあと、さまざまな便利な機能が無料で利用できる"あなただけ"の専用ページです。</div>
    </div>
    <div style="font-size: 0.75rem; line-height: 1rem; color: rgb(31, 41, 55);">mypg.jp</div>
  </div>
  <div style="border-left-width: 1px; width: 25%;">
    <img src="https://pbs.twimg.com/profile_images/1569965079789203456/Q1N7LXwS_400x400.png" alt="No Image" style="object-fit: cover; width: 100%; height: 100%; background-color: rgb(209, 213, 219);" loading="lazy" />
  </div>
</div></a>
{{< /rawhtml >}}

ふるさと納税のワンストップ特例をマイナンバーカードを使ってウェブ上で申請できるサービス。**このサービスが対応している自治体であれば、どのECサイトでふるさと納税したかに関わらず、自動的にデータが紐付けされ、一括で申請できる。複数の自治体の申請も同時に出来るというまさに神サービス。**

どうやってふるさと納税の履歴を取得しているのか最初わからなかったのだが、事前に寄付者情報として氏名・住所等を入力するようになっており、この情報で紐付けされているよう。

何故流行っていないのか謎なレベルで便利なのだが、一因として対応自治体がまだ少ないことがあると思う。伸びしろですね。
でも特に思い入れのある自治体以外は、事前に対応自治体から選ぶように運用でカバーしますので私としては全然OKです。 今年はありがとうございました、来年もよろしくおねがいします。


## 服

### G.H.BASS / 厚底ローファー

{{< image src="https://c.imgz.jp/279/54089279/54089279b_8_d_500.jpg" link="https://zozo.jp/shop/gmtshop/goods/53089279/?did=88270481" width="50%" alt="G.H.BASS/BA11535W ローファー 厚底ソール" >}}

普段はスニーカー、とりわけ New Balance ばかり履いているので、たまには革靴でフォーマルめな格好もいいなと思って買った。

少しだが厚底なのでカジュアルにも合わせやすく、入門としてはよかったが、やっぱり長時間歩くと足が痛いし、今でも軽い靴ずれになるときがあって大変。革靴の中でもローファーは紐がないので、その分サイズがシビアだなぁというのと、幅が狭めなのも一因かな。

最近は [Berwick](https://berwickjapan.co.jp/) が気になっているので、茶色系のものをもう一足買ってみようかなーと思っている。ちなみに革靴を見るときは新宿の伊勢丹メンズ館が良い。


### New Balance / CM878MC1 GRAY

{{< image src="https://cdn.shopify.com/s/files/1/0603/3031/1875/products/2_eafc7e0c-c822-4c22-bce9-883e21ec9723_540x.jpg" link="https://www.kickscrew.com/products/new-balance-unisex-878-series-low-top-running-shoes-grey-cm878mc1" width="50%" alt="New Balance 878 'Grey'" >}}

今年の頭に United Arrows で見かけて一目惚れして買った一足。

ベーシックな運動靴という佇まいと、どんな服にでも合うグレーで今年一番履いた靴になった。ベスト！

### New Balance / M991 UKF

{{< image src="https://www.diverse-web.com/upload/save_image/07122002_62cd54aaa364b.jpg" link="https://zozo.jp/shop/gmtshop/goods/53089279/?did=88270481" width="50%" alt="New Balance M991 UKF" >}}

去年 992 Navy を買ったので今年も 900 番台を一足と思って買ったのだが、実はまだ履いていないｗ
靴が若干溜まってきたので、もう少し寝かせる気がするが、来年は履くかなぁ。

### Steven Alan

{{< rawhtml >}}
<a class="dont-hightlight" href="https://zozo.jp/shop/beautyandyouthunitedarrows/image.html?gid=63283127&did=104583152">
  <img src="https://c.imgz.jp/127/64283127/64283127_16_d_500.jpg" width="30%"/>
</a>

<a class="dont-hightlight" href="https://zozo.jp/shop/beautyandyouthunitedarrows/image.html?gid=63730752&did=105342611">
  <img src="https://c.imgz.jp/752/64730752/64730752_46_d_500.jpg" width="30%"/>
</a>

<a class="dont-hightlight" href="https://store.united-arrows.co.jp/brand/sa/">
  <img src="https://c.imgz.jp/168/67805168/67805168_10_d_500.jpg" width="30%"/>
</a>
{{< /rawhtml >}}

去年に引き続いて、今年もコンスタントに良いものが見つかるのは Steven Alan だった。
どれもしっかりした生地感だが厚すぎず、落ち着いた色味でシルエットもきれい、そして高すぎない（大事）。

### Barbour / Transport Jacket

{{< image src="https://c.imgz.jp/476/67432476/67432476_14_d_500.jpg" link="https://zozo.jp/shop/greenlabel/goods/66432476/?did=109393655&rid=1095" width="50%" alt="TRANSPORT トランスポート ジャケット" >}}

流行りに乗って…あっさりとしたベージュの TRANSPORT ジャケットを買った。
オイルがなく軽いのでサクッと羽織れる。トラッドだけど襟と裏地のチェックがかわいい。

## コーヒー

2020年から続けている「ランチタイムにコーヒー一杯」は今年も継続したが、変化は少ない年だった。ウォッシュトもナチュラルも満遍なく飲み、新たにデカフェにも手を出した。

年始に飲んだ LIGHT UP COFFEE のゲイシャがやっぱり美味しかったかなぁ。記憶に残っているロースターはこんな感じ。


- [LIGHT UP COFFEE](https://lightupcoffee.com/)
- [SWITCH COFFEE TOKYO](https://switchcoffeetokyo.shop/)
- [imperfect](https://imperfect-dowell.com/)
- [大社珈琲](https://maruco.co.jp/taishacoffee/)
- [マーメイドコーヒーロースターズ](https://www.instagram.com/mermaid_coffee_roasters/?hl=ja)

## サウナ

今年も相変わらずサ活は最高だったが、サウナはそれ自体に意味があるというよりは、メンタルリセット・切り替えみたいな要素が大きいので、月1くらいの頻度に落ち着いた。


今年一番記憶に残っているのは [天然温泉 満天の湯](https://sauna-ikitai.com/saunas/2208) で、外気浴用のベンチがたくさんあって、つぼ湯や寝湯も充実しているのが良い。ちなみに寝湯は畳なんです。

あとは旅行で泊まったドーミーイン出雲とかも良かったなぁ。サウナついてるホテルのお得感がすごいので、ドーミーイン系列の利用はかなり増えました。


## 料理

今年は平日に3回程度を目処にコンスタントに自炊できた年だった。料理の腕をあげようとか、色々チャレンジしようみたいな姿勢で取り組んでいるわけではないが、同じメニューを食べ続けるのは自然と飽きるので、結果的に色々作った年だったとは思う。


### スパイスカレー

2021年にスパイスカレーの材料を色々揃えたものの、花椒を入れすぎて爆死したり、なかなか味にコクがでない問題に悩まされていた。

今年は肩の力を抜いてクミンとコリアンダーをベースとしつつ、市販のルーを活用して味を出すことで妥協した。その他、具材を盛りだくさんにしたり、サバや味噌を使ってみたりといった工夫でカレー作りを楽しめた年だった。

### 麻婆豆腐

今年一番作ったメニューはといえば、間違いなく麻婆豆腐だった。コウケンテツさんの Youtube チャンネルから食べたいものを探す、というのをよくやっていたのだけど、その中でも麻婆豆腐は簡単で美味しく、定番となった。

{{< rawhtml >}}
<a href="https://www.youtube.com/watch?v=50iEDfOOLQk" target="_blank" rel="noopener noreferrer" style="all: unset; cursor: pointer;" >
<div style="width: 100%; max-width: 36rem; height: 9rem; border-width: 1px; border-style: solid; border-color: rgb(209, 213, 219); display: flex; background-color: rgb(255, 255, 255);" onMouseOut="this.style.background='rgb(255, 255, 255)'" onMouseOver="this.style.background='rgb(243, 244, 246)'">
  <div style="padding: 0.75rem; width: 75%; display: flex; flex-direction: column; justify-content: space-between;">
    <div>
      <div style="color: rgb(31, 41, 55); font-size: 1.0rem; line-height: 1.5rem; max-height: 3.0rem; overflow: hidden;">【100万回再生人気レシピ】時短中華レシピ！おうちで簡単極旨！マーボー豆腐の作り方</div>
      <div style="font-size: 0.8rem; line-height: 1.25rem; max-height: 2.5rem; color: rgb(107, 114, 128); overflow: hidden; text-overflow: ellipsis;">久しぶりの王道シリーズでございます！みんな大好き麻婆豆腐をおうちで手軽に簡単につくれる方法を伝授します！是非チャンネル登録してみてね。https://bit.ly/2BUMuKI【チャプター】00:00〜オープニング01:04〜下ごしらえ03:58〜調理10:58〜試食■身近な調味料で時短！ご飯が止まらない！極旨...</div>
    </div>
    <div style="font-size: 0.75rem; line-height: 1rem; color: rgb(31, 41, 55);">www.youtube.com</div>
  </div>
  <div style="border-left-width: 1px; width: 25%;">
    <img src=https://i.ytimg.com/vi/50iEDfOOLQk/maxresdefault.jpg alt="No Image" style="object-fit: cover; width: 100%; height: 100%; background-color: rgb(209, 213, 219);" loading="lazy" />
  </div>
</div></a>
{{< /rawhtml >}}

豆腐だけ美味しいものを買っておけば間違いない。

### ごはん

{{< image src="https://www.hario.com/product/GIS-200.jpg" link="https://www.hario.com/product/cook/cookingpot/GIS.html" width="50%" alt="フタがガラスのIH対応ご飯釜雪平" >}}

今年はふるさと納税で南魚沼市のコシヒカリを何度も頼んだのだけれど、安い炊飯器を使っていたばかりに味のポテンシャルを引き出せていないことに途中で気づいて、ご飯釜を買った。 これがかなり良くて、味やお米の食感が本当に変わったと思う。

{{< rawhtml >}}
<a href="/" target="_blank" rel="noopener noreferrer" style="all: unset; cursor: pointer;" >
<div style="width: 100%; max-width: 36rem; height: 9rem; border-width: 1px; border-style: solid; border-color: rgb(209, 213, 219); display: flex; background-color: rgb(255, 255, 255);" onMouseOut="this.style.background='rgb(255, 255, 255)'" onMouseOver="this.style.background='rgb(243, 244, 246)'">
  <div style="padding: 0.75rem; width: 75%; display: flex; flex-direction: column; justify-content: space-between;">
    <div>
      <div style="color: rgb(31, 41, 55); font-size: 1.0rem; line-height: 1.5rem; max-height: 3.0rem; overflow: hidden;">フタがガラスのIH対応ご飯釜雪平｜調理器具・卓上関連｜耐熱ガラスのHARIO（ハリオ）</div>
      <div style="font-size: 0.8rem; line-height: 1.25rem; max-height: 2.5rem; color: rgb(107, 114, 128); overflow: hidden; text-overflow: ellipsis;">4 層構造＋フッ素コート。ステンレスとアルミの4 層構造の鍋身は熱をまんべんなく伝え、ご飯を美味しく
炊き上げます。内面にはフッ素コートを施してあるので、ご飯がこびりつきにくくなっています。ご飯以外に煮込み料理にもお使いいただけます。</div>
    </div>
    <div style="font-size: 0.75rem; line-height: 1rem; color: rgb(31, 41, 55);">www.hario.com</div>
  </div>
  <div style="border-left-width: 1px; width: 25%;">
    <img src="https://www.hario.com/product/GIS-200.jpg" alt="No Image" style="object-fit: cover; width: 100%; height: 100%; background-color: rgb(209, 213, 219);" loading="lazy" />
  </div>
</div></a>
{{< /rawhtml >}}

釜ではなく炊飯器を新調しても良かったけれど、もともと実家ではお米を鍋で炊いていたので、炊飯器よりもコスパ良く美味しいご飯が炊けるだろうと予想したのだが、ビンゴだった。今年は冷蔵庫も大きいものに買い替えたので、余ったご飯は鍋ごとぶちこんでおり、保存には特に困っていない。が、水の目盛りが見づらいのだけは困ってるのでどうにかしてほしい。

## さいごに

来年は、より良い振り返りが出来るように色々な体験をしたい。 腰を軽くしていくためにも "Better than Nothing." の気持ちで過ごしたい。

{{< rawhtml >}}
<a href="https://www.youtube.com/watch?v=bnfPUrJQh1I" target="_blank" rel="noopener noreferrer" style="all: unset; cursor: pointer;" >
<div style="width: 100%; max-width: 36rem; height: 9rem; border-width: 1px; border-style: solid; border-color: rgb(209, 213, 219); display: flex; background-color: rgb(255, 255, 255);" onMouseOut="this.style.background='rgb(255, 255, 255)'" onMouseOver="this.style.background='rgb(243, 244, 246)'">
  <div style="padding: 0.75rem; width: 75%; display: flex; flex-direction: column; justify-content: space-between;">
    <div>
      <div style="color: rgb(31, 41, 55); font-size: 1.0rem; line-height: 1.5rem; max-height: 3.0rem; overflow: hidden;">OSS エンジニアの Better than Nothing という生き方 | AWS Dev Day 2022 Japan #AWSDevDay</div>
      <div style="font-size: 0.8rem; line-height: 1.25rem; max-height: 2.5rem; color: rgb(107, 114, 128); overflow: hidden; text-overflow: ellipsis;">趣味で開発したOSSが海外企業に買収されイスラエルで働くようになってから大きく感銘を受けた考え方に、"better than nothing"というものがあります。全くないよりは良いという意味ですが、何度も聞いているうちに自分は完璧にこだわりすぎていることに気付きました。かつてほぼ開発経験のなかった自分が OSS...</div>
    </div>
    <div style="font-size: 0.75rem; line-height: 1rem; color: rgb(31, 41, 55);">www.youtube.com</div>
  </div>
  <div style="border-left-width: 1px; width: 25%;">
    <img src=https://i.ytimg.com/vi/bnfPUrJQh1I/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGBMgPSh_MA8=&rs=AOn4CLAhd2c31w3vZoOIFa4wnk-TwLqfyg alt="No Image" style="object-fit: cover; width: 100%; height: 100%; background-color: rgb(209, 213, 219);" loading="lazy" />
  </div>
</div></a>
{{< /rawhtml >}}
