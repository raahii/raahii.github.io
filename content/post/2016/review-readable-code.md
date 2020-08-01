+++
Categories = ["読書"]
Description = " 私は現在，人に自分のコードを見てもらう機会はそう多くありません．しかし，今年度は卒業研究を行ったため，作ったプログラムを研究室に残す必要があり，どうせ残すなら読みやすいコードにしたいな，と思い本書を手に取りました．     リーダブルコー"
Tags = ["coding"]
date = "2016-03-04T13:54:00+09:00"
title = "リーダブル・コード(1)"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/03/04/review-readable-code", "/2016/03/review-readable-code"]
+++

{{< rawhtml >}}
<body>
<p>私は現在，人に自分のコードを見てもらう機会はそう多くありません．しかし，今年度は卒業研究を行ったため，作ったプログラムを研究室に残す必要があり，どうせ残すなら読みやすいコードにしたいな，と思い本書を手に取りました．</p>

<p></p>
<div class="hatena-asin-detail">
<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873115655/hatena-blog-22/"><img src="http://ecx.images-amazon.com/images/I/51MgH8Jmr3L._SL160_.jpg" class="hatena-asin-detail-image" alt="リーダブルコード ―より良いコードを書くためのシンプルで実践的なテクニック (Theory in practice)" title="リーダブルコード ―より良いコードを書くためのシンプルで実践的なテクニック (Theory in practice)"></a><div class="hatena-asin-detail-info">
<p class="hatena-asin-detail-title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873115655/hatena-blog-22/">リーダブルコード ―より良いコードを書くためのシンプルで実践的なテクニック (Theory in practice)</a></p>
<ul>
<li>
<span class="hatena-asin-detail-label">作者:</span> Dustin Boswell,Trevor Foucher,須藤功平,<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B3%D1%C0%AC%C5%B5">角征典</a>
</li>
<li>
<span class="hatena-asin-detail-label">出版社/メーカー:</span> <a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AA%A5%E9%A5%A4%A5%EA%A1%BC%A5%B8%A5%E3%A5%D1%A5%F3">オライリージャパン</a>
</li>
<li>
<span class="hatena-asin-detail-label">発売日:</span> 2012/06/23</li>
<li>
<span class="hatena-asin-detail-label">メディア:</span> 単行本（ソフトカバー）</li>
<li>
<span class="hatena-asin-detail-label">購入</span>: 68人 <span class="hatena-asin-detail-label">クリック</span>: 1,802回</li>
<li><a href="http://d.hatena.ne.jp/asin/4873115655/hatena-blog-22" target="_blank">この商品を含むブログ (133件) を見る</a></li>
</ul>
</div>
<div class="hatena-asin-detail-foot"></div>
</div>

<p>まず，私自身がもともとプログラミングする上でなんとなく意識していたことは次のようなことです．</p>

<ul>
<li>変数名はより短くするよりも，より客観的に意味が通るものにすべき</li>
<li>変数や関数の命名法は統一すべき</li>
<li>処理は巧妙に短く書くのではなく，多少長くてもストレートに書くべき</li>
<li>コメントは書いたほうが良い</li>
</ul>


<p>この内，日頃最も難しいと感じていた部分はやはり変数名です．客観的に意味の通るちょうどよい名前というのはそう簡単に思いつくものではなく，大体省略形にしたり，特に意味のない単語を割り当てたりしていました．</p>

<p>この記事では，「リーダブルコード」を読んで，特に自分が実践したいと思ったことについてまとめていきます．また，今回は「リーダブル・コード」の第一部のみをピックアップし，基本的には「表面的な部分を変更する」ことでよりコードをリーダブルにする方法をまとめたものです．</p>

<h1>1. 命名はより的確な単語を使う</h1>

<p>それが思いつかないから困ってるという話なわけですが，ここで言いたいことは，すぐに思いつく「汎用的な単語」を安易に選択せず，より「限定的なニュアンスの単語」を選択するべきだということです．</p>

<p>例えば，</p>

<pre class="code lang-python" data-lang="python" data-unlink> #インターネットからページ情報を取得する
def GetPage(url):
 </pre>


<p>のような関数ならば，<code>Get</code>ではなく<code>Fetch</code>や<code>Download</code>を使うとわかりやすくなります．「取得する」んだからとりあえず…と汎用的な単語である<code>get</code>を使うと意味がぼやけるのです．他にも，</p>

<pre class="code lang-python" data-lang="python" data-unlink> #textの最後を切り落として「．．．」をつける
def Clip(text, length):
 </pre>


<p>のような関数では，よくある<code>length</code>を引数として使ってしまいがちですが，長さ(<code>length</code>)の単位によってもっと具体的に</p>

<table>
<thead>
<tr>
<th style="text-align:center;"> 単位    </th>
<th style="text-align:center;"> 引数 </th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;"> 行数    </td>
<td style="text-align:center;"> row  </td>
</tr>
<tr>
<td style="text-align:center;"> 文字数  </td>
<td style="text-align:center;"> char </td>
</tr>
<tr>
<td style="text-align:center;"> 単語数  </td>
<td style="text-align:center;"> word </td>
</tr>
<tr>
<td style="text-align:center;"> <a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%D0%A5%A4">バイ</a>ト数 </td>
<td style="text-align:center;"> byte </td>
</tr>
</tbody>
</table>


<p>などを使い分けるのが適切です．このように，より限定的な意味の単語を選択することで読み手の誤解を減らし，わかりやすくすることができます．自分は他にもmakeやconvertを多用する傾向にあるので気をつけたいです．</p>

