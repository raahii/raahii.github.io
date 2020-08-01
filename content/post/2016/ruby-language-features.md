+++
Categories = ["技術"]
Description = " Railsでサービス作ってみたは良いものの、Rubyに関する理解が結構おろそかになっている。なので、今回は基本的だけど未だに理解できていない部分を簡単にまとめる。  Rubyはすべてがオブジェクト  Rubyに入門すると一度は耳にする「R"
Tags = ["ruby"]
date = "2016-12-22T01:18:00+09:00"
title = "Rubyの文法のミニメモ"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/12/22/ruby-language-features", "/2016/12/ruby-language-features"]
+++

{{< rawhtml >}}
<body>
<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Rails">Rails</a>でサービス作ってみたは良いものの、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>に関する理解が結構おろそかになっている。なので、今回は基本的だけど未だに理解できていない部分を簡単にまとめる。</p>

<h1>
<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>はすべてがオブジェクト</h1>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>に入門すると一度は耳にする「<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>は<strong>完全に</strong><a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AA%A5%D6%A5%B8%A5%A7%A5%AF%A5%C8%BB%D8%B8%FE">オブジェクト指向</a>的な言語である」という文言。入門したときはあまり深く考えていなかったので、よく考えると「いやいや<a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>にだってクラスはあるんだから<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AA%A5%D6%A5%B8%A5%A7%A5%AF%A5%C8%BB%D8%B8%FE">オブジェクト指向</a>は使えるじゃん」とか思っていた。<a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AA%A5%D6%A5%B8%A5%A7%A5%AF%A5%C8%BB%D8%B8%FE">オブジェクト指向</a>は後付けのものだということを聞いたことがあるので、まぁそんな程度の違いだろうという曖昧な理解だった。</p>

<p>しかし、改めて調べてみて<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>が完全に<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AA%A5%D6%A5%B8%A5%A7%A5%AF%A5%C8%BB%D8%B8%FE">オブジェクト指向</a>的であることが簡単にわかる例があったので書いておく。</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> # Rubyが完全にオブジェクト指向的であるというということは
# 1などの定値もオブジェクトになっているということ
p 1.class # =&gt; Fixnum

# 1がオブジェクトならmethodを持っているよね
p 1.methods # =&gt; [:%, :&amp;, :*, :+, ・・・]

# +というメソッドがあるなら足し算はこう書ける
p 1.+(1) #=&gt; 2

# 数字がオブジェクトのおかげでこういうRubyらしい書き方ができる
10.times {|i| print i} # =&gt; 0123456789
 </pre>


<p>なるほど。これで前よりは少し理解が進んだ。</p>

<h1>シンボルとハッシュ</h1>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>にはシンボルという型がある。<code>:(変数名)</code>で定義でき、注意点は</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> :symbol == :"symbol" # =&gt; true
 </pre>


<p>となること。</p>

<p>このシンボルであるが、よくハッシュで使われる。ハッシュはkeyとvalueで構成され、一般的にkeyは文字列で定義される。</p>

<p>しかし、keyを文字列として扱うと、valueを参照（keyの識別）する際にコストの高い文字列処理を行わなければならなくなる。ここでシンボルである。</p>

<p>端的にいうと、シンボルは任意の名前をつけることの出来る整数である。例えば<code>:symbol</code>というシンボルはなんらかの整数と紐付けられており、常に一定となっている。よってシンボルをkeyとすることで、文字列処理を行わなければ行けなかったところを、<strong>コストの低い整数処理</strong>に置き換えることが出来る。</p>

<p>わかりやすい例として、以下のようなコードを実行してみると、同じ文字列でも異なるオブジェクトidとなることがわかる。異なるオブジェクトなのだから当然といえば当然である。</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> a = "test"
b = "test"
a.equal?(b) # =&gt; false 
 </pre>


<p>一方、シンボルはオブジェクトによらない。</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> a = :test
b = :test
a.equal?(b) # =&gt; true
 </pre>


