---
title:  モバイルアプリへの招待

products: messaging/sms

description:  お客様とアプリをSMSでリンクする

languages:
  - Ruby


---

モバイルアプリへの招待
===========

AndroidやiOS向けのアプリの数が増加する中、ストアでもWebでも自社のアプリが簡単に見つかるということが重要です。

モバイルアプリにWebサイトがある場合、次のようなボタンはよく利用しているかもしれません。

![モバイルアプリのボタンの例](/images/app_store_play_badges.png)

これらのボタンで、誰もが、自分のモバイルデバイスに適したストアに簡単に移動できます。しかし、ユーザーがモバイルでない場合、このフローはすぐに崩れてしまいます。たとえばユーザーがデスクトップコンピュータを使用しているとしたら、どうでしょうか。 **モバイルアプリのプロモーション** を使用することで、閲覧中のユーザーにSMS経由でアプリへのリンクを送信し、アクティブな顧客に変えることができます。

このチュートリアルの内容
------------

Vonage APIおよびライブラリを使用して、モバイルアプリの招待システムを簡単に構築する方法について説明します。

1. [Webアプリを作成する](#create-a-web-app) - ダウンロードボタンを使用したWebアプリを作成します。
2. [デスクトップユーザーを検出する](#detect-desktop-users) - デスクトップユーザーかモバイルユーザーかに応じた適切なダウンロードボタンを表示します。
3. [名前と電話番号を収集する](#collect-a-name-and-phone-number) - デスクトップブラウザの場合、ユーザー情報を収集するためのフォームを表示します。
4. [SMSでダウンロードリンクを送信する](#send-the-download-link-in-an-sms) - アプリのダウンロードリンクを含むSMSをユーザーに送信します。
5. [このチュートリアルを実行する](#run-this-tutorial) - このチュートリアルを実行し、自分の電話番号にダウンロードURLを送信します。

準備
---

このチュートリアルを進めるためには、次のものが必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* VonageがアプリにWebhookリクエストを送信できるように、一般にアクセス可能なWebサーバー。ローカルで開発している場合は、[ngrok](https://ngrok.com/)のようなツール（[ngrokのチュートリアルについては、ブログ投稿をご覧ください](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)）を使用する必要があります。
* このチュートリアルのソースコードは[https://github.com/Nexmo/ruby-mobile-app-promotion](https://github.com/Nexmo/ruby-mobile-app-promotion)にあります

Webアプリを作成する
-----------

顧客インターフェースとして、[Sinatra](http://www.sinatrarb.com)と[rack](https://github.com/nakajima/rack-flash)を使用して1ページのWebアプリを作成します。

**Gemfile** 

```ruby
source 'https://rubygems.org'

gem 'sinatra'
gem 'rack-flash3'
```

**app.rb** 

```ruby
# web server and flash messages
require 'sinatra'
require 'rack-flash'
use Rack::Flash

# enable sessions and set the
# session secret
enable :sessions
set :session_secret, '123456'

# Index
# - shows our landing page
#   with links to download
#   from the app stores or
#   via SMS
#
get '/' do
  erb :index
end
```

GoogleおよびiOSストアボタンを、WebアプリのHTMLに次のように追加します。

**views/index.erb** 

```erb
<a href="https://play.google.com/store/apps/details?id=com.imdb.mobile">
  <!-- place this image in a public/ folder -->
  <img src="google-play-badge.png" />
</a>

<a href="https://geo.itunes.apple.com/us/app/google-official-search-app/id284815942">
  <!-- place this image in a public/ folder -->
  <img src='app-store-badge.svg' />
</a>
```

> [ボタンをダウンロード](/assets/archives/app-store-badges.zip)して、作業を楽にすることができます。

デスクトップユーザーの検出
-------------

ユーザーがブラウズしているデバイスが、モバイルなのかデスクトップなのかを確認するには、 *request.user\_agent* を解析します。

**Gemfile** 

    gem 'browser'

**app.rb** 

```ruby
# determine the browser and platform
require 'browser'

before do
  @browser ||= Browser.new(request.user_agent)
end
```

`browser.device`の値を使用して、モバイルデバイスの正しいストアボタンを表示します。

**views/index.erb** 

```erb
<% unless @browser.platform.ios? %>
  <a href="https://play.google.com/store/apps/details?id=com.imdb.mobile">
    <!-- place this image in a public/ folder -->
    <img src="google-play-badge.png" />
  </a>
<% end %>

<% unless @browser.platform.android? %>
  <a href="https://geo.itunes.apple.com/us/app/google-official-search-app/id284815942">
    <!-- place this image in a public/ folder -->
    <img src='app-store-badge.svg' />
  </a>
<% end %>
```

ユーザーがモバイルデバイスを使用していない場合は、SMSダウンロード用のボタンを表示します。

**views/index.erb** 

```erb
<% unless @browser.device.mobile? %>
  <a href="/download">
    <!-- place this image in a public/ folder -->
    <img src='sms-badge.png' />
  </a>
<% end %>
```

このボタンは次のようになります。

![モバイルアプリのボタンの例](/images/sms-badge.png)

名前と電話番号を収集する
------------

ユーザーがデスクトップからブラウズしている場合は、HTMLフォームを使用してSMSの送信先の電話番号と、このリンクを友人に送信する場合は、名前の両方を収集します。ユーザーがホームページのSMSダウンロード用ボタンをクリックすると、電話番号の入力フォームが表示されます。

**app.rb** 

```rb
# Download page
# - a page where the user
#   fills in their phone
#   number in order to get a
#   download link
#
get '/download' do
  erb :download
end
```

フォームは、SMS APIで期待される[E.164](https://en.wikipedia.org/wiki/E.164)形式で電話番号をキャプチャします。

**views/download.erb** 

```erb
<form action="/send_sms" method="post">
  <div class="field">
    <label for="number">
      Phone number
    </label>
    <input type="text" name="number">
  </div>

  <div class="actions">
    <input type="submit" value="Continue">
  </div>
</form>
```

ユーザーが [ *Continue (続行)* ] をクリックすると、SMS APIを使用して、アプリのダウンロードURLを含むテキストメッセージが送信されます。

SMSの正しいストアへの直接リンクを送信することもできます。これを行うには、ユーザーがデバイスを選択できるように、フォームを更新します。

SMSでダウンロードリンクを送信する
------------------

SMS APIへの1回の呼び出しでSMSが送信されると、Vonageがすべてのルーティングと配信を処理します。次の図は、SMSを送信するために、このチュートリアルで使用するワークフローを示しています。

```sequence_diagram
Participant App
Participant Vonage
Participant Phone number
Note over App: Initialize library
App->>Vonage: Request to SMS API
Vonage-->>App: Response from SMS API
Note over Vonage: Request accepted
Vonage->>Phone number: Send SMS
```

このチュートリアルでは、SMSを送信するために、[RubyサーバーSDK](https://github.com/Nexmo/nexmo-ruby)をアプリに追加します。

**Gemfile** 

```rb
gem 'nexmo'
```

Vonage APIの[キーとシークレット](/concepts/guides/authentication)を使用してクライアントを初期化します。

**app.rb** 

```rb
# Nexmo library
require 'nexmo'
nexmo = Nexmo::Client.new(
  api_key: ENV['VONAGE_API_KEY'],
  api_secret: ENV['VONAGE_API_SECRET']
)
```

> **注** ：API認証情報をコードに保存せず、代わりに環境変数を使用してください。

初期化されたライブラリを使用して [SMS API](/api/sms#send-an-sms)へのリクエストを行います。

**app.rb** 

```rb
# Send SMS
# - when submitted this action
#   sends an SMS to the user's
#   phone number with a download
#   link
#
post '/send_sms' do
  message = "Download our app on #{url('/')}"

  # send the message
  response = nexmo.sms.send(
    from: 'My App',
    to: params[:number],
    text: message
  ).messages.first

  # verify the response
  if response.status == '0'
    flash[:notice] = 'SMS sent'
    redirect '/'
  else
    flash[:error] = response.error-text
    erb :download
  end
end
```

*ステータス* 応答パラメーターは、Vonageがリクエストを受け入れSMSを送信したかどうかを通知します。

このSMSがユーザーによって受信されたことを検証するには、（リンク：messaging/sms-api/api-reference\#delivery\_receipt text: delivery receipt）を確認します。このチュートリアルでは、受信確認の検証は行いません。

このチュートリアルを実行する
--------------

このチュートリアルを実行するには、次の手順に従います。

1. アプリを起動します。
2. デスクトップブラウザを使用して、Webアプリに移動します。
3. [SMS message (SMS メッセージ)] ボタンをクリックします。電話番号フォームが表示されます。
4. フォームに記入して送信してください。数秒以内に、アプリへのリンクが記載されたSMSテキストが届きます。

> **注** ：SMSに *localhost* または *127\.0\.0\.1* リンクが記載されている場合は、[ngrok](https://ngrok.com/)などのツールを使用して、モバイルデバイスが接続できるURLをチュートリアルコードで作成します。

まとめ
---

これで終わりです。これで、SMSでモバイルアプリをダウンロードするダイレクトリンクを自分自身や友人に送信することができるようになりました。これを行うため、電話番号を収集し、ユーザーにリンクを送信し、プラットフォームを検出し、手順を進めるための適切なダウンロードリンクを提示しました。

コードを入手する
--------

このチュートリアルに必要なコードはすべて、[モバイルアプリへの招待チュートリアルのGitHubリポジトリ](https://github.com/Nexmo/ruby-customer-engagement)にあります。

関連情報
----

* [RubyサーバーSDK](https://github.com/Nexmo/nexmo-ruby)
* [SMS](/sms)
* [SMS APIリファレンスガイド](/api/sms)

