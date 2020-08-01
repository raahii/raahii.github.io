+++
Categories = ["技術"]
Description = " 今回RubyでGoogle Analytics APIを利用する機会があったのですが、思ったより情報が少ない上、必要な鍵ファイルやトークンがよくわからず時間を取られたので以下に手順をまとめておきます。  Developers Consol"
Tags = ["web", "ruby", "rails"]
date = "2017-05-04T01:03:00+09:00"
title = "Ruby(Rails)でGoogle Analytics APIを使う"
author = "bonhito"
archive = ["2017"]
draft = true
aliases = ["/2017/05/04/ruby-google-analytics-api", "/2017/05/ruby-google-analytics-api"]
+++

{{< rawhtml >}}
<body>
<p>今回<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>で<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google%20Analytics">Google Analytics</a> <a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>を利用する機会があったのですが、思ったより情報が少ない上、必要な鍵ファイルや<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C8%A1%BC%A5%AF">トーク</a>ンがよくわからず時間を取られたので以下に手順をまとめておきます。</p>

<h2>Developers Consoleでプロジェクト作成・<a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>を有効化</h2>

<p>まずはおなじみのやつですが、<a href="https://console.developers.google.com/start/api?id=analytics&amp;credential=client_key&amp;hl=ja">Googleのセットアップツール</a>を利用するとパパッと完了できます。画面の表示に従って<code>プロジェクト作成</code>→<code>認証情報に進む</code>→<code>OAuthクライアント作成</code>→<code>完了</code>と進めます。</p>

<p>注意してほしいのが認証情報のところで、自分は以下のようにしました。最後の認証情報のダウンロードは不要です。</p>

<p><span itemscope itemtype="http://schema.org/Photograph"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/b/bonhito/20170503/20170503222647.png" alt="f:id:bonhito:20170503222647p:plain" title="f:id:bonhito:20170503222647p:plain" class="hatena-fotolife" itemprop="image"></span></p>

<h2>サービスアカウントの作成</h2>

<p>次に<a href="https://console.developers.google.com/permissions/serviceaccounts?hl=ja">サービスアカウントページ</a>を開いて、<code>プロジェクトを選択</code>→<code>サービス アカウントを作成</code>→<code>（サービス アカウントの名前を入力）</code>→<code>新しい秘密鍵の提供</code>→<code>作成</code>を順にクリックします。公開キーと秘密キーのペアが生成されるので、<code>client_secrets.p12</code>というファイル名で保存します。</p>

<p>また、サービスアカウントのIDを次で使うのでコピーしておいて下さい。</p>

<h2>
<a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a>アナリティクスのユーザーにサービスアカウントを追加する</h2>

<p>準備作業の最後として、アナリティクスデータの表示と分析の権限をサービスアカウントに付与します。自分の<a href="https://www.google.com/intl/ja_jp/analytics/">Googleアナリティクスのページ</a>を開き、<code>左タブの管理＞ビューの列のユーザー管理</code>に進み、権限を付与するユーザーとして先ほどのサービスアカウントのIDを入力して追加します。</p>

<p>また<code>管理＞ビュー設定</code>にあるビューIDをこの後使うのでコピーしておいて下さい。</p>

<h2>必要なパッケージをインス<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C8%A1%BC%A5%EB">トール</a>
</h2>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Rails">Rails</a>であればGemfileに追記します。</p>

<pre class="code lang-ruby" data-lang="ruby" data-unlink> gem 'google-api-client', '~&gt; 0.11'
 </pre>




<pre class="code" data-lang="" data-unlink> bundle install </pre>


<p>単にターミナルから使うのであれば以下。</p>

<pre class="code" data-lang="" data-unlink> gem install google-api-client </pre>


<h2>キーと設定ファイルを配置</h2>

<p>そうしたら、<code>ga_config.yml</code>という名前で<a class="keyword" href="http://d.hatena.ne.jp/keyword/yaml">yaml</a>ファイルを作成し、中身を記述します。以下を自分の情報と置き換えて下さい。</p>

<script src="https://gist.github.com/piyo56/a978fed3af57b0ae0240307b82de3113.js"></script>


<ul>
<li>
<p><code>サービスアカウントのID</code>:</p>

<p>  <a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a> Developers Consoleの<code>左上のハンバーガーメニュー＞IAMと管理＞サービスアカウント</code>で確認できます。</p>
</li>
<li>
<p><code>アナリティクスのビューID</code>:</p>

