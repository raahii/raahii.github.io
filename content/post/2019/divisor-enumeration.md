+++
title = "約数の全列挙の高速化"
date = 2019-03-23T18:05:02+09:00
categories = ["技術"]
tags = ["高速化", "golang", "競プロ"]
draft = false

aliases = ["/2019/03/23/divisor-enumeration", "/2019/03/divisor-enumeration"]
+++



ある整数 $n​$ の約数を全て探すとき，普通は $1​$ から $n​$ までを走査するfor文で1つ1つ約数判定を行う．この場合の計算量は $O(n)​$ であり，制約が $n \leq 10^9​$ のような競プロのコンテストでは通常通らないと考える．


しかし，  $n=a \times b$ を満たすような整数ペア $a, b (a \leq b)$ を考えると， $a \leq\sqrt{n}$ を満たすため，これを利用することで $O(\sqrt{n})$ で約数を全列挙できる．

{{< rawhtml >}}
<script src="https://gist.github.com/raahii/da59306b9f30b9b06a59a84276b4d3a7.js"></script>
{{< /rawhtml >}}

ちなみにこれは [Atcoder ABC112 D](https://atcoder.jp/contests/abc112/tasks/abc112_d) で使用した．実はGoで書くと $n$ が $10^9$ でも通るのだけど，まぁ増やされたらそれまでなのでまとめてみた．

{{< rawhtml >}}
<blockquote class="twitter-tweet" data-partner="tweetdeck"><p lang="ja" dir="ltr">ついに同解法でGoなら通るがPythonだと駄目ってのを観測した <a href="https://t.co/Qd6V2PsGgX">pic.twitter.com/Qd6V2PsGgX</a></p>&mdash; raahii (@raahiiy) <a href="https://twitter.com/raahiiy/status/1109362308638072832?ref_src=twsrc%5Etfw">March 23, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
{{< /rawhtml >}}


