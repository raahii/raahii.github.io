+++
title = "Goで順列（permutation）を実装する"
date = 2019-04-07T12:22:55+09:00
categories = ["競プロ", "実装", "Go"]
draft = false

+++



配列の並び替えのパターンの列挙をする関数をgolangで書く．[ABC123](https://atcoder.jp/contests/abc123)で必要になったので．

# TL;DR

QuickPermを使うと良さそうです．

<script src="https://gist.github.com/raahii/6dd5f44e469f32200bd805700981a10d.js"></script>

<script src="https://gist.github.com/raahii/e53932d299c38a52ad5f114ca6641e1c.js"></script>

上記はコピペ用でこっからはいくつか方法を試して最後に速度比較します．

# 方法1: naive dfs

素直にdfsをする．前から数字を決めていって，決めたらその数字を選択肢から消して次へ行く．全部使ったら（選択肢が無くなったら）1つのパターンとして採択する．

<script src="https://gist.github.com/raahii/9115d1bd0592aec243f47987c4c7dc4a.js"></script>

上のコードで使ってるサブ関数たちです．この後の方法でも使ってるのですが面倒なので1度だけ掲載．

<script src="https://gist.github.com/raahii/f0f3d7e2fd8c4b8f11c7278b45e43858.js"></script>

# 方法2: Heap Algorithm

 [Heapのアルゴリズム](https://ja.wikipedia.org/wiki/Heap%E3%81%AE%E3%82%A2%E3%83%AB%E3%82%B4%E3%83%AA%E3%82%BA%E3%83%A0) を使う．

<script src="https://gist.github.com/raahii/d0fa00607fda89cb954607d188371e0e.js"></script>

# 方法3: QuickPerm

[QuickPerm](http://www.quickperm.org/)を使う．

<script src="https://gist.github.com/raahii/23e962eb81a43275445702cc0101381e.js"></script>



# 方法4（おまけ）: QuickPerm + Channel

[Generate all permutations in go](https://stackoverflow.com/questions/30226438/generate-all-permutations-in-go)とかを見ているとChannelを使った実装をしているので早いのか？と思って試してみた．

<script src="https://gist.github.com/raahii/2d6128b09895c388e223f55ffacdea7f.js"></script>


# 速度比較

go testでベンチマーク取ります．

<script src="https://gist.github.com/raahii/1186cc916e7c54531e73a82ef42de679.js"></script>


方法3のQuickPermが一番早そうです．方法4は非同期でやっても単に結果くるまでブロッキングしてるので，goroutineやchannelの生成の分で普通に遅そうですね．まだgoroutineを書くの慣れてないのでコードが怪しいかもしれません．

```
goos: darwin
goarch: amd64
pkg: github.com/raahii/go-sandbox/permutations
BenchmarkPermute1-4  2    684403978 ns/op   637542560 B/op   9895161 allocs/op
BenchmarkPermute2-4  5    285790686 ns/op   377401424 B/op   3628802 allocs/op
BenchmarkPermute3-4  5    216943042 ns/op   377401440 B/op   3628802 allocs/op
BenchmarkPermute4-4  1   1215330546 ns/op   290305888 B/op   3628817 allocs/op
PASS
ok      github.com/raahii/go-sandbox/permutations       7.580s
```
