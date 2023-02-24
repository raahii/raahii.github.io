+++
title = "DVDGAN - \"Adversarial Video Generation on Complex Datasets\""
date = 2019-10-29T11:34:06+09:00
tags = ["論文", "機械学習", "深層学習", "動画生成", "GAN"]
categories = ["研究"]
description = "論文'Adversarial Video Generation on Complex Datasets'のまとめ"
draft = false
images = ["/images/2019/dvdgan/arch_legend.png"]
keywords = ["DVDGAN", "video generation", "GAN", "Generative Adversarial Network", "generative model", "deep learning", "AI"]
aliases = ["/2019/10/29/dvdgan-adversarial-video-generation-on-complex-datasets", "/2019/10/dvdgan-adversarial-video-generation-on-complex-datasets"]
canonicalUrl = "https://raahii.me/posts/dvdgan-adversarial-video-generation-on-complex-datasets/"
+++




{{< rawhtml >}}
<div style="text-align: center; margin: 30px auto;">
  <img src="/images/2019/dvdgan/samples.gif" alt="generated videos" width="80%">
</div>
{{< /rawhtml >}}



DeepMindから出た新たな動画生成GANであるDVDGANを読んだのでまとめました．DVDはDual Video Discriminatorの略です:dvd: 

- [[1907.06571] Adversarial Video Generation on Complex Datasets](https://arxiv.org/abs/1907.06571)
- [Adversarial Video Generation on Complex Datasets | OpenReview](https://openreview.net/forum?id=Byx91R4twB&noteId=Byx91R4twB)（ICLR2020投稿中）





## TL;DR

* クラスベクトルを用いた条件付き動画生成タスクのGANを提案
* 高解像度で長い動画（ $48\times256\times256$ ）の生成に成功
* BigGAN[^biggan]ベースのアーキテクチャを採用
* 計算量の削減を目的に，2つの $\mathcal{D}$ を提案: 
  * 動画中の画像フレームを評価することに特化した$\mathcal{D}_S$ 
  * 時間的な変化を評価することに特化した $\mathcal{D}_T$
* UCF-101データセットでSOTA
* UCFよりもさらに大きいKinetics-600データセットを使い，様々な動画長・画像サイズでベースラインを提示



## Dual Video Discriminator GAN

従来のGANによる動画生成手法は，モデルアーキテクチャ（主にgenerator）に様々な工夫を行っていました．例えば…

- VideoGAN [^videogan]: 動画は「動的な前景」と「静的な背景」に分けられるという知識を活用．3DCNNで前景に当たる動画を生成し，2DCNNで1枚の背景を生成して合成する．

<!-- TGAN [^tgan]: 3DCNNを用いた動画生成は，空間的(spatial)な情報と時間的(temporal)な情報を一緒くたに扱ってしまうため問題であると指摘．それぞれの生成を別々の $\mathcal{G}$ で行う．-->

- FTGAN [^ftgan]: 時間的に一貫性を持ったより良い動きを生成するために Optical Flow を活用．VideoGANのアーキテクチャに加えて Optical Flow に条件付けられた動画を生成する．
- MoCoGAN  [^mocogan]: 動画は時間的に不変である「内容」と，各時刻で異なる「動き」の概念に分けられると主張．1動画を生成する際に「内容」の潜在変数は固定しながら，各フレームごとに異なる「動き」の潜在変数を次々とRNNで生成し，それらを結合した$z$から画像フレームを生成する．


などがありました．しかしながら，DVDGANではそのような特別な事前知識を用いず，代わりに「高容量のニューラルネットワークをデータドリブンマナーで学習させる」としており，実質，**大量のデータと計算資源で殴る:punch:**と言っています．



ではDVDGANの主な貢献は何かというと，BigGAN[^biggan]ベースのアーキテクチャを採用し，$\mathcal{D}$ で計算量を削減することで，より大きな動画の生成ができることを示したことだと思います．全体のモデルアーキテクチャは次のようになっています．



{{< rawhtml >}}
<div style="text-align: center;">
  <figure>
    <img src="/images/2019/dvdgan/arch_legend.png" alt="mode architecture" width="100%">
	</figure>
</div>
{{< /rawhtml >}}





### Generator

DVDGANでは動画のクラス情報を使った条件付き動画生成を行います．



まず，正規分布から潜在変数 $z$ をサンプルし，動画のクラスベクトル $y$ のembeddingである $e(y)$ [^emb]と結合します．どちらも120次元のベクトルです．このベクトルを全結合層を用いて$4\times4$の特徴マップに変換します．

その後， Convolutional Gated Recurrent Unit (RNN) [^conv-gru1][^conv-gru2]→ ResNet Block の処理を繰り返し行い（図青の部分），各時刻の画像フレームを生成します．この処理は1度行うと特徴マップの大きさを2倍にするので，例えば$64\times64$ の画像サイズを持つ動画であれば，4回繰り返すこととなります．肝心の動画の時間変化のモデル化はRNNの状態ベクトル $h$ を時間方向に展開することによって学習しています．この展開は特徴マップが最初にRNNを通過するときに1度だけ行われるとのことです．



### Discriminator

最初に書いたとおり，2つの $\mathcal{D}$ を持ち，それぞれの役割に基づいて計算量を減らします．

一つは動画中の画像内容の批判に特化した Spatial Discriminator ($\mathcal{D}_S$)（図上）です．2DのResNet Blockで構成されており， **動画からランダムに抜き出した$k$ 個の画像フレームのみ** を入力します．

もう一つは時間変化の批判に特化した Temporal Discriminator ($\mathcal{D}_T$)（図下）で，3DのResNet Blockで構成されています．これには動画を入力しますが，**すべての画像フレームにダウンサンプリング処理 $\phi(\cdot)$ を適用して**から入力します．

時間と空間で担当を分けてしまい，いらない情報は極力削減するということですね．なおそれぞれのハイパラは $k=8$ ， $\phi(\cdot)$ は $2\times2$ のaverge poolingが採用されています．これにより， $\mathcal{D}_S$では $8 \times H \times W$ ，$\mathcal{D}_T$ では$T \times \frac{H}{2} \times \frac{W}{2}$ のピクセルを処理する計算になりますが，これは $48 \times 128 \times 128$の動画を **単純に1つの $\mathcal{D}$ で全ピクセル処理するのと比べると59%の削減**となります．



ちなみに，$k$ と $\phi(\cdot)$ を決める根拠となった実験も記載されていました． $\phi(\cdot)$ はaverage pooling（$4\times4$，$2\times2$），恒等写像，半分の大きさにランダムクロップするの4通りを，$k$ は1, 4, 8, 10 の4通りを検証しています．



{{< rawhtml >}}
<div style="text-align: center;">
  <figure>
		<img src="/images/2019/dvdgan/fixed_kphi.png" alt="k and phi tuning experiment result" >
	</figure>
</div>
{{< /rawhtml >}}



FIDは低いほうが，ISは高いほうがより良い指標です．$\phi(\cdot)$についてはダイレクトにISを劣化させる結果となり，$k$ は8を超えると効果が薄くなることが見て取れますね．



### Training settings

GANではモデルに加えてこちらも重要ですが，ほとんどBigGANと同じ…ですかね．ロスには hinge loss [^biggan][^hinge1] を用います．
$$
\mathcal{D}: \min _{\mathcal{D}} \underset{x \sim data(x)}{\mathbb{E}}[\rho(1-\mathcal{D}(x))]+\underset{z \sim p(z)}{\mathbb{E}}[\rho(1+\mathcal{D}(\mathcal{G}(z)))],
$$

$$
\mathcal{G}: \max _{\mathcal{G}} \underset{z \sim p(z)}{\mathbb{E}}[\mathcal{D}(\mathcal{G}(z))].
$$



その他のトレーニング設定は次のとおりです．

- すべての重みに Spectral Norm[^sn]を適用
- 初期化は Orhogonal initialization[^orth-init] 
- バッチサイズ 512
- Adam，lrは$G$が $10^{-4}$，$D$ が $5\cdot10^{-4}$
- $\mathcal{G}$ と $\mathcal{D}$ の更新比は 1:2
- $\mathcal{G}$ では $[z; e(y)]$ を用いて  [class-conditional Batch Normalization](https://raahii.github.io/2018/12/12/conditional-batch-normalization/) を使用
- $\mathcal{D}$ ではprojection discriminator[^prod-dis]を使用



## Experiment



### UCF-101でSOTA

まず，UCF-101データセット[^ucf]で従来手法と IS(Inception Score)[^is] で比較をしています．UCF-101は本来は行動認識のためのデータセットですが，動画生成では最もよく用いらます．全101クラス，13320動画で構成されています．



$16\times128\times128$の動画生成で評価した結果，**DVDGANのISは32.97とTGANv2[^tganv2] の24.34を大きく上回る精度を見せて**います．



{{< rawhtml >}}
<div style="text-align: center;">
  <figure>
    <img src="/images/2019/dvdgan/table2.png" alt="inception score for ucf-101 dataset"  width="80%">
  </figure>
</div>
{{< /rawhtml >}}



しかし，appendixで但し書きがされており，DVDGANはそのモデル容量の大きさから部分的に訓練サンプルを記憶している可能性が高いと自ら言っています．その証拠に，サンプルのinterpolation[^interp]を行うと，滑らかに変化しない場合があったり，訓練サンプルと酷似したサンプルが生成されたようです．（行ごとに独立，動画の最初の1フレームのみ提示）．

{{< rawhtml >}}
<div style="text-align: center;">
  <figure>
		<img src="/images/2019/dvdgan/overfit.png" alt="interpolation for ucf-101 dataset" width="100%">
  </figure>
</div>
{{< /rawhtml >}}

この訓練サンプルの記憶に関し，著者らはInception Scoreという評価指標の欠点であり，同時に，UCF-101は動画生成を検証するのに不十分である（クラス数も各クラス毎のサンプル数も不足している）と指摘しています．



### Kinetics-600でベースラインを提示

これを踏まえ，Kinetics-600[^kinetics]と呼ばれるUCF101よりもさらに大きなデータセットでも実験を行っています．これもまた行動認識のデータセットで，全600クラス・およそ50万動画と，UCF-101の6倍のクラス数・40倍のサンプル数を擁しています．各クラスには少なくとも600以上のサンプルが収録されているようです．

このデータセットを使い，論文では今後のベースラインとなるよう様々な解像度・長さの動画でISとFID(Frechet Inception Distance)[^fid] を提示しています．



{{< rawhtml >}}
<div style="text-align: center;">
  <img src="/images/2019/dvdgan/table1.png" alt="score for kinetics-600 dataset" width="80%">
</div>
{{< /rawhtml >}}



ちなみにWith Truncationの列は，BigGANで提案されたTruncation Trick[^trunc]と呼ばれるテクニックを用いた場合の最良の値を指しています．



実験の結果から，小さな動画はきれいなテクスチャや構図，動きを持っているが，動画サイズが大きくなるにつれて，一貫性のある物体や動きの生成が困難になると述べられています．しかしながら，$\mathcal{D}_S$  に入力するフレーム数 $k$ を固定した状態で，生成動画の長さを12→48と増やした時，観測できるフレーム数が相対的には減るにも関わらず，同程度に高解像の動画を学習できることがわかったそうです．やはり問題は動きの学習ということでしょうか．



また，Kineticsの場合だとinterpolationもうまくいったそうです．



{{< rawhtml >}}
  <div style="text-align: center;">
    <figure>
      <img src="/images/2019/dvdgan/intra_interp.png" alt="a interpolation for kinetics-600 dataset" width="100%">
      <figcaption>クラスをまたぐ補間</figcaption>
    </figure>
  </div>

<div style="text-align: center;">
    <figure>
      <img src="/images/2019/dvdgan/inter_interp.png" alt="a interpolation for kinetics-600 dataset" width="100%">
      <figcaption>同クラスでの補間</figcaption>
    </figure>
</div>
{{< /rawhtml >}}

実際の生成サンプルは下記リンクに上がっています．

- [12x64x64](https://drive.google.com/file/d/155F1lkHA5fMAd7k4W3CQvTsi1eKQDhGb/view), [12x128x128](https://drive.google.com/file/d/165Yxuvvu3viOy-39LhhSDGtczbWphj_i/view), [12x256x256](https://drive.google.com/file/d/1RGRVKCpVaG8z3p9GBCamRk4apiIR7jUc/view)
- [48x64x64](https://drive.google.com/file/d/1FjOQYdUuxPXvS8yeOhXdPQMapUQaklLi/view), [48x128x128](https://drive.google.com/file/d/1P8SsWEGP6tEGPPNPH-iVycOlN6vpIgE8/view)

私個人の印象としては，画像はきれいなのですがやはり動きがまだ不自然だと思いました．風景画は良いですが，人や物が絡むと剛体運動をしていない（物自体の形が不自然に変わる）のが気になります．



ちなみに学習は **32〜512 TPU pods でおよそ12〜96時間** とのことです:cold_sweat: 



実験の章ではさらに動画予測にDVDGANを拡張して実験を行っていますが，これについては割愛します（すいません）．



## 所感

- 特別な事前知識を使わずにデータで殴るのは正しいと思う．ただ，ここまで大規模なデータでも不自然になるということは，動きをうまく学習できる機構は未だ存在していないと言わざるを得ないと思います．
  
- $ \mathcal{D}$ を複数にして，空間と時間で担当を分けるという発想はこれが初めてではない．実際，MoCoGANも全く同様に2つの $\mathcal{D}$ を提案しており（DVDGANの $k=1$ ， $\phi(\cdot)$ が恒等写像である場合に相当する），こうすることで学習の収束が早まると指摘している．そういった意味でも，DVDGANはアーキテクチャの工夫というよりはむしろ，計算量の削減に注力したと言えます．
- 現在の動画生成では計算量と精度に関するトレードオフを評価する慣習はないので，計算量を削減しながらSOTAを更新しているのはすごい．もちろん計算量の削減なしには現実的に難しいこともあるが，単純にスコアを上げるだけならまだ余裕があるように見える．

- $\mathcal{D}$ の$k$や$\phi$のチューニングに関する実験結果は，FIDは時間的な劣化に疎く，ISは空間的な劣化に疎い，というようにも解釈できる．いずれにしても，ISやFIDが動画の品質を正しく評価できているかは微妙だなぁという実感は日頃からあるので，主観評価もあったらなお良かった気がします．



[^videogan]: C. Vondrick+, 2016, "Generating Videos with Scene Dynamics",  https://arxiv.org/abs/1609.02612
[^tgan]: M. Saito+, 2017, "Temporal Generative Adversarial Nets with Singular Value Clipping", https://arxiv.org/abs/1611.06624
[^ftgan]: K. Ohnishi+, 2018, "Hierarchical Video Generation from Orthogonal Information: Optical Flow and Texture", https://arxiv.org/abs/1711.09618
[^mocogan]: S. Tulyakov+, 2018, "MoCoGAN: Decomposing Motion and Content for Video Generation", https://arxiv.org/abs/1707.04993
[^biggan]: A. Brock+, 2019, "Large Scale GAN Training for High Fidelity Natural Image Synthesis", https://arxiv.org/abs/1809.11096
[^conv-gru1]: N. Ballas+, 2015, "Delving Deeper into Convolutional Networks for Learning Video Representations", https://arxiv.org/abs/1511.06432
[^conv-gru2]: I. Sutskever+, 2011, "Generating Text with Recurrent Neural Networks", https://www.cs.utoronto.ca/~ilya/pubs/2011/LANG-RNN.pdf
[^fid]: M. Heusel+, 2017, "GANs Trained by a Two Time-Scale Update Rule Converge to a Local Nash Equilibrium", https://arxiv.org/abs/1706.08500
[^is]: T. Salimans+, 2016, "Improved Techniques for Training GANs", https://arxiv.org/abs/1606.03498
[^tganv2]: M. Saito+, 2018, TGANv2: Efficient Training of Large Models for Video Generation with Multiple Subsampling Layers, https://arxiv.org/abs/1811.09245
[^interp]: GAN界隈では，2点の潜在ベクトルの内挿を線形補間などで行い，順にgeneratorで生成してその変化を観測することを指す．
[^ucf]: UCF101 - Action Recognition Data Set, https://www.crcv.ucf.edu/data/UCF101.php
[^kinetics]: Kinetics - DeepMind, https://deepmind.com/research/open-source/kinetics
[^trunc]: 正規分布の裾の方から取った潜在ベクトルは見た目や構造が崩れたサンプルになりやすいことから，そういった潜在ベクトルを棄却することで，多様性（diversity）を少々犠牲にしつつも本物らしさ（fidelity）を確保しようというテクニック．より正確には[^biggan]を参照．
[^emb]: 論文中では "a learned linear embedding $e(y)$ of the desired class $y$. "と表記されていますが，詳細は[^biggan]にあるのでしょうか…．おそらくですが，クラスを単純な1-of-Kの符号化ではなく，より近い概念であれば近くなるように符号化したい意図があると思います．
[^sn]: T. Miyato+, 2018, "Spectral Normalization for Generative Adversarial Networks", https://arxiv.org/abs/1802.05957
[^orth-init]: AM. Saxe+, 2013, "Exact solutions to the nonlinear dynamics of learning in deep linear neural networks ", https://arxiv.org/abs/1312.6120
[^prod-dis]: T. Miyato, 2018, "cGANs with Projection Discriminator", https://arxiv.org/abs/1802.05637
[^hinge1]: J. Hyun+, 2017, "Geometric GAN", https://arxiv.org/abs/1705.02894
