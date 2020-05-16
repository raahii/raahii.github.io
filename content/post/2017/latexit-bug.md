+++
Categories = ["研究"]
Tags = ["TeX", "ネタ", "ナレッジ"]
Description = " LaTeXiTはTeX数式を画像に変換できるツールですが、ついさっき使ったらプレビューに数式が表示されず、というか数式画像の生成自体に失敗しているみたいで全く使えないという事態に遭遇しました。  思い当たったのは最近brew update"
date = "2017-07-01T23:12:00+09:00"
title = "LaTeXiTで数式が表示されない問題"
author = "bonhito"
archive = ["2017"]
draft = false
aliases = ["/2017/07/01/latexit-bug", "/2017/07/latexit-bug", "/2017/07/231213"]
+++

{{< rawhtml >}}
<body>
<p>LaTeXiTは<a class="keyword" href="http://d.hatena.ne.jp/keyword/TeX">TeX</a>数式を画像に変換できるツールですが、ついさっき使ったらプレビューに数式が表示されず、というか数式画像の生成自体に失敗しているみたいで全く使えないという事態に遭遇しました。</p>

<p>思い当たったのは最近<code>brew update</code>した時に<code>ghostscript</code>がアップデートされたことだったので確認。</p>

<pre class="code" data-lang="" data-unlink> brew info ghostscript </pre>




<pre class="code" data-lang="" data-unlink> ghostscript: stable 9.21 (bottled), HEAD
Interpreter for PostScript and PDF
https://www.ghostscript.com/
/usr/local/Cellar/ghostscript/9.21_1 (8,484 files, 98.2MB)
  Poured from bottle on 2017-05-23 at 13:32:45
/usr/local/Cellar/ghostscript/9.21_2 (717 files, 64MB) *
  Poured from bottle on 2017-06-22 at 00:29:33
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/ghostscript.rb
==&gt; Dependencies
Build: pkg-config ✔
Required: little-cms2 ✔
==&gt; Requirements
Optional: x11 ✔
==&gt; Options
--with-x11
    Build with x11 support
--HEAD
    Install HEAD version </pre>


<p>確かに06/22に更新している。なんとなく怪しいのでバージョンを下げたらなおった。</p>

<pre class="code" data-lang="" data-unlink> brew switch ghostscript 9.21_1  </pre>


<p>詳しくないので理由はよくわからないが、<code>mac tex</code>で検索すると以下の記事が出てくるのでおそらくこれをみて<a class="keyword" href="http://d.hatena.ne.jp/keyword/TeX">TeX</a>をインス<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C8%A1%BC">トー</a>ルしたはず。改めて読んでみると<code>ghostscript</code>のインス<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C8%A1%BC">トー</a>ルと<code>TeX</code>のインス<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C8%A1%BC">トー</a>ルは別れているのでバージョンによって対応していないことはあり得る。</p>

<p><iframe src="https://hatenablog-parts.com/embed?url=http%3A%2F%2Fqiita.com%2Fhideaki_polisci%2Fitems%2F3afd204449c6cdd995c9" title="El Capitan / SierraでTeX環境をゼロから構築する方法 - Qiita" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="http://qiita.com/hideaki_polisci/items/3afd204449c6cdd995c9">qiita.com</a></cite></p>

<p>あるいは<code>TeX</code>をアップデートすれば良いのかもしれません。</p>
</body>
{{< /rawhtml >}}
