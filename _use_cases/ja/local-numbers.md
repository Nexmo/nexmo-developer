---
title:  ローカル番号

products: voice/voice-api

description:  「フリーダイヤル番号（800、0800など）を、より良い顧客サービスを提供するために地域の電話番号に置き換えてください。ユーザーは、より安い料金で電話をかけることができ、連絡時に位置情報に応じた情報を提供できます」

languages:
  - Ruby


---

音声通話用ローカル番号
===========

フリーダイヤル番号はコストがかかる可能性がありますが、お客様に最も個人的にならない連絡方法を提供する方法の1つです。そのことに留意しつつ、高額なフリーダイヤル番号を複数のローカル番号に置き換えます。これにより、お客様が電話をかけやすいローカル番号を提供しながら、高額なフリーダイヤル番号のレンタル費用を抑えることができます。

さらに、ローカル番号の利点を利用して電話をかけてきたお客様に応じた情報を提供すると同時に、変化し続けるお客様の要望に関する貴重な情報を収集するための、賢い手順について説明します。

このチュートリアルでは、架空の交通機関向けのアプリケーションを作成します。ユーザーはローカル番号にダイヤルして、市内交通システムに関する最新情報を即座に入手し、さらに必要に応じて他都市の最新情報も入手することができます。

準備
---

