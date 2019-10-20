+++
title = "なぜioutil.ReadFileはioutil.ReadAllより速いか"
date = 2019-10-13T00:36:12+09:00
category = ["技術"]
tags = ["golang", "io", "benchmark", "高速化", "コードリーディング"]
draft = false
description = "なぜioutil.ReadFileはioutil.ReadAllより速いか"
+++


# TL;DR
Goで**ファイル内容を読む場合** には，`ioutil.ReadFile` の方が `ioutil.ReadAll` よりも高速．なぜなら，読み込むデータの大きさがあらかじめわかっている場合は，内部のバッファサイズを決定でき，無駄なメモリ確保を無くせるから．



（いやなんで`ReadAll`を使うんだよ，というのはさておき．）



# ioutilパッケージの関数たち
Go言語には入力や出力を抽象化したインターフェース（`io.Reader` や`io.Writer` など）がある．このインターフェースはいわゆるファイル的な振る舞いをするものをまるっと同じように扱うためにとても便利なもの．`ioutil` パッケージも当然，それらをベースとしてさまざまな関数を実装している．

- [io.Reader](https://golang.org/pkg/io/#Reader) / [io.Writer](https://golang.org/pkg/io/#Writer)



ただし，抽象化するということは，それぞれに特化できないということでもある．実際に `ioutil.ReadAll` のコードを読むと，最初に512 バイトのバッファを用意し，ファイルのEOFを検知するまで2倍，4倍，8倍…とそのサイズを大きくしながら読み込みを行っている．これは，`io.Reader` から一体どのくらいのデータを読み込むかわからないために行うバッファリングの処理である．

- [func ReadAll - ioutil](https://golang.org/src/io/ioutil/ioutil.go?s=1186:1227#L34)


そこで，`ioutil.ReadFile`関数では，事前に`os`パッケージを使ってファイルの大きさを取得し，バッファサイズをそのとおりに確保することで一度にすべての内容を読み込んでいる．`ioutil.ReadAll` と同じAPIを使いたい場合には，ファイルオープンしてサイズを取得したあとに，`io.ReadFull` や`io.ReadAtLeast`を使うと良いと思う．



## ベンチマーク

- ソースコード

    最初の関数は固定長のバッファで読み込んだ場合．次は `ioutil.ReadAll` を使う場合．これは指数的にバッファサイズを大きくしていくので可変長のバッファで読み込むということ．次に `iotuil.ReadFile`．最後が`ioutil.ReadFile`と同等の処理をファイルサイズ取得+`io.ReadAll`で実装したもの．

```go
package main

import (
	"io"
	"io/ioutil"
	"os"
	"testing"
)

var filename = "bigfile" // 804,335,663 bytes

func BenchmarkFixedSizeBuffer(b *testing.B) {
	BUFSIZE := 4 * 1024

	for i := 0; i < b.N; i++ {
		file, err := os.Open(filename)
		if err != nil {
			panic(err)
		}
		defer file.Close()

		data := make([]byte, 0, BUFSIZE)

		buf := make([]byte, BUFSIZE)
		for {
			n, err := file.Read(buf)
			if n == 0 {
				break
			}
			if err != nil {
				panic(err)
			}
			data = append(data, buf...)
		}
	}
}

func BenchmarkReadAll(b *testing.B) {
	for i := 0; i < b.N; i++ {
		file, err := os.Open(filename)
		if err != nil {
			panic(err)
		}
		defer file.Close()

		_, err = ioutil.ReadAll(file)
		if err != nil {
			panic(err)
		}
	}
}

func BenchmarkReadFile(b *testing.B) {
	for i := 0; i < b.N; i++ {
		_, err := ioutil.ReadFile(filename)
		if err != nil {
			panic(err)
		}
	}
}

func BenchmarkReadFull(b *testing.B) {
	for i := 0; i < b.N; i++ {
		file, err := os.Open(filename)
		if err != nil {
			panic(err)
		}
		defer file.Close()

		fi, err := file.Stat()
		if err != nil {
			panic(err)
		}

		data := make([]byte, fi.Size())
		_, err = io.ReadFull(file, data)
		if err != nil {
			panic(err)
		}
	}
}
```

- 結果

```shell
❯ go test -bench . -benchmem -o pprof/test.bin  -cpuprofile pprof/cpu.out
goos: darwin
goarch: amd64
pkg: github.com/raahii/go-sandbox/read-bigfile
BenchmarkFixedSizeBuffer-4             3         363437901 ns/op        1293321805 B/op       51 allocs/op
BenchmarkReadAll-4                     7         171374293 ns/op        536869438 B/op        23 allocs/op
BenchmarkReadFile-4                   21          47905628 ns/op        209305932 B/op         5 allocs/op
BenchmarkReadFull-4                   25          44724078 ns/op        209305966 B/op         5 allocs/op
PASS
ok      github.com/raahii/go-sandbox/read-bigfile       7.531s
```



## :information_desk_person: :speech_balloon:

ただ，あくまでI/Oが高速であるという前提があるから成り立つ話であり，ネットワーク越しのデータアクセスのようにI/Oが遅い場合には．うまく並行処理を使ってバッファリングすると高速になるケースがあると思う．特に，最近インターンでAWS S3の大きめのファイルにアクセスする時にパフォーマンスが落ちる問題があったので`bufio`まわりのパッケージを読んでみようと思う．

