---
title: "tensorboard-chainerにビデオを記録するためのPRを出した"
date: 2018-05-13T21:37:27+09:00
draft: false
---

機械学習における可視化ツールの1つに[TensorBoard](https://www.tensorflow.org/programmers_guide/summaries_and_tensorboard)がある。これはTensorflowに付属しているソフトウェアで、学習時のlossやaccuracy、重みのヒストグラムなどを記録することができる。加えて、画像や音声などのデータも記録出来るので、生成モデルの学習でも便利に使える。

自分は普段Chainerで書いていてそのままではtensorboardは使えないので[tensorboard-chainer](https://github.com/neka-nat/tensorboard-chainer)を使わせてもらっている。これとてもありがたい。

ただ、研究テーマが動画生成なので、動画も記録できれば便利なのに…とずっと思っていた。最近真面目にどうにか出来ないかと思って調べたら`.gif`の記録は元々できるらしいことがわかった。

- [Video summary support · Issue #39 · tensorflow/tensorboard · GitHub](https://github.com/tensorflow/tensorboard/issues/39)

ということで、動画を記録できるメソッドを実装してプルリクエストを出した。初めて出したのだけれど、カバレッジやコード規約をチェックしてくれるツールに初めて触れた。外からだとテストが通らなかった理由がいまいちわからないので若干困ったけど、慣れれば便利そう。とりあえずマージはされたので良かったです。

- [add method "add_video" to SummaryWriter by raahii · Pull Request #2 · neka-nat/tensorboard-chainer · GitHub](https://github.com/neka-nat/tensorboard-chainer/pull/2)

ということでtensorboard-chainerの`add_video`メソッドで動画記録できます。fpsも指定できます。便利。

<video style="max-width: 100%;" src="http://localhost:51332/videos/2018/add-video-for-tensorboard-chainer/tensoboard_video.mp4" autoplay loop></video>