このチュートリアルを進めるためには、以下のものが必要になります。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli)がインストールされ、セットアップされている
* VonageがアプリにWebhookリクエストを送信できるように、一般にアクセス可能なWebサーバー。Webhookについては、[Webhookガイド](/concepts/guides/webhooks)で詳しく説明しています。このガイドでは、[ngrokを使用してローカルWebサーバーを公開する](/tools/ngrok)方法についても説明しています。
* Rubyおよび[Sinatra](http://www.sinatrarb.com/) Webフレームワークに関するある程度の知識

⚓ 音声アプリケーションを作成する
⚓ 電話番号を購入する
⚓ 電話番号をVonageアプリケーションにリンクする

最初のステップ
-------

まず、このアプリケーションで使用する2つのVonage番号を登録します。異なる地域にリンクした異なる番号の使用を説明するため、2つ必要です。[アプリケーションの使用を開始する](https://developer.nexmo.com/concepts/guides/applications#getting-started-with-applications)手順に従ってください。ここでは番号の購入、アプリケーションの作成、2つのリンク（購入とリンクを、番号ごとに1回、計2回行います）について説明します。

アプリケーションの構成時に、一般にアクセス可能なWebサーバーの`answer_url`またはngrokエンドポイントを提供する必要があります。これは、このプロジェクトの`[YOUR_URL]/answer`となります。ngrok URLが`https://25b8c071.ngrok.io`の場合、`answer_url`は次のようになります。 `https://25b8c071.ngrok.io/answer`

アプリケーションを作成したら、認証に使用するキーを取得します。これを、`app.key`ファイルに保存して安全な場所に保管しておきます。これは、電話をかけるために後で必要になります。

アプリケーションを作成し、構成して電話番号をリンクしたら、コードを確認してください。その後、そのコードを実行してみます。

⚓ Webサーバーを作成する

アプリケーションコードを設定して実行する
--------------------

このアプリケーション用のコードを[https://github.com/Nexmo/800-replacement](https://github.com/Nexmo/800-replacement)から複製またはダウンロードします。

コードを入手したら、次の操作を行います。

* `bundle install`を実行して依存関係を取得します
* `.env.example`を`.env`にコピーします。この新しいファイルを、購入してアプリケーションにリンクした2つの番号を含めて独自の構成設定になるよう編集します
* アプリを起動する `ruby app.rb`

着信した通話を受ける
----------

Vonageアプリケーションにリンクされている番号の1つに誰かが電話をかけると、Vonageは着信コールを受信します。その後、Vonageはその呼び出しをあなたのWebアプリケーションに通知します。これは、Webアプリの`answer_url`エンドポイントへのWebhookリクエストを行うことで実行されます。詳しくは、開発者用ドキュメントの[応答Webhook](/voice/voice-api/webhook-reference#answer-webhook)を参照してください。

ユーザーは、市内番号にかけているため、どの番号がどの都市に割り当てられているかを知る必要があります。この簡単なケースでは、購入した2つの番号をアプリケーションに構成しただけですが、本番環境では、この関係性はデータベースに保存されます。構成は`app.rb`に記載されています。

```ruby
# Map our inbound numbers to different cities.
# In a production system this would most likely
# be queried from your database.
locations = {
  ENV['INBOUND_NUMBER_1'] => 'Chicago',
  ENV['INBOUND_NUMBER_2'] => 'San Francisco',
}

# The current statuses for the transport in the
# different cities.
statuses = {
  'Chicago'       => 'There are minor delays on the L Line. There are no further delays.',
  'San Francisco' => 'There are currently no delays',
  # An extra city that does not have its own local
  # number yet
  'Austin'        => 'There are currently no delays'
}
```

これで、着信コールを取り、ダイヤルされた番号を抽出し、ユーザーに、その都市の現在の交通状況を返信することができます。状況は、テキスト読み上げによる音声メッセージでユーザーに通知されます。

> せっかちな人は、この時点でVonageの番号に電話して、アプリケーションの動作している様子を確認するかもしれないですね。

以前に設定した`answer_url`は、電話をかけた時に使用されるルートです。このコードは`app.rb`に記載されています。

```ruby
get '/answer' do
  # We map the number dialled to a location
  location = locations[params['to']]
  # We map the location to the current status
  status = statuses[location]
  # respond to the user
  respond_with(location, status)
end
```

このコードは通話に応答し、着信した電話番号をチェックして、その地域の電話番号に関連するステータスを取得します。次に、[Nexmo Call Control Object（NCCO）](/voice/guides/ncco)を構築するための`respond_with()`関数を呼び出します。これらのオブジェクトは、Vonageに、通話者にどのテキスト読み上げメッセージを再生すべきかや、番号入力を受け付けるなどのその他の実行すべきアクションを指示します。

```ruby
# This method is shared between both endpoints to play
# back the status and then ask for more input
def respond_with(location, status)
  content_type :json
  return [
    # A friendly localized welcome message
    {
      'action': 'talk',
      'text': "Current status for the #{location} Transport Authority:"
    },
    # The current transport status for this city
    {
      'action': 'talk',
      'text': status
    },
    # Next, we give the user the option to get the details for other cities as well
    {
      'action': 'talk',
      'text': 'For more info, press 1 for Chicago, 2 for San Francisco, and 3 for Austin. Or hang up to end your call.',
      'bargeIn': true
    },
    # Listen to a user's input play back that city's status
    {
      'action': 'input',
      'eventUrl': ["#{ENV['DOMAIN']}/city"],
      # we give the user a bit more time before we hang up on them
      'timeOut': 10,
      # we only expect one digit
      'maxDigits': 1
    }
  ].to_json
end
```

> *注* ：利用できるその他のアクションについては、[NCCOの関連情報](/voice/guides/ncco-reference)を参照してください。

Vonageの電話番号に電話し、アプリケーションが（架空の）交通状況を通知するかをチェックします。交通状況は片方の番号がシカゴのもの、もう片方がサンフランシスコのもので、`input` NCCOアクションを使用することでその後に複数のオプションを提供します。

その他の場所のプロンプト
------------

任意の通話者に任意の都市の情報を提供することができますが、目的の場所に関連付けられた番号に電話しなかった場合は、上記のように、通話者に入力してもらう必要があります。その入力動作を詳しく見ていきましょう。

    {
        'action': 'input',
        'eventUrl': ["#{ENV['DOMAIN']}/city"],
        # we give the user a bit more time before we hang up on them
        'timeOut': 10,
        # we only expect one digit
        'maxDigits': 1
    }

入力によって、コールがリスニングモードになります。この入力ブロックの構成では入力が必要なのは1桁のみですが、複数桁を受け付ける場合は、`#`記号を入力することで終了するといった構成にもできます。このコードでは、`eventUrl`も設定します。これは、入力データを格納したWebhookの送信先です。ここでは、データを受信するアプリケーションの`/city`エンドポイントです。

```ruby
# This endpoint is called when the user has typed
# a number on their phone to choose a city
post '/city' do
  # We parse the JSON in the request body
  body = JSON.parse(request.body.read)
  # We extract the user's selection, and turn it into a number
  selection = body['dtmf'].to_i
  # We then select the city name and its status from the list
  location = statuses.keys[selection-1]
  status = statuses[location]
  # Finally, we respond to the user in the same way we have done before
  respond_with(location, status)
end
```

> *ヒント* ：電話メニューで行われた選択は、アプリケーションでのユーザーの行動と需要に関する貴重なデータを測定するために追跡できます

押されたボタンは、その`/city` URLへの着信Webhookの`dtmf`フィールドに送信されます。Webhookペイロードについての詳細は、[Webhookのドキュメント](/voice/voice-api/webhook-reference#input)を参照してください。

ユーザーがデータを要求した都市が判明したら、前回と同じ構成から都市とそのステータスを検索し、`respond_with()`関数を再利用してNCCOに返すことができます。

まとめ
---

ここでは、音声アプリケーションを作成し、電話番号を購入してVonage音声アプリケーションにリンクしました。次に、着信コールを受信し、呼び出された番号を標準入力にマッピングし、ユーザーからさらに多くの入力を収集して詳しい情報を再生するアプリケーションを構築しました。

⚓ 関連情報

次の作業
----

* [GitHubのコード](https://github.com/Nexmo/800-replacement) - このアプリケーションのすべてのコード
* [着信コールにCall Whisperを追加する](https://developer.nexmo.com/tutorials/add-a-call-whisper-to-an-inbound-call) - 通話をつなぐ前に、発信者についての詳細を通知する方法
* [着信コールのトラッキング](https://www.nexmo.com/blog/2017/08/03/inbound-voice-call-campaign-tracking-dr/) - どの着信マーケティングキャンペーンが最適に機能しているかの追跡に関するブログ投稿
* [音声APIの関連情報](/api/voice) - 音声APIの詳細なAPIドキュメント
* [NCCOの関連情報](/voice/guides/ncco-reference) - Webhookに関する詳細なドキュメント