<p>  自分のアナリティクスのアカウントより、<code>左タブ＞管理（歯車アイコン）＞ビュー設定</code>より確認できます。</p>
</li>
<li>
<p><code>サービスアカウントのキー</code>:</p>

<p>  サービスアカウント作成の時に得た<code>client_secrets.p12</code>を適当に配置してパスを記述します。</p>
</li>
<li>
<p><code>サービスアカウントのキーのパスワード</code>:</p>

<p>  特別設定していなければ'notasecret'のままでOKです。</p>
</li>
</ul>


<h2>データを取得</h2>

<p>以下がメインの<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>です。そのまま使う場合はとりあえず<code>ga_config.yml</code>や<code>client_secrets.p12</code>と同<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8">ディレクト</a>リに置くと動くと思います。</p>

<script src="https://gist.github.com/piyo56/6486668384cc92a679e7cd99552f8c08.js"></script>


<p><code>start_date</code>や<code>end_date</code>、<code>metrics</code>、<code>dimension</code>、<code>sort</code>などは必要に応じて変更して下さい。データの取得方法は共通だと思うので下記など他の情報を参照して下さい。</p>

<p><iframe src="//hatenablog-parts.com/embed?url=https%3A%2F%2Fgithub.com%2Fgoogle%2Fgoogle-api-ruby-client-samples%2Fblob%2Fmaster%2Fservice_account%2Fga_attributes.yml" title="google/google-api-ruby-client-samples" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="https://github.com/google/google-api-ruby-client-samples/blob/master/service_account/ga_attributes.yml">github.com</a></cite></p>

<h1>
<a class="keyword" href="http://d.hatena.ne.jp/keyword/Rails">Rails</a>アプリで使う場合</h1>

<p>今回紹介したのはただの<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>ですが、例えばランキングを作りたいといった場合にはアクセス数を利用してモデルに順位を付与したいと思います。そこで使えるのが、<a class="keyword" href="http://d.hatena.ne.jp/keyword/Rails">Rails</a>の環境を読み込んだ上で任意の<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>コードが実行できる<code>rails runner</code>です。またそういった独自の<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8">スクリプト</a>みたいなものは<code>lib/tasks</code>に配置してrakeタスクとして使うほうが正しそう(?)です。また<a class="keyword" href="http://d.hatena.ne.jp/keyword/github">github</a>で公開する場合などはキーファイルなどを<a class="keyword" href="http://d.hatena.ne.jp/keyword/%A5%EA%A5%DD%A5%B8%A5%C8%A5%EA">リポジトリ</a>に含めないように注意して下さい。</p>

<h1>おわりに</h1>

<p><a class="keyword" href="http://d.hatena.ne.jp/keyword/Google">Google</a>の<a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>は以前<a class="keyword" href="http://d.hatena.ne.jp/keyword/Python">Python</a>で利用したこともあるのですが、その時はもっとサンプルコードが転がっていて楽だったのですが…。どうやら<a class="keyword" href="http://d.hatena.ne.jp/keyword/Ruby">Ruby</a>で<a class="keyword" href="http://d.hatena.ne.jp/keyword/API">API</a>を叩く公式のライブラリがアルファのままということもあり、情報が少ないのかもしれないです。こういうのはただ面倒くさいだけなので再利用できる情報を提供できていれば幸いです。ここ動かないみたいなのあったらコメントお願いします。</p>

<p><iframe src="//hatenablog-parts.com/embed?url=https%3A%2F%2Fgithub.com%2Fgoogle%2Fgoogle-api-ruby-client" title="google/google-api-ruby-client" class="embed-card embed-webcard" scrolling="no" frameborder="0" style="display: block; width: 100%; height: 155px; max-width: 500px; margin: 10px 0px;"></iframe><cite class="hatena-citation"><a href="https://github.com/google/google-api-ruby-client">github.com</a></cite></p>

<h1>参考</h1>

<ul>
<li><p><a href="https://developers.google.com/analytics/devguides/reporting/core/v3/quickstart/service-py?hl=ja">はじめてのアナリティクス API: サービス アカウント向け Python クイックスタート</a></p></li>
<li><p><a href="https://github.com/google/google-api-ruby-client-samples/blob/master/service_account/analytics.rb">google/google-api-ruby-client-samples</a></p></li>
<li><p><a href="https://rcmdnk.com/blog/2016/01/17/blog-octopress-javascript-analytics/">google-api-ruby-clientが非互換なアップデートされた</a></p></li>
</ul>

</body>
{{< /rawhtml >}}
