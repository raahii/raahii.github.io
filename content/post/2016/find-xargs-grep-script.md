+++
Categories = ["技術"]
Description = " はじめに  今回は頻繁につかうのに理解していないスクリプトがあるのでそれについて簡単に書こうと思います。そのスクリプトがコレです。"
Tags = ["cli", "ナレッジ"]
date = "2016-10-26T11:10:00+09:00"
title = "find | xargs grep を知る"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/10/26/find-xargs-grep-script", "/2016/10/find-xargs-grep-script"]
+++

{{< rawhtml >}}
<body>
<h1>はじめに</h1>

<p>今回は頻繁につかうのに理解していない<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>があるのでそれについて簡単に書こうと思います。その<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>がコレです。</p>

<pre class="code lang-sh" data-lang="sh" data-unlink> find . -name "*.py" -print0 | xargs -0 grep -i "pync"
 </pre>


<p>どんなことをする<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>かご存知ですか？</p>

<p>これはカレント<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リ以下にあるファイル<code>*.py</code>の中から<code>pync</code>という単語を含むものをリストアップする<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%EF%A5%F3%A5%E9%A5%A4%A5%CA%A1%BC">ワンライナー</a>です。すなわちこういうことです。</p>

<pre class="code lang-sh" data-lang="sh" data-unlink> find . -name "&lt;検索対象のファイルネーム&gt;" -print0 | xargs -0 grep -i "&lt;探したい単語&gt;"
 </pre>


<p>前から何度か使っていたものの、たまにしか使わないしすぐ忘れるだろうということで、すぐに<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B7%A5%A7%A5%EB%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">シェルスクリプト</a>ファイルで保存し「<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D6%A5%E9%A5%C3%A5%AF%A5%DC%A5%C3%A5%AF%A5%B9">ブラックボックス</a>化」していました。最近になって特に多用するようになってきたのでちゃんと理解しようと思います。</p>

<h1>解読</h1>

<p>まず、パイプの左側の<code>find</code>の部分について。</p>

<pre class="code lang-sh" data-lang="sh" data-unlink> find . -name "&lt;検索対象のファイルネーム&gt;" -print0
 </pre>


<p>言わずもがな<code>find .</code>でカレント<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リ以下の全ての<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リ・ファイルを列挙します。よくファイルを探す時に使いますね。</p>

<p>そして <code>-name "*.&lt;拡張子&gt;"</code>とすることで検索対象のファイルを限定します。ファイルをたくさん持つ<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リを検索するのであれば時間を短縮できます。加えてこれを使わずに実行すると、サブ<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リもリストアップされてしまい、パイプ以降に渡されるとエラーを起こします。結果が見づらくなるのでそれを防止する効果もありますね。</p>

<p>最後に<code>-print0</code>ですがこれは全く使ったことのないオプションだったのでmanで見てみると、</p>

<pre class="code" data-lang="" data-unlink> -print0
　This primary always evaluates to true. It prints the pathname of the current file to standard output, followed by an ASCII NUL character (character code 0). </pre>


<p>とあります。簡単に訳すと「この引数は常に真と評価されます。ファイルのパスをASCIIのnull文字（0）を付けて標準出力に出力します。」という感じでしょうか。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161026/20161026000730.png" alt="f:id:bonhito:20161026000730p:plain" title="f:id:bonhito:20161026000730p:plain" class="hatena-fotolife" itemprop="image"></span></p>

<p>実際に↑のような<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リで<code>-print0</code>を付けた場合とそうでない場合を比べてみます。</p>

<table>
<thead>
<tr>
<th style="text-align:center;"> </th>
<th style="text-align:center;">実行結果</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">-print0なし</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161026/20161026000830.png" alt="f:id:bonhito:20161026000830p:plain" title="f:id:bonhito:20161026000830p:plain" class="hatena-fotolife" itemprop="image"></span></td>
</tr>
<tr>
<td style="text-align:center;">-print0あり</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161026/20161026000836.png" alt="f:id:bonhito:20161026000836p:plain" title="f:id:bonhito:20161026000836p:plain" class="hatena-fotolife" itemprop="image"></span></td>
</tr>
</tbody>
</table>


<p><code>-print0</code>してもただつながってるようにしかみえませんが、hexdumpすると確認できます。</p>

