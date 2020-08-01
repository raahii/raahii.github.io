+++
Categories = ["技術"]
Description = " 飯を食いながら記事が読みたい．でもご飯を口に入れながら上目遣いでディスプレイを見たり，片手にスマホを持ちながらみたいなのは嫌だという方．   まず，必要に応じてイヤホンをしましょう．  読みたい記事のテキストを選択しクリップボードにコピー"
Tags = ["ネタ"]
date = "2016-06-05T23:42:00+09:00"
title = "Macならできること　ぱーと１"
author = "bonhito"
archive = ["2016"]
draft = true
aliases = ["/2016/06/05/say-command-read-article-for-you", "/2016/06/say-command-read-article-for-you"]
+++

{{< rawhtml >}}
<body>
<h2>飯を食いながら記事が読みたい．でもご飯を口に入れながら上目遣いでディスプレイを見たり，片手に<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%DE%A5%DB">スマホ</a>を持ちながらみたいなのは嫌だという方．</h2>

<ol>
<li>まず，必要に応じてイヤホンをしましょう．</li>
<li>読みたい記事のテキストを選択し<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%AF%A5%EA%A5%C3%A5%D7%A5%DC%A1%BC%A5%C9">クリップボード</a>にコピーしましょう．</li>
<li>ターミナルで<code>pbpaste | say</code>とタイプしましょう．</li>
<li>以上です．高品質な<a class="keyword" href="http://d.hatena.ne.jp/keyword/%B2%BB%C0%BC%B9%E7%C0%AE">音声合成</a>技術に感謝しましょう．</li>
</ol>


<p>[補足]</p>

<ul>
<li>読み上げ時の声質を変更したい方はそういったことも可能です．</li>
<li>ちょっと打つのがめんどくさいなという人は<code>echo 'alias yomiage="pbpaste | say"' &gt;&gt; ~/.zshrc</code>などしましょう．</li>
<li>そう<a class="keyword" href="http://d.hatena.ne.jp/keyword/Mac">Mac</a>なら，ね．</li>
</ul>

</body>
{{< /rawhtml >}}
