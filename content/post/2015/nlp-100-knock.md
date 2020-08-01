+++
Categories = ["技術"]
Description = " 「研究者流コーディングの極意」を読んで、なんだかためになりそうだし、面白そうだし、ということで言語処理100本ノックを始めてみました。そして2つ目で詰まった(早い)。 使っている言語はPythonで、使い始めたばかりなのですが、そもそもプ"
Tags = ["python", "coding", "NLP"]
date = "2015-06-28T21:10:00+09:00"
title = "Pythonの日本語文字列"
author = "bonhito"
archive = ["2015"]
draft = true
aliases = ["/2015/06/28/nlp-100-knock", "/2015/06/nlp-100-knock", "/2015/06/211051"]
+++

{{< rawhtml >}}
<body>
<p>「<a href="http://www.chokkan.org/publication/coding-for-researchers.pdf">研究者流コーディングの極意</a>」を読んで、なんだかためになりそうだし、面白そうだし、ということで言語処理100本ノックを始めてみました。そして2つ目で詰まった(早い)。<br>
使っている言語は<a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>で、使い始めたばかりなのですが、そもそもプログラミングがダメダメです。</p>
<p>まず、その問題ですが、</p>

    <blockquote>
        <p>01. 「パタトクカシーー」<br>
「パタトクカシーー」という文字列の1,3,5,7文字目を取り出して連結した文字列を得よ．</p>

    </blockquote>
<p>です。</p>
<p>まず私が考えたのは、こんな感じです。なんの疑問もなくこれでいけるだろうと思ってました笑。</p>
<pre class="code lang-python" data-lang="python" data-unlink> string="パタトクカシーー"
rev=""
for i in [1,3,5,7]:
   　rev+=string[i]
print rev
 
</pre>
<p>一方結果は、</p>
<pre class="code" data-lang="" data-unlink> % python 01.「パタトクカシーー」.py
�㿃 
</pre>
<p>なんか文字化けしてる…。<br>
それもそのはずで、「パタトクカシーー」は全て全角文字なのでひとひねり必要です。一般に半角は1byte、全角は2byteに符号化されているので、配列のお部屋と1:1対応にならないのが原因。<br>
そして<a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>の場合、通常のstr型の全角文字は3byteに符号化されている（お部屋3つに対応している）みたいです。</p>
<pre class="code" data-lang="" data-unlink> &gt;&gt;&gt; 'あ'[0]
'\xe3'
&gt;&gt;&gt; 'あ'[1]
'\x81'
&gt;&gt;&gt; 'あ'[2]
'\x82'
&gt;&gt;&gt; 'あ'[3]
Traceback (most recent call last):
  File "&lt;stdin&gt;", line 1, in &lt;module&gt;
IndexError: string index out of range 
</pre>
<p>この記事が参考になりました。<iframe src="//hatenablog-parts.com/embed?url=http%3A%2F%2Fqiita.com%2Fyubessy%2Fitems%2F9e13af05a295bbb59c25" title="Python2のstr/unicodeとencode/decode - Qiita" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="http://qiita.com/yubessy/items/9e13af05a295bbb59c25">qiita.com</a></cite></p>
<p>これを知ったうえで愚直に書き換えると、</p>
<pre class="code lang-python" data-lang="python" data-unlink> string="パタトクカシーー"
rev=""
for i in [1,3,5,7]:
    for j in range(3):#全角なので
        rev+=string[3*i+j]
print rev
 
</pre>
<pre class="code" data-lang="" data-unlink> % python 01.「パタトクカシーー」.py
タクシー 
</pre>
<p>うまくいったー！！</p>
<p>また、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>には全角文字でもお部屋と1:1対応してくれる便利な型があります。「<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%E6%A5%CB%A5%B3%A1%BC%A5%C9">ユニコード</a>文字列」です。</p>
<pre class="code lang-python" data-lang="python" data-unlink> string=u"パタトクカシーー"
rev=""
for i in [1,3,5,7]:
    rev+=string[i]
print rev
 
</pre>
<p>これでもできます。便利。<br>
超基礎的な文字列処理ですが、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>で鍛え直します…。</p>
</body>
{{< /rawhtml >}}
