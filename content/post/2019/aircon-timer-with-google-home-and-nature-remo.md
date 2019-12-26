+++
title = "Google HomeとNature Remoでエアコンのタイマーを快適にセットする"
date = 2019-12-26T09:52:39+09:00
categories = ["技術"] # 技術, 研究, 読書, レビュー, 旅行
tags = ["nature remo", "google home", "home automation", "aws"]
images = [""]
keywords = ["Nature Remo", "Google Home", "エアコンタイマー"]
description = "Google HomeとNature Remoを活用してエアコンの入タイマーをかんたんに設定する"
draft = true

+++



<!--
<div style="text-align: center;">
  <figure>
    <img src="/images/2019/aircon/thumb.jpg" alt="thumbnail" width="100%" style="margin-bottom: 10px;">
    <figcaption>最後にデモあります！</figcaption>
	</figure>
</div>
-->

<div style="text-align: center; margin-top: 40px;">
  <video src="/images/2019/aircon/demo.mov" controls muted preload="auto" width="100%">
		<p>動画を再生するにはvideoタグをサポートしたブラウザが必要です。</p>
	</video>
</div>




## はじめに

この時期になると朝寒くてお布団から出るのが辛いですね…．せっかく一度目を覚ましたのに部屋が寒すぎてエアコンを付けて二度寝…．あるあるです．

なので我々はエアコンのタイマーをセットしますね．でもこのタイマーがちょいと曲者．

1. まず明日何時に起きるかを考えて…
2. 今から逆算して何時間後かを計算して…
3. 入タイマーボタンを何度も押してその時間をセット

と機種によりますが大体こんな感じ．すごく面倒．



これ本当は「明日○時にエアコン付けて」のワンステップで良くないですか？

というか…何か変ですよね…

<div style="text-align: center;">
  <figure>
    <img src="https://stat.ameba.jp/user_images/20191023/10/nomu222/27/2c/j/o0605035114621804625.jpg?caw=400" alt="system design" width="60%" style="margin-bottom: 10px;">
    <figcaption>この時代にもなって人間が時間を逆算…？ボタンを何度も…押す…！？</figcaption>
	</figure>
</div>


由々しき事態です．


## エアコンの入タイマーを自動化する

そこで，Google HomeとNature Remoを活用して所望の時間に自動でエアコンをONにする機能を作ります．

皆さん家電リモコンは持ってますか？外から予め暖房を付けておいたり，行方不明になりがちな部屋のリモコンに代わって電気を付けてくれたり，ベッドで寝落ちするときも部屋の電気を消すのがとっても簡単です．最高なのでぜひ買ってみてください．

話がそれました．今回作成する機能の大まかな利用ステップは次のとおりです．

1. Google Homeに○時にエアコンを付けるように指示を出す．
2. ○時に処理を走らせ，エアコンを付ける


さて，1 についてはGoogle Homeのアプリを作成するしかありません．アプリを作るときにはGoogleのDialogFlowというチャットボットを作れるサービスが利用できるので，これを使えばユーザーの音声から時間を取り出すのは難しくはないでしょう．

次に2です．Nature Remoを用意している時点でエアコンの操作も可能です．APIもあるので，アクセストークンさえ発行すればどこからでも指示を出すことができます．



問題は「どうやって○時に処理を実行するか」です．簡単なバックエンドのWeb APIを作成して時間を登録＆cronやatコマンドなんかを用いて指定時間に実行…というのをまず考えました．しかしタイマーのためだけに常駐サービスをデプロイするのはやや大げさな感があります．Herokuなどで実現できれば良いですが，そうでなければVPSやEC2を借りる必要がありコストもかかりそうです．

「なんとかならないものか…」と考えあぐねていたところ，なんと **AWSのStepFunctionsに指定日実行** の機能があるというではありませんか．

これなら**必要なときに必要な分だけ関数を走らせるサーバーレスアプリとして実装できます**．この程度のアプリなら使った分だけ課金といってもたかが知れているので，良さそうです．AWSさん神！！



