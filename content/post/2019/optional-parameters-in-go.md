+++
title = "Goでオプショナルパラメータをどう扱うか"
date = 2019-12-31T13:13:35+09:00
categories = ["技術"] # 技術, 研究, 読書, レビュー, 旅行
tags = ["golang", "design pattern"]
images = ["https://i.ytimg.com/vi/xBYzglyidIc/maxresdefault.jpg"]
keywords = ["オプショナル引数", "デフォルト引数", "オプショナルパラメータ", "オプショナル引数", "関数オプション引数", "Functional Options", "Functional Option Pattern", "Go", "golang"]
description = "Goのオプショナル引数の実装パターン"
draft = false

+++



## TL; DR

状況によって下記を使い分けるのが良さそう．とりあえずFunctional Option Patternでも良いかも．


- 複数の関数を用意する

	オプショナル引数が少ない場合に有効．シンプルだが拡張性が低い．

  

- 引数用の構造体を用意する

	構造体を使うのでユーザービリティが良く実装も容易．ただし，引数の未指定とゼロ値を分離するためには値のポインタを使う必要がある．

  

- Functional Option Patternを使う

	デザインパターンとして提案されているだけあって，クリーンで拡張性が高い．敢えてデメリットを挙げるとすると，このパターンを知らないユーザーからするとやや直感的でない．実装側は引数毎に関数を定義する必要があり記述量が増える．
  
  


## はじめに
Goには関数のオプショナルパラメータ（デフォルトパラメータ）がありません．しかし，「必要最低限の挙動をする分にはユーザーが意識する必要のない引数」というのはよくあり，必要に迫られます．

