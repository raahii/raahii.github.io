+++
title = "Kinectを用いたRGB-Dデータセットのまとめ"
date = 2018-03-01T18:23:10+09:00
categories = ["研究"]
tags = ["論文", "kinect", "depth"]
draft = false
aliases = ["/2018/03/01/kinect-rgbd-dataset", "/2018/03/kinect-rgbd-dataset"]
+++

# はじめに

卒研でRGB-Dデータを使う研究をやっていたので、その時に調べた内容について軽くまとめます。

タイトルでは"Kinectを用いた"となっていますが、実際はそこに拘りはありません。ただ、研究分野でかなりよくKinectが使われているので、RGB-Dに関わる研究を探す場合には同時にKinectの文脈でも探したほうが良いと思います。Google Scholarでも"kinect"の方がよくヒットします。

{{< figure src="/images/2018/kinect-rgbd-dataset/google-scholar-rgbd.png" title="Google Scholar 'rgbd'" >}}
{{< figure src="/images/2018/kinect-rgbd-dataset/google-scholar-kinect.png" title="Google Scholar 'kinect'" >}}



さて、実際にデータセットについてまとめようと作業を始めたのですが、[せっかくなので表にまとめようと思い](https://docs.google.com/spreadsheets/d/1ETewgOneQyzSI9jKP02uhfCC8F8aS90nyjlgITzSh-o/edit?usp=sharing)、早々に挫折しました。そこで、**<u>調べる中で見つけたRGB-Dデータセットのサーベイ論文をシェアすることにします</u>**。

# 文献リスト

まず、Kinectから取得されるRGB-Dデータ（及び音声データ）の応用をまとめている論文があります。Kinectから取ったデータの使い道のイメージをつかめると思うのでおすすめです。

- [A Survey of Applications and Human Motion Recognition with Microsoft Kinect](https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0%2C5&q=A+Survey+of+Applications+and+Human+Motion+Recognition+with+Microsoft+Kinect&btnG=)

## 論文

- [RGBD datasets: Past, present and future (2016)](https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0%2C5&q=RGBD+Datasets%3A+Past%2C+Present+and+Future+Michael&btnG=)

> データセットの種類（タスク）毎に表で整理してありわかりやすいです。データセットの説明や作成年だけでなく、サムネイルが付いていて、形式（Video?/Skelton?）についても言及があります。
> {{< figure src="/images/2018/kinect-rgbd-dataset/dataset-table1.png" title="表の例（本項の論文より引用）" >}}

- [RGB-D datasets using microsoft kinect or similar sensors: a survey. (2017)](https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0%2C5&q=RGB-D+datasets+using+microsoft+kinect+or+similar+sensors%3A+a+survey.&btnG=)

> これも種類に応じて章分けしてまとめてくれています。一応表もありますが見づらいです。個々のデータセットに対し、サンプル数やラベル情報を簡潔に文章でまとめてくれています。最初のツリー画像が良い感じです。
> {{< figure src="/images/2018/kinect-rgbd-dataset/dataset-tree.png" title="データセット木（本項の論文より引用）" >}}

- [RGB-D-based Action Recognition Datasets: A Survey (2016)](https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0%2C5&q=RGB-D-based+Action+Recognition+Datasets%3A+A+Survey&btnG=)

> アクション認識に絞ってまとめられているのですが、文章でも表でもかなりよくまとめられています。とうか逆にタスクを絞ったからこそまとめやすいのかもしれませんね。ラベル数とサンプル数で図に落とし込まれているのもわかりやすかったです。
> {{< figure src="/images/2018/kinect-rgbd-dataset/dataset-figure1.png" title="データセットの比較の図（本項の論文より引用）" >}}

- [A Survey of Datasets for Human Gesture Recognition (2014)](https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0%2C5&q=A+Survey+of+Datasets+for+Human+Gesture+Recognition&btnG=)

> これはジェスチャ認識に絞ってまとめられたものです。これも表あるのでわかりやすいです。あと、`Availability (Public, Public on Request or Not Yet)`の項もあるのが特徴です。

## Web

ついでにWeb媒体の資料も載せておきます。

- [RGBDデータセットのお勉強](http://robonchu.hatenablog.com/entry/2017/06/11/162558)
- [List of RGBD datasets - Michael Firman](http://www.michaelfirman.co.uk/RGBDdatasets/)
- [List of RGBD datasets - alexanderkun - 博客园](http://www.cnblogs.com/alexanderkun/p/4593124.html)

# さいごに
今回探してみて、愚直にGoogleなどで探すと意外に辛いことがわかりました。特にKinectが発売直後の2011〜2013年のデータセットは数も多くよくヒットするのですが、新しめのデータセットはこのようなサーベイ論文を当たるほうが圧倒的に効率が良いです。あと、Skeltonがあるやつを探したいみたいな場合も、データセットのHPを見てもデータ形式が明示されてないことが多く、そもそもHPがないケースもあるので、論文当たったほうが良いですね。