ということでこんなデザインとなりました．



<div style="text-align: center;">
  <figure>
    <img src="/images/2019/aircon/arch.svg" alt="system design" width="100%">
	</figure>
</div>



## serverless frameworkで関数を作成

AWSの諸々のサービスの作成には [serverless framework](https://serverless.com/) を使用しました．言語はもちろんGoです．つくるのは大きく分けて3つ．

1. タイマーの時間を受け取るLambda Function（及び API Gateway）．
2. 1の中でキックするStep Functions．指定時間まで待ってからエアコン操作のFunctionを実行する．
3. エアコン操作を行うLambda Function．



まずyaml定義．1に相当する `createTimer` 関数と3に相当する`turnOnAircon`関数，最後に2のStepFunctionを定義します．

ポイントは`createTimer`関数からStepFunctionsを実行するときに必要なARNを環境変数にセットしてあげること．次に，StepFunctionsがいつまで処理を待つのか（StatesのWaitUntil）のタイムスタンプをStateに渡すイベント`start_date` として渡してあげることです．

```yml
service: google-home-aircon-timer

plugins:
  - serverless-step-functions

provider:
  name: aws
  runtime: go1.x

functions:
  createTimer:
    handler: bin/create-timer
    events:
      - http:
          path: api
          method: post
    environment:
      TurnOnAirconStepFuncARN: ${self:resources.Outputs.TurnOnAirconStepFunc.Value}
      
  turnOnAircon:
    handler: bin/turn-on-aircon

stepFunctions:
  stateMachines:
    StateMachine1:
      name: TurnOnAirconStepFunc
      definition:
        StartAt: WaitUntil
        States:
          WaitUntil:
            Type: Wait
            TimestampPath: $.start_date
            Next: Main
          Main:
            Type: Task
            Resource:
              Fn::GetAtt: [turnOnAircon, Arn]
            End: true
resources:
  Outputs:
    TurnOnAirconStepFunc:
      Value:
        Ref: TurnOnAirconStepFunc
```



1のハンドラは割愛しますが，これでGoogleHomeの方から指定時間をリクエストするとその時間まで待って関数が実行されるようになりました．



最後に3でエアコンを操作します．tenntennさんがGoのNature Remo APIのクライアントを公開してくださっているのでそれを利用します．

<div style="text-align: center;">
  <a href="https://github.com/tenntenn/natureremo">
  <figure>
    <img src="/images/2019/aircon/repo.png" alt="tenntenn/natureremo" width="70%">
	</figure>
  </a>
</div>

ハンドラはこんな感じ．NatureRemoを操作するアクセストークンが必要なので，発行した上でSystem ManagerのParameter Storeを使って登録・読み込みを行います．後はエアコンを付けるのみ！NatureRemoがあると外部からのアクセス（固定IPとか）に困らなくて最高ですね．

```go
package main

import (
	"context"
	"errors"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ssm"
	"github.com/tenntenn/natureremo"
)

func Handler() (string, error) {
	// new client for System Manager
	sess := session.Must(session.NewSession())
	ssmc := ssm.New(sess)
  
	// get acccess token for NatureRemo from Parameter Store
	keyname := "REMO_ACCESS_TOKEN"
	withDecryption := false
	param, err := ssmc.GetParameter(&ssm.GetParameterInput{
		Name:           aws.String(keyname),
		WithDecryption: aws.Bool(withDecryption),
	})
	if err != nil {
		return "", err
	}
	token := *param.Parameter.Value

	// new client for NatureRemo
	cli := natureremo.NewClient(token)
	ctx := context.Background()

	deviceName := "エアコン"
	operation := "on"

	// find aircon device
	as, err := cli.ApplianceService.GetAll(ctx)
	if err != nil {
		return "", err
	}

	var target *natureremo.Appliance
	for _, a := range as {
		if a.Nickname == deviceName {
			target = a
			break
		}
	}

	if target == nil {
		return "", errors.New(fmt.Sprintf("%s not found", deviceName))
	}

	// change turn-on/off
	settings := target.AirConSettings
	if operation == "on" {
		settings.Button = ""
	} else {
		settings.Button = "power-off"
	}

	err = cli.ApplianceService.UpdateAirConSettings(ctx, target, settings)
	if err != nil {
		return "", err
	}

	return "", nil
}

func main() {
	lambda.Start(Handler)
}
```

これでバックエンドのサーバーは終わりです．コードは下記に置きました．

<div style="text-align: center;">
  <a href="https://github.com/tenntenn/natureremo">
  <figure>
    <img src="/images/2019/aircon/repo2.png" alt="tenntenn/natureremo" width="70%">
	</figure>
  </a>
</div>

残るはインターフェースです．

## DialogFlowでGoogle Homeアプリを作成

最後にここが地味に面倒くさかったのですが，Google Homeアプリを作ります．[はじめてのGoogle Homeアプリ開発（WebAPI連携/2018年春編）](https://www.moyashi-koubou.com/blog/make_google_home_app_2018/)を参考にさせていただきました．

細かいことを書いてもあれなのでざっくりとですが，

1. Actions on Googleのプロジェクトを作成
2. DialogFlowで動作を作成
   1. Intentと呼ばれる入力を定義する部分で，この機能を呼び出す文言と，時刻の聞き取りを定義
   2. FulfillmentでWebhookを定義し，聞き取った時刻を先のAWSのエンドポイントにPOSTで送信
   3. Google AsistantとのIntegrationを設定
3. Simulatorでテスト

という手順を踏みました．記事ではアプリを審査に出して公開までしていますが，Google Homeに設定しているGoogleアカウントでアプリを開発すれば，公開しなくても手元のデバイスで動かす事ができました！



Simulatorで確認してみます．時間を教えると自動的に直近の日時を解釈してAPIをコールしてくれることがわかります！

<div style="text-align: center;">
  <video src="/images/2019/aircon/actions-simulator.mov" controls width="100%">
		<p>動画を再生するにはvideoタグをサポートしたブラウザが必要です。</p>
	</video>
</div>



## おわりに

そしてできたものが，冒頭の動画になります．これで朝活が捗りますね．

紹介したアーキテクチャはGoogle Home以外のスマートスピーカーでも応用できる部分だと思いますので，参考になれば幸いです．値段としても月に数十回のリクエストなのでほとんど無視できる額になると思います．

今後は必要に応じて

- タイマーのキャンセル
- 切タイマーの予約
- 時間指定ではなく，○分後での予約

ができるようになると便利かなと考えています！

## 宣伝

12/14・15で行われたYahoo!Japan主催のハッカソンであるHackDay2019に私と [@gutio_jp](https://twitter.com/gutio_jp) で出場し，[優勝しました](https://youtu.be/HNjXZwRTybU?t=7517)．その経験も踏まえ，相方が[ハッカソンで優勝する技術](https://qiita.com/taigamikami/items/7c6af445f1e62b0dad23)という記事を書いたので，ぜひ読んでいいねしてあげてください!

## 参考


- [Serverless Frameworkで構築するStep Functions](https://dev.classmethod.jp/etc/serverless-framework-step-functions/)
- [StepFunctionsでLambdaの指定日時実行をしてみる](https://dev.classmethod.jp/cloud/aws/lambda-dynamic-scheduled-execution-by-stepfunctions/)
- [Wait state in AWS Step Functions using the serverless framework](https://vgaltes.com/post/step-functions-wait-state/)
- [Dialogflowを使った音声対話形式のアプリを作ってみる vol.1](https://4009.jp/post/2018-06-29-dialogflow/)
- [Google Home向けアプリ開発チュートリアル(1)ープロジェクトの作成]([https://medium.com/@mikachika/google-home%E5%90%91%E3%81%91%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB-1-%E3%83%BC%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%AE%E4%BD%9C%E6%88%90-f577d706d8b6](https://medium.com/@mikachika/google-home向けアプリ開発チュートリアル-1-ープロジェクトの作成-f577d706d8b6))