実際，先日 [Kutt.it](https://kutt.it) というURL短縮サービスの[APIのクライアントをGoで書いた](https://github.com/raahii/kutt-go)ときに，Web API側にデフォルトパラメータがあったので，これをGoでどう実装すべきか迷いました．何番煎じかわかりませんが，せっかくなので実装パターンをまとめておきます．


## 異なるシグネチャの関数を用意する
最も簡単なのはいくつも関数を用意してしまうことです．ここでは`name` を受け取って `Hello, {name}!`と出力するだけの関数 `Greet` を例に見てみます．

```go
func Greet(name string) {
	fmt.Printf("Hello, %s!\n", name)
}

func main() {
	Greet("gopher") // Hello, gopher!
}
```

このとき挨拶の言葉を`”Hello”`ではなく`”Hey”`にも出来るようにしたくなりました．そこで，今回のパターンでは新たに関数 `GreetWithOpts` を定義して，挨拶の言葉`greetingWord` を受け取れるようにします．

```go
func GreetWithOpts(name string, greetingWord string) {
	fmt.Printf("%s, %s!\n", greetingWord, name)
}

func main() {
	GreetWithOpts("gopher", "Hey") // Hey, gopher!
}
```

関数を分けることでオプショナルパラメータを実現しました．このパターンは引数が少ない場合や関数パターンをシンプルにとどめておく分には実用的ですが，引数が増えてくると辛くなりそうです．


## 引数用の構造体を用意する
ではもっと複雑な引数の場合はどうすべきでしょうか．デフォルトパラメータは引数を部分的に指定（＝可変長な引数の受け入れ）できれば良いので，構造体が使えそうです．

```go
// 引数を示す構造体
// フィールドが未指定だったのか，ゼロ値が指定されたのかを
// 区別するため，型はポインタにする
type GreetOpts struct {
	GreetingWord *string
}

// オプショナルパラメータを構造体で受け取る
func Greet(name string, opts *GreetOpts) {
	greetingWord := "Hello"
	if opts.GreetingWord != nil {
      // 引数がnilだったら未指定なのでデフォルト値で埋める
		greetingWord = *opts.GreetingWord
	}
	fmt.Printf("%s, %s!\n", greetingWord, name)
}

func main() {
	Greet("gopher", &GreetOpts{}) // Hello, gopher!

	word := "Hey"
	Greet("gopher", &GreetOpts{GreetingWord: &word}) // Hey, gopher!
}
```

構造体を渡す一手間が増えましたが，必須／オプショナルパラメータが明確に分離できています！また，構造体の定義を見れば受け取るパラメータが一目で分かるのも良いところです．

一点，構造体は初期化時に未指定のフィールドがゼロ値で埋まります．そのため，引数が実際に未指定だったのか，ゼロ値が指定されたのかを区別するため，型をポインタにして `nil` を受け取れるようにしています．パラメータが各プリミティブ型のゼロ値を取らないのであれば，ポインタを使う必要はないかもしれません．

このパターンは[AWSのGoのSDK](https://godoc.org/github.com/aws/aws-sdk-go)で実際に使われています．例えば，S3からファイルをダウンロードするコードでは，GetObjectInput構造体を使って大半の引数を指定します．内部ではこの構造体に対してバリデーションを行い，必須パラメータのチェックを行っています．

- [S3 ファイルダウンロードの例](https://docs.aws.amazon.com/sdk-for-go/api/service/s3/#hdr-Download_Manager)
- [GetObjectInput構造体](https://github.com/aws/aws-sdk-go/blob/a0d8dcfc0eb373ebe88dd1dde3a19374af4a8705/service/s3/api.go#L12757-L12832) ※1万行目辺りに飛ぶので時間かかります
- [GetObjectInputのバリデーション](https://github.com/aws/aws-sdk-go/blob/a0d8dcfc0eb373ebe88dd1dde3a19374af4a8705/service/s3/api.go#L12845-L12864)

また，各プリミティブ型のポインタを取る操作も，直接値を指定できるようにユーティリティ関数が用意してあります（↑の例でもそうですが定数”Hey”のポインタは取れないので一度変数に入れる必要がありました）．

- [aws.String()関数（stringのポインタ）](https://github.com/aws/aws-sdk-go/blob/v1.26.8/aws/convert_types.go#L6-L8)



## Functional Option Pattern

最後にDave Cheney氏が提案したデザインパターンである[Functional Options](https://commandcenter.blogspot.com/2014/01/self-referential-functions-and-design.html)があります．先程と同様に内部では構造体を用いますが，ユーザーに構造体の状態を変更する関数を指定させます．

```go
type GreetOpts struct {
	GreetingWord string
}

type option func(*GreetOpts)

// GreetingWord引数を設定する関数
func GreetingWord(v string) option {
	return func(g *GreetOpts) {
		g.GreetingWord = v
	}
}

func Greet(name string, opts ...option) {
	// デフォルトパラメータを定義
	g := &GreetOpts{
		GreetingWord: "Hello",
	}
	
	// ユーザーから渡された値だけ上書き
	for _, opt := range opts {
		opt(g)
	}

	fmt.Printf("%s, %s!\n", g.GreetingWord, name)
}

func main() {
	Greet("gopher")                      // Hello, gopher!
	Greet("gopher", GreetingWord("Hey")) // Hey, gopher!
}
```

確かに，このパターンを用いると，引数を何も指定しない場合は省略でき，ポインタの指定なども必要ないので，引数の構造体パターンよりも便利そうです！

ただ，実装によって引数とその引数を設定する関数の名前が異なるのが若干煩わしい気もします．実装者側もパラメータ毎に関数を定義する必要があるので記述量は増えそうですね．



## おわりに
やはり総合的にはFunctional Optionsが良さそうですね．正直オプショナル引数ぐらいあれば良いのに…と書きながら思ったのですが，そういう「あっても良いけどマストじゃない機能」を削ぎ落とした結果がGoのシンプルさに繋がっているのかなとも思いました．

あと，[GoのリポジトリのStar数ランキング](https://github.com/search?l=Go&o=desc&q=stars%3A%3E10000&s=stars&type=Repositories)を見ながらデフォルト引数が使われているのか見ていたのですが，そもそもあまり使われてないようですね．そういう意味ではきちんと最初の「引数を変えるパターン」でシンプルに実装されているライブラリが多いということなのかもしれません．

デフォルト引数として使われているかは不明ですが，関数の引数が構造体を取るパターンは大規模なライブラリでもよく見られました．逆にFunctional Optionsは比較的新しめ・小さめのライブラリ（ex. [vbauerster/mpb](https://github.com/vbauerster/mpb)）で使われている印象でした．

もしFunctional Optionsを採用している大きなプロジェクトとかあったらぜひ教えて下さい．



## 参考

- [Dealing with Optional Parameters in Go - Peter Malina - Medium](https://medium.com/@petomalina/dealing-with-optional-parameters-in-go-9780f9bfbd1d)
- [Self-referential functions and the design of options](https://commandcenter.blogspot.com/2014/01/self-referential-functions-and-design.html)
- [golangの関数のオプション引数を実現する | 69log](https://blog.kazu69.net/2018/02/22/golang-functional-options/)

---

## P.S Appliable Functional Option Pattern (AFOP)

- [Functional Option Pattern に次ぐ、オプション引数を実現する方法](https://ww24.jp/2019/07/go-option-pattern/)

Functional Option Patternの問題点として，パラメータに同じ値を設定する場合でも返り値の関数が同値とならないことが挙げられるそうです．これは mock を用いたテストにおいて問題となります．

```go
func main() {
	fmt.Println(reflect.DeepEqual(GreetingWord("Hey"), GreetingWord("Hey"))) // false
}
```



上の記事ではこれを解決するFOPとしてAFOPを提案しています．

```go
type GreetOpts struct {
	GreetingWord string
}

type option interface {
	Apply(*GreetOpts)
}

type GreetingWord string

func (o GreetingWord) Apply(g *GreetOpts) {
	g.GreetingWord = string(o)
}

func SetGreetingWord(v string) GreetingWord {
	return GreetingWord(v)
}

func Greet(name string, opts ...option) {
	g := &GreetOpts{
		GreetingWord: "Hello",
	}
	for _, opt := range opts {
		opt.Apply(g)
	}

	fmt.Printf("%s, %s!\n", g.GreetingWord, name)
}

func main() {
	Greet("gopher")                                                          // Hello, gopher!
	Greet("gopher", SetGreetingWord("Hey"))                                  // Hey, gopher!
	fmt.Println(reflect.DeepEqual(GreetingWord("Hey"), GreetingWord("Hey"))) // true
}
```



またこのAFOPパターンは[googleapis/google-api-go-client](https://github.com/googleapis/google-api-go-client/blob/v0.7.0/option/option.go) で使われているみたいですね．