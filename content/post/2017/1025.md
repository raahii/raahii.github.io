+++
title = "3DGANをchainerで実装した"
date = "2017-10-25T20:14:00+09:00"
categories = ["GAN", "深層学習", "3D", "研究", "実装", "Python"]
draft = false
+++


タイトルの通り，3DGANのchainer実装をgithubに上げた．当初はKerasで書いていたが良い結果が得られず，ソースコードの間違い探しをするモチベーションが下がってきたので，思い切ってchainerで書き直した．

<p><iframe src="https://hatenablog-parts.com/embed?url=https%3A%2F%2Fgithub.com%2Fraahii%2F3dgan-chainer" title="raahii/3dgan-chainer" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation">

実はmnistなどのサンプルレベルのものを超えてちゃんとディープラーニングのタスクに取り組むのは今回が初めてだった．
ChainerによるGANの実装自体は[公式のexample](https://github.com/chainer/chainer/tree/master/examples/dcgan)や[chainer-gan-lib](https://github.com/pfnet-research/chainer-gan-lib)が非常に参考になった．

# モデル

3DGANはその名の通り3Dモデルを生成するためのGAN（Voxelです）．[Learning a Probabilistic Latent Space of Object Shapes via 3D Generative-Adversarial Modeling](https://arxiv.org/abs/1610.07584)で提案されているもの．[前回の記事](https://raahii.github.io/2017/10/voxel/)でも触れた．

構造はDCGANと同様で200次元のベクトルよりGeneratorでサンプルを生成，Discriminatorでデータセット由来かGenerator由来か（real/fake）を分類しそのロスをフィードバックする．

Generatorは以下の図（論文より引用）のようなネットワークで，Discriminatorはこれを反転したようなモデルになっている．各ネットワーク内では3次元畳み込みを使用する．最適化手法はAdamで，論文ではDiscriminatorがバッチを8割以上正しく分類できた場合はパラメータを更新しないようにしたとあった．

<span itemscope="" itemtype="http://schema.org/Photograph">![f:id:bonhito:20171024233301p:plain](https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20171024/20171024233301.png "f:id:bonhito:20171024233301p:plain")</span>

# 3Dモデル

データセットにはShapeNet-v2を用いた．このデータセットには様々な種類の3Dモデルが収録されているが，今回は椅子のモデルのみを抽出した．椅子はおよそ6700サンプルが収録されており，ファイル形式は`.binvox`が直接収録されていたのでそれを使用した．

ただ，6700サンプルの3Dデータを全てメモリに乗せることはできなかったため，初期実装では毎回のループで読み込み処理を行っていた．その後，`.binvox`ファイルのヘッダー読み込みなどが不要であり，処理速度に支障があると感じたので事前に`.h5`に書き出して使うようにした．

ShapeNet-v2に収録されているデータのサンプルを示す．

<img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20171024/20171024234729.png" width="300px">
<img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20171024/20171024234743.png" width="300px">

<img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20171024/20171024234801.png" width="300px">
<img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20171024/20171024234823.png" width="300px">


実装
==

3DGANの実装をやろうと決めてから，実験を始める前に3Dモデルの取扱について理解するためのツールをつくっていた．主には[Simple Voxel Viewer](https://github.com/raahii/simple_voxel_viewer)で，`.binvox`形式について理解したり，matplotlibでボクセルをどうやってプロットしようかということについて考えていた．

64x64x64のボクセルを可視化するため，最初はmatplotlibの3Dplotを試したが，`scatter plot`や`surface plot`を使うとマインクラフトのような箱を集積した見映えのプロットが実現できない上，一つ描画するのに数十秒かかることがわかった．そこからまず自作してみようと思いTHREE.jsを使って[Simple Voxel Viewer](https://github.com/raahii/simple_voxel_viewer)を作ってみた．ところが結局こっちもいくらか高速化は試したものの，64x64x64のサイズでも密なボクセルになるとメモリーエラーが起こってしまいうまく動作しない問題が起こった．加えて当たり前だがPythonのコードにも組み込めない．

そうして結局，matplotlibの[3D volxe plot](https://matplotlib.org/devdocs/gallery/mplot3d/voxels.html)を採用した．しかしこの関数はまだリリースされていないため（2017/10時点），githubから直接インストールする必要があった．動作も遅いままだが妥協することにした．

ネットワークはKerasやTensorflowなどによる実装がいくつかgithubに上がっていたためそれらも参考にしつつ実装した．加えて，有名な[GANのベストプラクティス](https://github.com/soumith/ganhacks)のページを参考にした．ポイントをかいつまむと以下のような感じで実装した．

* ランダムベクトル`z`は論文では一様分布だったがガウス分布を使った．
* Generatorは`Deconv3D`+`BN`+`ReLU`の繰り返しで，最後だけ`sigmoid`．
* Discriminatorは`Conv3D`+`BN`+`Leaky-ReLU`の繰り返しで，最後だけ`sigmoid`．
* Chainerの公式のexampleを真似してロスは`softplus`を使って実装．ただ，実は`sigmoid + Adversarial loss`が`softplus`と同じなので`Discriminator`の最後の`sigmid`は不要なのだが，加えた方がうまくいった(謎)．

結果
==

成功例
---

良さげな感じを出すためにきれいなものを集めた．学習の初期段階ではでたらめなものが出力されるが，徐々に椅子が形成され，50エポックから100エポックくらいでましなものが出来た．

学習の途中では椅子とは独立した無意味なかたまりのオブジェクトが所々に浮かんでいたりしたが，それが消えてくるとかなり見栄えが良くなっていった．

<img src="https://github.com/piyo56/3dgan-chainer/blob/master/result/generated_samples/png/7.png?raw=true"  width="300px">
<img src="https://github.com/piyo56/3dgan-chainer/blob/master/result/generated_samples/png/13.png?raw=true" width="300px">
<img src="https://github.com/piyo56/3dgan-chainer/blob/master/result/generated_samples/png/21.png?raw=true" width="300px">
<img src="https://github.com/piyo56/3dgan-chainer/blob/master/result/generated_samples/png/30.png?raw=true" width="300px">

失敗例
---

ボクセルが全て1になったり0になって消滅したりした．今回幾度も学習をさせてみて，初期の段階からほぼ1なボクセル，あるいはほぼ0なボクセルが生成されたり，規則的なパターン（模様）を持つボクセルが生成されたりすると多くの場合失敗となるという微妙な知見を得た．

また，ボクセルが消滅したらその後復活しないこともわかった．ただこれは実装のところで述べたようにロスが間違っているせいかもしれない．

<img src="https://i.gyazo.com/1c516e331073f2f35c20948f7e5358b0.png" width="300px">
<img src="https://i.gyazo.com/c12285bb038635a17df18410202bc315.png" width="300px">
<img src="https://i.gyazo.com/0b87e9115d56faa93332afa61d093ad8.png" width="300px">
<img src="https://i.gyazo.com/1e67d6f8872df8b0b6e41d01021f69bf.png"   width="300px">

わかったこと
======

* GANはロスは全くあてにならない．生成結果が全て．
* `z`は[ガウス分布](http://d.hatena.ne.jp/keyword/%A5%AC%A5%A6%A5%B9%CA%AC%C9%DB)から取ってきたほうが良さそう．
* 学習を調整する(Discriminatorのlossやaccを見て更新しないなど）のはうまくいかないと感じた．
* 今回のコードでは`sigmoid + adversarial loss`を`softplus`で実装しているので，`Discriminator`の最後の`sigmoid`は不要なはずなのだが，誤って入れていたらうまくいき，外したらうまくいかなくなった．動きゃ勝ちみたいなところがあって釈然としない．
* 論文では1000エポック学習したとあったが100エポック行かないくらいでかなり形になった．

また，今回は[GANのベストプラクティス](https://github.com/soumith/ganhacks)の内，以下のトリックは実践しても効果がなかった.

* Discriminatorに学習させるミニバッチをrealのみまたはfakeのみにする．(項目4)
* GeneratorにもDiscriminatorにも`Leaky-ReLU`をつかう．(項目5)
* Generatorに`ADAM`を使ってDiscriminatorには`SGD`を使う．(項目10)
* Generatorに`Dropout`を使う．(項目17)

所感
==

実装に関して，やはりコード自体は`Keras`の方が圧倒的に簡単にかけるようになっているなと感じた．モデルのインスタンスを作ってバッチを`model.train_on_batch`に渡す処理を繰り返せば良いというイメージでとてもシンプルで良い．DCGANの実装についても，①`Descriminator`のみのモデル，②`Descriminator(not trainable)+Generator`のモデルをそれぞれ定義することで学習を実現したが，それぞれ独立に学習，更新処理をやるよというのが表現しやすくてわかりやすかった．

一方で`chainer`はまずGPUがある環境とない環境でコードを分けなくてはならず，そこがまず面倒に感じた．自分はリモートマシンが研究室のマシンやGCPなどさまざまなので，手元のmacbookで実装して`rsync`でデプロイという形で実装していたので処理をいちいち分岐させるのは面倒に感じた．

加えて`trainer`, `updater`辺りの構造を理解するのに学習コストが要るなと感じた．`extension`もロギングなどよく使う処理をパッケージ化できる所はメリットだと思うが，初めて書く人間にとってはさして複雑でない部分が隠蔽され逆にとっかかりづらいと感じる．慣れてしまえばDCGANの実装もKerasと同じくらいわかりやすくはあったので，忘れないよう継続して使っていきたいと思った．

あとは学習を繰り返すサイクルでは，ハイパーパラメータのチューニングがべらぼうに難しいという印象を受けた．そしてかなり時間がかかる．今回の3DGANではGCP上の Tesla K80 を使ったが1エポックに15分くらいかかった．1回50エポックで試すとしても一晩寝ても終わってない感じ．生成モデルは辛いですね．
