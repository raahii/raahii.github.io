+++
Categories = ["研究"]
Description = " 最近、GANで3Dオブジェクトを生成する論文を読んでいました。下のスライドは雑なまとめなのですが、前者が所謂3D-GANと呼ばれている論文で初めて3Dオブジェクトの生成にGANを適用した論文です。後者はその3D-GANを応用した研究のよう"
Tags = ["深層学習", "GAN", "3D", "実装", "javascript", "three.js"]
date = "2017-10-09T01:32:00+09:00"
title = "ボクセルデータを描画するツールを作った"
author = "bonhito"
archive = ["2017"]
draft = false
aliases = ["/2017/10/09/tool-preview-3d-voxel-data", "/2017/10/tool-preview-3d-voxel-data", "/2017/10/voxel"]
+++

{{< rawhtml >}}
<body>
<p>最近、GANで3Dオブジェクトを生成する論文を読んでいました。下のスライドは雑なまとめなのですが、前者が所謂3D-GANと呼ばれている論文で初めて3Dオブジェクトの生成にGANを適用した論文です。後者はその3D-GANを応用した研究のようです。</p>

<div style="width: 100%; display: flex; justify-content: space-around;">
<script async class="speakerdeck-embed" data-id="f2cc2ea6c2ba4a51aba20235e9cdf413" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>
<script async class="speakerdeck-embed" data-id="b1bd4d40396541899cbe3b21c498f94c" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>
</div>


<p><br>
どんなものか知るには著者らが公開している動画が非常にわかりやすいです。静止画と同じようにGANを3Dモデルにも適用できそうだということがわかります。</p>

<div align="center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/mfx7uAkUtCI" frameborder="0" allowfullscreen></iframe>
</div>


<p><br>
ということで<a class="keyword" href="http://d.hatena.ne.jp/keyword/github">github</a>にあがっている実装などを参考に実際にやろうとしているところなのですが、これらの手法では主に3Dオブジェクトを「ボクセル」として扱っています。</p>

<p>このボクセルというのは「体積 (volume)」と「<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D4%A5%AF%A5%BB%A5%EB">ピクセル</a> (pixel)」を組み合わせた<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A4%AB%A4%D0%A4%F3%B8%EC">かばん語</a>らしいのですが、要は画像と同じ要領で3Dモデルを3次元配列に格納して表したものです。イメージとしてはマインクラフトみたいな感じです。</p>

<p><a href="https://www.gamersnexus.net/images/media/2012/features/voxels-vs-vertexes.png" class="http-image" target="_blank"><img src="https://www.gamersnexus.net/images/media/2012/features/voxels-vs-vertexes.png" class="http-image" alt="https://www.gamersnexus.net/images/media/2012/features/voxels-vs-vertexes.png"></a></p>

<p>CGでは頂点情報や法線、テクスチャなどを保存する<code>.obj</code>, <code>.3ds</code>などが有名（らしい）ですが、それらに比べると非常に簡単で取り扱いやすくなっています。</p>

<p>その一方でボクセルデータを保存する形式には<a href="http://www.patrickmin.com/binvox/binvox.html"><code>.binvox</code></a>があるのですが、メジャーではないためかツールが少なめです（まぁただの3次元配列だしね…）。ざっくり探したところ以下のものは便利そうだなと思いました。</p>

<ul>
<li><p><code>.binvox</code>を3次元配列に変換: <a href="https://github.com/dimatura/binvox-rw-py">dimatura/binvox-rw-py</a>(<a class="keyword" href="http://d.hatena.ne.jp/keyword/python">python</a>)</p></li>
<li><p><code>.obj</code>や<code>.mtl</code>を読み込んで変換し、ボクセルとして可視化: <a href="http://drububu.com/miscellaneous/voxelizer/">Online Voxelizer</a>(web)</p></li>
</ul>


<p>ただ、単に<code>.binvox</code>ファイルをアップロードしてすぐに中身を見れるツールはなさそうだったので今回はそれを作ってみました（というエントリです）。<a href="https://piyo56.github.io/simple_voxel_viewer/index.html">ここ</a>から試せます。</p>

<p><iframe src="https://hatenablog-parts.com/embed?url=https%3A%2F%2Fgithub.com%2Fpiyo56%2Fsimple_voxel_viewer" title="piyo56/simple_voxel_viewer" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="https://github.com/piyo56/simple_voxel_viewer">github.com</a></cite></p>

<p>ボクセルは形式そのものがシンプルなので<code>matplotlib</code>を使って3dplotするのでも良いのですが、結構重いんですよね。<code>three.js</code>を使えばWeb上でマウスでグリグリできるインターフェースを簡単に作れるので楽しいですし、いつかフロントエンドで使えるかも…。</p>

<p>先程紹介した<a href="http://drububu.com/miscellaneous/voxelizer/">Online Voxelizer</a>に比べると動作がかなり遅いしメモリも結構消費してしまうのでそこが今後の課題です。うーん…おしまい。</p>
</body>
{{< /rawhtml >}}
