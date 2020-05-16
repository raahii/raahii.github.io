+++
title = "TeXShopでバックスラッシュが円マークになる問題"
date = 2018-05-06T23:46:20+09:00
categories = ["技術"]
tags = ["論文", "TeX", "TexShop"]
draft = false
aliases = ["/2018/05/06/texshop-yen-mark-problem", "/2018/05/texshop-yen-mark-problem"]
+++

これまでTeX資料はTeXShopで書いていたのだけど、最近になって[overleaf (v2)](https://v2.overleaf.com/)を使うようになった。そこで、TeXShopから文章をコピペしてみたら`\`が`¥`に変換されるという問題が起こった。これだとoverleafに貼り付けた時に全部置換しなくてはならない。

この現象を見た時、何故か`.tex`の文章自体がTeXShopに書き換えられておかしくなってるのかと勘違いしてしまったのだけど、vimで開いても普通に`\`で表示されるので、どうやらこれはTeXShopがあえてクリップボードをいじってるらしいということがわかった。

ぐぐってみたところその通りで、TeXShopはデフォルトでクリップボードの中身の`\`を`¥`に書き換えるようだった。`編集 > クリップボードで\を¥に変換`で設定を変更できる。なぜそのような機能がデフォルトでONになっているのかはわからない。

[TeXShopからソースをコピーすると\が¥でコピーされてしまう ─ TeXShop FAQ](https://texwiki.texjp.org/?TeXShop%20FAQ#xd11f52a)

{{< rawhtml >}}
<center>
{{< figure src="/images/2018/texshop-yen-mark-problem/setting.png" width="200px" title="TeXShopの設定">}}
</center>
{{< /rawhtml >}}


おそらく勘違いしたのは、これまでもOS Xでこんな感じの現象を見たことがある気がしていて、まさかTeXShop固有の問題とは思わなかったのが原因だろうと思う。とりあえず置換すれば良いか〜などと思って、

```
pbpaste | sed -e "s/¥/\\\/g" | pbcopy
```

みたいなことをしていたので恥ずかしい。反射的に手っ取り早い解決方法に手をつけてしまうのではなく、一旦手を止めて問題の本質的な原因を考える癖を付けないといけないなぁと思った。もちろん当たり前でやってるつもりなんだけど改めて…。