<table>
<thead>
<tr>
<th style="text-align:center;"> </th>
<th style="text-align:center;">実行結果</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">-print0なし</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161026/20161026103848.png" alt="f:id:bonhito:20161026103848p:plain:w500" title="f:id:bonhito:20161026103848p:plain:w500" class="hatena-fotolife" style="width:500px" itemprop="image"></span></td>
</tr>
<tr>
<td style="text-align:center;">-print0あり</td>
<td style="text-align:center;"><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20161026/20161026103849.png" alt="f:id:bonhito:20161026103849p:plain:w500" title="f:id:bonhito:20161026103849p:plain:w500" class="hatena-fotolife" style="width:500px" itemprop="image"></span></td>
</tr>
</tbody>
</table>


<p>そして後半の<code>xargs</code>以降。</p>

<pre class="code lang-sh" data-lang="sh" data-unlink> xargs -0 grep -i "&lt;探したい単語&gt;"
 </pre>


<p><code>xargs</code>はこれも言わずもがなリダイレクトされた標準出力を次のコマンドの引数として渡すコマンドです。今回は次の<code>grep</code>に渡します。ただ<code>-0</code>はなんだろうということでmanを見ると</p>

<pre class="code" data-lang="" data-unlink> -0      Change xargs to expect NUL (``\0'') characters as separators, instead of spaces and newlines.  This is expected to be used in concert with the -print0 function in find(1). </pre>


<p>なるほど、<code>find</code>の<code>-print0</code>とペアなのだとわかります。これは高速化のためでしょうか。調べてみると全く違いました。実際使うとうまくいかないので気づくのですが、<code>xargs</code>は<b>スペースまたは改行で区切って順に<code>grep</code>の引数に渡してしまう</b>ので空白を含むファイルで<code>No such file or directory</code>のエラーがでてしまいます。</p>

<p><iframe src="//hatenablog-parts.com/embed?url=http%3A%2F%2Fkaworu.jpn.org%2Fkaworu%2F2008-12-08-1.php" title="UNIX findとxargsコマンドで-print0オプションを使う理由" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="http://kaworu.jpn.org/kaworu/2008-12-08-1.php">kaworu.jpn.org</a></cite></p>

<p>最後に<code>grep -i</code>ですが、同様にmanを見ると</p>

<pre class="code" data-lang="" data-unlink> -i, --ignore-case
             Perform case insensitive matching.  By default, grep is case sensitive. </pre>


<p><code>case insentive matching</code>とは大文字小文字を無視するということですね。</p>

<h1>まとめ</h1>

<p>当たり前ですが特別トリッキーなことはしていないので理解できて良かったです。大筋の流れとして<code>find</code>で列挙したファイル内の文字列に対して<code>grep</code>を実行するのだなというのもより強くインプットできました。また、最後に<code>grep</code>を実行するので最初に述べたように<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リが渡されるのはまずいというわけですね。</p>

<p>ただそれでも毎回打つのはやはり面倒くさいので、結局</p>

<pre class="code lang-sh" data-lang="sh" data-unlink> # find word
alias findword='find . -type f -print0 | xargs -0 grep -i $1'
 </pre>


<p>と.zshrcに追記。実際のケースでは比較的小さな作業用<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リを検索することが多いので<code>-name</code>で限定はせずに<code>-type f</code>でファイルのみを全て出力させています。</p>

<p>めでたしめでたし👏🏼 。かなりざっくり書いたので間違いや表現に問題があれば気軽にコメントいただけると嬉しいです。</p>

<h1>英語のお勉強メモ</h1>

<table>
<thead>
<tr>
<th style="text-align:center;">単語</th>
<th style="text-align:center;">意味</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;"><code>evaluate to</code></td>
<td style="text-align:center;"> <a href="http://d.hatena.ne.jp/ymoto/20080716/p1">"expression A evaluates to value B" なら、「式 A は値 B として評価される」という意味。</a>
</td>
</tr>
<tr>
<td style="text-align:center;"><code>followed by</code></td>
<td style="text-align:center;"> <a href="http://www.ldoceonline.com/dictionary/follow">"HAPPEN AFTER"</a> : to happen or do something after something else</td>
</tr>
</tbody>
</table>

</body>
{{< /rawhtml >}}
