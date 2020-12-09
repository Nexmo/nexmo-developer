---
title:  顧客エンゲージメント用双方向 SMS

products: messaging/sms

description:  プログラム可能なSMSは、一方向通知だけに便利なわけではありません。アウトバウンド通知とインバウンドメッセージを組み合わせると、企業と顧客の間にチャットのようなやりとりが生まれます。

languages:
  - Ruby


---

顧客エンゲージメント用双方向 SMS
==================

プログラム可能なSMSは、一方向通知だけに便利なわけではありません。アウトバウンド通知とインバウンドメッセージを組み合わせると、企業と顧客の間にチャットのようなやりとりが生まれます。

このチュートリアルの内容
------------

顧客の電話番号に配送通知を送信し、顧客が配送時間を変更したい場合は返信を処理するなど、双方向通信をアプリに組み込むのがいかに簡単かがわかります。

アプリのワークフローは次のとおりです。

```sequence_diagram
Participant App
Participant Vonage
Participant Phone number
App->>Vonage: Request to SMS API
Vonage-->>App: Response from SMS API
Note over Vonage: Request accepted
Vonage->>Phone number: Send delivery notification SMS
Phone number->>Vonage: Reply to delivery notification
Vonage-->>App: Send reply to webhook endpoint
App->>Vonage: Request to SMS API
Vonage-->>App: Response from SMS API
Note over Vonage: Request accepted
Vonage->>Phone number: Send acknowledgement in SMS
```

これを行うには、以下の手順に従います。

