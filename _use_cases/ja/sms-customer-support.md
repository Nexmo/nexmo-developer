---
title:  SMSカスタマーサポート

products: messaging/sms

description:  プログラム可能なSMSは、一方向通知だけに便利なわけではありません。アウトバウンド通知とインバウンドメッセージを組み合わせると、企業と顧客の間にチャットのようなやり取りが生まれます。

languages:
  - Ruby


---

SMSカスタマーサポート
============

SMSの一般的な利用可能性は、顧客サポートのための汎用性の高いソリューションとなっています。電話番号は印刷したり、読み上げたり、Webサイトに掲載したりすることができ、オンラインでもオフラインでも誰もがあなたのビジネスに関わることができます。

SMSを使用したカスタマーサポートを提供することにより、モバイルネットワークに接続された電話を持つすべての人が完全な双方向通信システムを入手できます。

このチュートリアルの内容
------------

VonageのAPIやライブラリを使用して、SMSカスタマーサポートのための簡単なシステムを構築します。

これを行うには、以下の手順に従います。

* [基本的なWebアプリを作成する](#a-basic-web-application) - サポートチケットを開くためのリンクを持つ基本的なWebアプリケーションを作成します。
* [電話番号を購入する](#purchase-a-phone-number) - Vonageの電話番号を購入してSMSを送信し、インバウンドSMSを受信します
* [インバウンドSMSを処理する](#process-an-inbound-sms) - 顧客から受信したインバウンドSMSを受け入れて処理します
* [チケット番号を記載したSMS返信を送信する](#send-an-sms-reply-with-a-ticket-number) - チケットが開かれたときに新しいチケット番号を返信します

準備
---

このチュートリアルを動作させるためには、以下のものが必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* VonageがアプリにWebhookリクエストを実行できるように、一般にアクセス可能なWebサーバー。ローカルで開発している場合は、[ngrok](https://ngrok.com/)のようなツールを使用する必要があります
* このチュートリアルのソースコードは[https://github.com/Nexmo/ruby-sms-customer-support/](https://github.com/Nexmo/ruby-sms-customer-support/)にあります

基本的なWebアプリケーション
---------------

このチュートリアルでは、1ページのシンプルなWebアプリケーションから始めます。ユーザーはリンクをクリックして自分のSMSアプリを開き、サポートを依頼できるようになります。アプリはインバウンドSMSを収集し、新しいチケットを開きます。最後に、アプリはユーザーにチケット番号を確認するための新しいSMSを返信します。

```sequence_diagram
Participant Phone
Participant Vonage
Participant App
Phone->>Vonage: SMS 1
Vonage-->>App: Webhook
App->>Vonage: SMS Request
Vonage->>Phone: SMS 2
```

**基本アプリの作成から始めます。** 

```sh
rails new customer-support
cd customer-support
rake db:create db:migrate
```

このページは、アプリケーションのルートにあり、あらかじめ入力されたテキストとともにSMSアプリへのリンクを提供します。

**最初のページを追加する** 

```sh
rails g controller pages index
```

**app/views/pages/index.html.erb** 

```erb
<h1>ACME Support</h1>

<p>
  <a href="sms://<%= ENV['VONAGE_NUMBER'] %>?body=Hi ACME, I'd like some help with: " class='button'>
    Get support via SMS
  </a>
</p>
```

これでサーバーを起動できます。

**サーバーを起動する** 

```sh
rails server
```

電話番号を購入する
---------

アプリがSMSを受信する前に、Vonage電話番号をレンタルする必要があります。電話番号は[Dashboard](https://dashboard.nexmo.com)から、または[Nexmo CLI](https://github.com/nexmo/nexmo-cli)でコマンドラインから直接購入できます。

```sh
> nexmo number:buy --country_code US --confirm
Number purchased: 447700900000
```

最後に、着信SMSを受信したときにHTTPリクエストを行うには、VonageにWebhookエンドポイントを通知する必要があります。これは、[ダッシュボード](https://dashboard.nexmo.com/your-numbers)または[Nexmo CLI](https://github.com/nexmo/nexmo-cli)で実行できます。

```sh
> nexmo link:sms 447700900000 http://[your.domain.com]/support
Number updated
```

> *注* ：Webhook用の新しいコールバックURLを設定する前に、サーバーが稼働していて公開されていることを確認してください。新しいWebhookを設定しているときに、Vonageはサーバーに呼び出しを行い、サーバーが利用可能であることを確認します。

⚓ SMSを処理する

着信SMSを処理する
----------

顧客がSMSを送信すると、Vonageがモバイルキャリアのネットワークを介して受信します。Vonageはその後、アプリケーションへのWebhookを作成します。

このWebhookには、送信されたオリジナルのテキスト、メッセージを送信した電話番号、さらにいくつかのパラメーターが含まれます。詳細については、[着信メッセージ](/api/sms#inbound-sms)のドキュメントを参照してください。

アプリは、着信したWebhookを処理し、テキストと番号を抽出し、新しいチケットを開くか、既存のチケットを更新する必要があります。これが顧客の最初のリクエストである場合、アプリはチケット番号を記載した確認メッセージを顧客に返送する必要があります。

これは、着信メッセージを保存し、その番号にまだ開いているチケットがない場合に新しいチケットを開くことで実現されます。

**チケットとメッセージモデルを追加する** 

```sh
rails g controller support index
rails g model Ticket number
rails g model Message text ticket:references
rake db:migrate
```

**app/controllers/support\_controller.rb** 

```ruby
class SupportController < ApplicationController
  def index
    save_message
    send_response
    render nothing: true
  end

  private

  def ticket
    @ticket ||= Ticket.where(
      number: params[:msisdn]
    ).first_or_create
  end

  def save_message
    message = Message.create(
      text: params[:text],
      ticket: ticket
    )
  end
```

チケット番号付きのSMS返信を送信する
-------------------

確認を顧客のSMSに送信するには、プロジェクトにVonageサーバーSDKを追加します。

**Gemfile** 

```ruby
gem 'nexmo'
gem 'dotenv-rails'
```

> *注* ：サーバーSDKを初期化するには、[APIキーとシークレット](https://dashboard.nexmo.com/settings)を渡す必要があります。API認証情報をコードに保存せず、代わりに環境変数を使用することを強くお勧めします。

ライブラリが初期化されたことで、アプリケーションは[SMSを送信](/api/sms#send-an-sms)できるようになりました。このチケットの最初のメッセージである場合のみ、返信を送信します。

```ruby
def send_response
  return if ticket.messages.count > 1

  client = Nexmo::Client.new
  result = client.sms.send(
    from: ENV['VONAGE_NUMBER'],
    to: ticket.number,
    text: "Dear customer, your support" \
          "request has been registered. " \
          "Your ticket number is #{ticket.id}. " \
          "We intend to get back to any " \
          "support requests within 24h."
  )
end
```

まとめ
---

このチュートリアルでは、顧客の電話からSMSを受信し、SMS返信を送信する方法を学びました。これらのコードスニペットを使用すると、Vonage SMS APIを使用したSMSカスタマーサポートソリューションが得られます。

コードを入手する
--------

このチュートリアルのコードやその他のコードはすべて[GitHubで公開](https://github.com/Nexmo/ruby-sms-customer-support/)されています。

関連情報
----

* [SMS](/sms)
* [SMS APIリファレンスガイド](/api/sms)

