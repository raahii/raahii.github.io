+++
title = "画像データをサーバーにPOSTする"
date = 2019-08-04T04:13:59+09:00
categories = ["技術"]
tags = ["python", "機械学習", "backend", "http"]
draft = false
description = "画像データをサーバーにPOSTする"
aliases = ["/2019/08/04/files-upload", "/2019/08/files-upload"]
+++

機械学習を使ったサービス/アプリを開発しているとクライアントから画像をサーバーに送って推論して結果を返す，ということをよくやるのでメモ．

## 1枚しか送らない場合
今の所自分はこのパターンが多いです．いくつか実現方法はあると思いますが，リクエストボディに直接画像データのバイナリを入れて送る方法がシンプルで好きです．クライアント側のコードはこんな感じ．

```python
import json
import urllib.parse
import urllib.request

# read image data
f = open("example.jpg", "rb")
reqbody = f.read()
f.close()

# create request with urllib
url = "http://localhost:5000"
req = urllib.request.Request(
    url,
    reqbody,
    method="POST",
    headers={"Content-Type": "application/octet-stream"},
)

# send the request and print response
with urllib.request.urlopen(req) as res:
    print(json.loads(res.read()))
```

注意点として Content-Type に `application/octet-stream` を指定すると良いです．このMIMEタイプは曖昧なバイナリデータを指しており，ファイル種別を特に指定しないことを意味します（ref: [MIME type: application/octet-stream](https://www.iana.org/assignments/media-types/application/octet-stream) ）．

urllibの場合，これを指定しないとPOSTのデフォルトのMIMEタイプである `application/x-www-form-urlencoded` となり，サーバー側で正しく受け取れないので気をつけてください．

一方でサーバー側（flaskの場合）のコードはこのようになります．画像データをOpenCVで読んで画像のshapeをjsonで返しています．

```python
@app.route("/", methods=["POST"])
def example():
    # read request body as byte array
    _bytes = np.frombuffer(request.data, np.uint8)
    # decode the bytes to image directly
    img = cv2.imdecode(_bytes, flags=cv2.IMREAD_COLOR)

    return jsonify(img.shape)
```

ポイントはリクエストボディのバイト列を直接OpenCVのAPIで画像として読み込んでいるところです．この部分，一度画像データをファイルに書き出してから改めて読んでいるコードをよく見かけますが，直接できます．しかもこの方法だとjpegでもpngでも関係なく画像データに落とし込めるのでとっても楽です（OpenCVが優秀なだけ？）．

## 複数枚送る場合
バッチ処理なんかしたい場合は複数枚を同時に送りたいこともあると思います．その場合はやはり `multipart/form-data` だと思います（まぁそのためにあるので）．`multipart/form-data` は複数のファイルデータをBoundary文字列
で区切って連結し，送信する方法です．

ただその分，先のリクエスト方法よりも複雑なのでライブラリを使うと楽です．clientのサンプルコードです．

```python
import requests

images = {}
for i, f in enumerate(["example.jpg", "example.png"]):
    f = open(f, "rb")
    images[str(i)] = f.read()

url = "http://localhost:5000/multi"
res = requests.post(url, files=images)
print(res.json())
```

この場合，送りたい画像データはただの配列なのですが，どうやらdictで渡さないといけないようなので，indexを文字列にしてkeyとしました．これを使ってサーバー側のコードで順序を保証して取り出します．

```python
@app.route("/", methods=["POST"])
def example():
    # sort by key as integer
    files = sorted(request.files.items(), key=lambda x: int(x[0]))

    images = []
    for f in files:
        _bytes = np.frombuffer(f[1].read(), np.uint8)
        img = cv2.imdecode(_bytes, flags=cv2.IMREAD_COLOR)

        images.append(img.shape)

    return jsonify(images)
```

あんまりキレイではないですが，こんな感じでできます．ちなみに，画像データ以外のjsonデータを送りたい場合なんかも同様に `multipart/form-data`を使ってできるので万能ですね．

## 所感

覚えたぞ，`application/octet-stream`．