<p>ネットで調べると「<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>のシンボルは文字列の皮を被った整数だ」という表現がされていて、的確だなと思った。文字列を内容のためではなく、一種の固有な識別子として使うコードを書こうとしているときにはシンボルのほうが適切である。</p>

<p>また、ここからは余談だが、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby1.9">Ruby1.9</a>以降では</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> numbers = {"one" =&gt; 1, "two" =&gt; 2, "three" =&gt; 3}
numbers["one"] # =&gt; 1

numbers = {:one =&gt; 1, two =&gt; 2, three =&gt; 3}
numbers[:one] # =&gt; 1
 </pre>


<p>のような標準的な記法に加え、</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> numbers = {one: 1, two: 2, three: 3}
 </pre>


<p>という省略記法がある。この省略記法では自動的にkeyがシンボルになるので注意が必要である。</p>

<h1>do, {}, () の使い分け</h1>

<p>特に<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%A4%A5%C6%A5%EC%A1%BC%A5%BF">イテレータ</a>を使う時の使い分けが混同する。
例えば、</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> 10.times {|i| p i}
 </pre>


<p>と</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> 10.times do |i|
  p i 
end
 </pre>


<p>は同じ動きをする。一般的にはブロックの中身が1行のときは<code>{}</code>が、複数行となるときは<code>do</code>が習慣的に使われるので覚えておく。ちなみに<code>do</code>や<code>{</code>はメソッド呼び出しと同じ行にあれば良いので、</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> # do endを一行で
10.times do |i| p i end

# {}を複数行で
10.times { |i|
  p i
}
 </pre>


<p>と逆の形で書いても特にエラーにならないことも覚えておく。</p>

<p>また、<code>do</code>に関しては</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> text = File.open("./test.txt") do |f|
  filesize = f.stat.size
  f.read
end
 </pre>


<p>のような形で使われることも度々あるが、単に最後に評価した値が<code>text</code>に入るだけなので驚く必要はない。ブロックで区切られているので分かりやすいといえばそうかもしれない。</p>

<p>最後に、<a class="keyword" href="http://d.hatena.ne.jp/keyword/RSpec">RSpec</a>を使っていて、<code>()</code>と<code>{}</code>を同様の役割で使っていて少し混乱した例があった。</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> specify { expect(1+1).to eq(2) }
 </pre>




<pre class="code lang-ruby" data-lang="ruby" data-unlink> specify { expect{1+1}.to eq(2) }
 </pre>


<p>上記の2つは<code>expect</code>の括弧が異なっているが同じ動作をする。なんなんだこれはと思い調べると、<a href="https://docs.ruby-lang.org/ja/latest/class/Proc.html">Procオブジェクト</a>というものであることがわかった。</p>

<p>簡単に言うと、Procオブジェクトはブロック（<code>{|i| p i }</code>など）をオブジェクト化したものである。深く理解したわけではないが雰囲気をつかむには以下のサイトが役に立った（古いけど）。</p>

<p><iframe src="//hatenablog-parts.com/embed?url=http%3A%2F%2Fd.hatena.ne.jp%2Fyoshidaa%2F20090511%2F1241967137%2320090511f1" title=" Ruby の yield って結局なんなの？ - YNote" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="http://d.hatena.ne.jp/yoshidaa/20090511/1241967137#20090511f1">d.hatena.ne.jp</a></cite></p>

<p>ではブロック（またはProcオブジェクト）を引数として渡すと何が嬉しいのか。これは推測だが、おそらく関数の引数に関数を渡すことが出来るという点でメリットがあるのだと思う。ついでに気づいたのだけれど、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>はすべてがオブジェクトであると言いつつも、ブロックや関数はオブジェクトではない気がする。だからこそ関数そのものをオブジェクト化できる<code>Proc</code>にメリットがあるのではなかろうか。</p>

<p>上記の<a class="keyword" href="http://d.hatena.ne.jp/keyword/RSpec">RSpec</a>の例だと、おそらく<code>expect(1+1)</code>では、<code>expect(2)</code>と同様の動作していて、<code>expect{1+1}</code>はそのまま<code>{1+1}</code>というブロックが<code>expect</code>内で評価されて実行されるように<code>expect</code>が作られているのだと思う。</p>

<p><code>Proc</code>は要勉強。</p>

<h1>改行して良いところ</h1>

<p>これもあるあるだけど、書いていて長くなってしまった文を途中で改行したくなることがある。ただ、どこでなら改行していいのかわからなくなる。</p>

<p>基本的に改行は文の終端と判断されるので、改行する前の部分のみで評価が成立しまう文は改行できない（<code>\</code>でエスケープしてやる必要がある）。一方、評価が継続されるような場合は改行しても問題ない。例えば、</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> numbers = {
  one: 1
  two: 2
  three: 3
}
 </pre>


<p>は問題ない。ただこれは結局わかりやすいルールとはいえなくて、慣れが必要だなと思う。</p>

<h1>所感</h1>

<p>まだ知っている言語が少ないせいかもしれないが、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>の<code>10.times</code>や<code>10.upto</code>はとても見やすくて好き。<code>do end</code>も<code>Python</code>のインデントに比べるとネストが深くなった時に幾分見やすいように感じる。</p>

<p>ただ<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>本当に独特なルールも多くて、メソッドの括弧を省略できるのが慣れない。というのも、サンプルコードをコピペしたりしていると、メソッドに対してそれがメソッドだと認識せずに使っていたりすることがある。
例えば</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> # uptoはメソッドで10が引数。前後の括弧は省略されている
1.upto 10 do |x|
    p x
end

# よってこういうことをするとエラーになる
1.upto 10 {|x| p x}
 </pre>


<p>のように、エラーが出て初めて気づく例がある。また、括弧がないせいでメソッドと変数がパッと見分けられなかったりもする。メリットとしては、括弧を省略できると打つのが楽になる。括弧がないので引数の変更も楽になる。それぐらいかな…。</p>

<p>あとついでに、関数内で最後に評価された値が自動的に返されるのも慣れない。返り値を変えるために関数の最後で変数を呼ぶだけの行があったりすると苦笑してしまう。<code>return</code>と書いたほうが良いと思う。</p>

<p>今後新たに気付きがあればまた書きたいなと思う。</p>

<p></p>
<div class="hatena-asin-detail">
<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873113946/hatena-blog-22/"><img src="http://ecx.images-amazon.com/images/I/41CGDEMgyoL._SL160_.jpg" class="hatena-asin-detail-image" alt="プログラミング言語 Ruby" title="プログラミング言語 Ruby"></a><div class="hatena-asin-detail-info">
<p class="hatena-asin-detail-title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873113946/hatena-blog-22/">プログラミング言語 Ruby</a></p>
<ul>
<li>
<span class="hatena-asin-detail-label">作者:</span> <a class="keyword" href="http://d.hatena.ne.jp/keyword/%A4%DE%A4%C4%A4%E2%A4%C8%A4%E6%A4%AD%A4%D2%A4%ED">まつもとゆきひろ</a>,David Flanagan,卜部昌平(監訳),長尾高弘</li>
<li>
<span class="hatena-asin-detail-label">出版社/メーカー:</span> <a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AA%A5%E9%A5%A4%A5%EA%A1%BC%A5%B8%A5%E3%A5%D1%A5%F3">オライリージャパン</a>
</li>
<li>
<span class="hatena-asin-detail-label">発売日:</span> 2009/01/26</li>
<li>
<span class="hatena-asin-detail-label">メディア:</span> 大型本</li>
<li>
<span class="hatena-asin-detail-label">購入</span>: 21人 <span class="hatena-asin-detail-label">クリック</span>: 356回</li>
<li><a href="http://d.hatena.ne.jp/asin/4873113946/hatena-blog-22" target="_blank">この商品を含むブログ (129件) を見る</a></li>
</ul>
</div>
<div class="hatena-asin-detail-foot"></div>
</div>
</body>
{{< /rawhtml >}}