1. [Vonage仮想番号を設定する](#configure-a-nexmo-virtual-number) - 仮想番号をレンタルして、受信メッセージのWebhookエンドポイントを設定します
2. [基本的なWebアプリを作成する](#create-a-basic-web-app) - 顧客の電話番号を収集するWebアプリを作成します。
3. [SMS通知を送信する](#send-an-sms-notification) - 顧客にSMSで配信通知を送信し、返信を要求します。
4. [返信SMSを処理する](#process-the-reply-sms) - SMSの返信を処理し、確認します。

準備
---

このチュートリアルを進めるためには、次のものが必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* VonageがアプリにWebhookリクエストを実行できるように、一般にアクセス可能なWebサーバー。ローカルで開発している場合は、[ngrok](https://ngrok.com/)のようなツールを使用する必要があります
* このチュートリアルのソースコードは、[https://github.com/Nexmo/ruby-customer-engagement/](https://github.com/Nexmo/ruby-customer-engagement/)にあります。

Vonage仮想番号を設定する
---------------

Vonageは、Vonage仮想番号に関連付けられたWebhookエンドポイントに着信メッセージを転送します。

[開発者用API](/api/developer/numbers)または[Nexmo CLI](https://github.com/nexmo/nexmo-cli)を使用して仮想番号を管理します。以下の例では、[Nexmo CLI](https://github.com/nexmo/nexmo-cli)を使用してVonage番号をレンタルしています。

```sh
$ nexmo number:buy --country_code US --confirm
Number purchased: 441632960960
```

次に、仮想番号をWebhookエンドポイントに関連付けます（リンク： \#process-inbound-sms テキスト：着信SMSを処理する）。

```sh
> nexmo link:sms 441632960960 http://www.example.com/update
Number updated
```

> **注** ：Webhookエンドポイントを仮想番号に関連付ける前に、サーバーが稼働していて公開されていることを確認してください。設定を正常に行うには、VonageがWebhookエンドポイントから200 OKレスポンスコードを受け取る必要があります。ローカルで開発を行っている場合は、[ngrok](https://ngrok.com/)のようなツールを使用してローカルのWebサーバーをインターネットに公開してください。

これで仮想番号の設定が完了したので、SMS配信通知を送信できます。

基本的なWebアプリを作成する
---------------

[Sinatra](http://www.sinatrarb.com/)を使用して単一ページのWebアプリを作成します。

**Gemfile** 

```ruby
source 'https://rubygems.org'

# our web server
gem 'sinatra'
```

**app.rb** 

```ruby
# web server and flash messages
require 'sinatra'

# load environment variables
# from .env file
require 'dotenv'
Dotenv.load

# Index
# - collects a phone number
#
get '/' do
  erb :index
end
```

以下に対して通知SMSを送信する電話番号を収集するためのHTMLフォームを追加します。

**views/index.erb** 

```erb
<form action="/notify" method="post">
  <div class="field">
    <label for="number">
      Phone number
    </label>
    <input type="text" name="number">
  </div>

  <div class="actions">
    <input type="submit" value="Notify">
  </div>
</form>
```

フォームは、SMS用APIで期待される[E.164](https://en.wikipedia.org/wiki/E.164)形式で電話番号をキャプチャします。

SMS通知を送信する
----------

このチュートリアルでは、SMSを送信するために、[Ruby用VonageサーバーSDK](https://github.com/Nexmo/nexmo-ruby)をアプリに追加します。

**Gemfile** 

```ruby
# the nexmo library
gem 'nexmo'
# a way to load environment
# variables
gem 'dotenv'
```

Vonage APIの[キーとシークレット](/concepts/guides/authentication)を使用してクライアントを初期化します。

**app.rb** 

```ruby
# nexmo library
require 'nexmo'
nexmo = Nexmo::Client.new(
  api_key: ENV['VONAGE_API_KEY'],
  api_secret: ENV['VONAGE_API_SECRET']
)
```

> **注** ：API認証情報をコードに保存せず、環境変数を使用してください。

通知SMSへの返信を受信するために、[SMS API](/api/sms)へのリクエスト時に、送信メッセージの送信者IDとして仮想番号を設定します。

**app.rb** 

```ruby
# Notify
# - Send the user their delivery
#   notification, asking them
#   to respond back if they
#   want to make any changes
#
post '/notify' do
  notification = "Your delivery is scheduled for tomorrow between " +
                 "8am and 2pm. If you wish to change the delivery date please " +
                 "reply by typing 1 (tomorrow), 2 (Thursday) or 3 (deliver to"
                 "post office) below.\n\n";

  nexmo.sms.send(
    from: ENV['VONAGE_NUMBER'],
    to: params['number'],
    text: notification
  )

  "Notification sent to #{params['number']}"
end
```

このSMSが顧客によって受信されたことを検証するには、[受信確認](/messaging/sms/guides/delivery-receipts)を確認します。このチュートリアルでは、受信確認の検証は行いません。

返信SMSを処理する
----------

顧客が通知SMSに返信すると、Vonageは[着信メッセージ](/api/sms#inbound-sms)を仮想番号に関連付けられたWebhookエンドポイントに転送します。

このチュートリアルアプリでは、受信したWebhookを処理し、テキストと番号を抽出し、顧客に確認メッセージを送信します。

**app.rb** 

```ruby
# Receive incoming message
#
# - Receives incoming SMS
#   message, stores it, and
#   notifies sender
#
get '/update' do
  choice = params['text']
  number = params['msisdn']

  # You can store or validate
  # the choice made here

  message = "Thank you for picking option #{choice}. " +
            "Your delivery is now fully scheduled in."

  nexmo.sms.send(
    from: ENV['VONAGE_NUMBER'],
    to: number,
    text: message
  )

  body ''
end
```

顧客の入力の保存と検証は、このチュートリアルの対象外です。

では、先ほど受信したSMSに返信しましょう。アプリによって処理され、数秒以内に選択した確認メッセージが表示されるはずです。

まとめ
---

アプリ内でSMSを送受信するのはこれほどシンプルな作業です。数行のコードで、SMS APIを使用して顧客の電話にSMSを送信し、返信を処理し、確認メッセージを返信しました。

コードを入手する
--------

このチュートリアルに必要なコードはすべて、[顧客エンゲージメント用双方向SMSのGitHubリポジトリ](https://github.com/Nexmo/ruby-customer-engagement)にあります。

関連情報
----

* [RubyサーバーSDK](https://github.com/Nexmo/nexmo-ruby)
* [SMS](/sms)
* [SMS APIリファレンスガイド](/api/sms)