<p>ただ，ここで問題なのが，それを意識しながらコードを書いても，結局的確な単語を選ぶことは難しいということです．その分野に精通していて，かつ経験もないといけません．なのでまず，
<a href="http://thesaurus.weblio.jp/">類語辞典</a>
や
<a href="https://codic.jp/">codic</a>
を使うということを実践していきたいです．これらのサイトを使うことは単に和英辞書を使うよりもおそらく効果的です．まぁ結局は関連分野の用語を学んだり，<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%BD%A1%BC%A5%B9%A5%B3%A1%BC%A5%C9">ソースコード</a>を読んだりできるとベストですかね．．．</p>

<p><iframe src="//hatenablog-parts.com/embed?url=http%3A%2F%2Fwww.kaoriya.net%2Fblog%2F2014%2F01%2F04%2F" title="codic-vim プラグイン — KaoriYa" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="http://www.kaoriya.net/blog/2014/01/04/">www.kaoriya.net</a></cite></p>

<p>また，いくら的確な名前でも，長い名前にはどうしてもうんざりしてしまいます．これについては「補完機能を使え」とのことでした．<a class="keyword" href="http://d.hatena.ne.jp/keyword/vim">vim</a>なら<code>Ctrl-P</code>で補完できます．</p>

<h1>2. 命名はパターンに落とし込む</h1>

<p>命名においてもうひとつ実践したいのが，わかりやすい命名方法のパターンを学び利用することです．
例えば，</p>

<pre class="code lang-python" data-lang="python" data-unlink> def ConvertToString():
 </pre>


<p>のような関数の場合，Convertは省略して，<code>ToString</code>だけの方がスマートになります．このように<code>前置詞+名詞</code>の省略形をパターンとして使うことが有効だと考えられます．また，変数名に属性を加えるとわかりやすくなります．これには，</p>

<pre class="code lang-python" data-lang="python" data-unlink> time_s = 10
delay_ms = 100
 </pre>


<p>のように属性として単位を後ろに付けたり，</p>

<pre class="code lang-python" data-lang="python" data-unlink> plaintext_password = "12345"
 </pre>


<p>のようにパスワードが暗号化されていないことを明示するといったものが挙げられます．1つ前に登場した<code>Clip()</code>でも，引数の<code>length</code>には限界値のニュアンスがあるので<code>max_</code>をつけたりするとわかりやすくなります．</p>

<h1>3. 命名法はうまく使い分ける</h1>

<p>命名法はオブジェクトの種類に応じて変えることで，一種の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B7%A5%F3%A5%BF%A5%C3%A5%AF%A5%B9">シンタックス</a>ハイライトのようになり，判別しやすくなるという利点があります．よってコード内で完全に統一しなければならないというわけではなく，以下のように「関数名はキャメルケース，変数名はスネークケース」のようによく使われるみたいです．</p>

<pre class="code lang-python" data-lang="python" data-unlink> def ListenToMusic(song_title):
 </pre>


<h1>4. コードからすぐわかることをコメントに書かない</h1>

<p>今年度の始め頃に，「前年度の研究プログラムを引き継いだは良いが，まるでコメントが書いてない！最悪だ！」というケースを頻繁にみかけました．確かに，「それは最悪かも知れないな」と思うわけですが，そのような事態を受けてか来年度のためにプログラムを残すにあたって「とりあえずコメントは書いてあればまし」みたいな雰囲気がありました．しかし．例えば</p>

<pre class="code lang-python" data-lang="python" data-unlink> # 音声ファイルのパスをコマンドライン引数で受け取る
audio_file = sys.argv[1]

# 音声から振幅値とサンプリング周波数を抽出する
amplitude, sampling_rate = WaveRead(audio_file)

# FFTをして周波数解析する
spectrum = FastFourierTransform(amplitude)
 </pre>


<p>にあるようなコメントは本当に必要でしょうか．これはなんとなく今思いついたコードですが，コメントを書かずとも関数名，変数名，処理の流れから何をしているかが十分に読み手に伝わると思います．このようなコメントを書くのであれば，例えばamplitude配列の要<a class="keyword" href="http://d.hatena.ne.jp/keyword/%C1%C7%BF%F4">素数</a>が2の累乗になっていない場合，FastFourierTransform()はどのような動作をするのかを簡潔に書いたり，処理のさらに細かい部分の説明を書くべきです．</p>

<h1>5.コメントで自分の考えを記録する</h1>

<p>また，コメントでは自分がなぜそのようなコード書いたのかということや，そのコードの注意点についてまさに「コメント」しておくことも重要です．例えば，</p>

<pre class="code lang-python" data-lang="python" data-unlink> # 合理的な限界値．人間はこんなに読めない．
MAX_RSS_SUBSCRIPTIONS = 1000
 </pre>


<p>のようなものです．これによって，その記述がなぜそのようになっているのかを読み手に示すことができます．他にも，</p>

<pre class="code lang-python" data-lang="python" data-unlink> # TODO: amplitudeが2の累乗でない場合にはDFTをするようにする
spectrum = FastFourierTransform(amplitude)
 </pre>


<p>のように<code>TODO:</code>を使って課題点を示したり，</p>

<pre class="code lang-python" data-lang="python" data-unlink> # spectrumのi番目の要素は，i*len(amplitude)/sampling_rate[Hz]の振幅スペクトルの値である
spectrum = FastFourierTransform(amplitude)
 </pre>


<p>のように，あらかじめひっかかりやすい点を明示することで質の良いコメントを残すことができます．他にも，処理の流れやまとまりについて簡単な要約文を残しておくことも有効でしょう．</p>
</body>
{{< /rawhtml >}}
