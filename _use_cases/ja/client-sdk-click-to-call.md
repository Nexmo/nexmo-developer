---
title:  クリックしてコールする

products: client-sdk

description:  顧客がWebサイトから直接電話できるようにする方法を説明します。

languages:
  - Node


---

顧客がWebサイトからに電話をかけられるようにする
=========================

お客様に最高のサービスを提供するには、お客様が快適で慣れ親しんだコミュニケーション方法を使用して、迅速かつ便利にお客様と連絡を取ることができるようにする必要があります。電話番号を「お問い合わせ」ページで検索させるのではなく、Webサイト上に電話をかけるボタンを追加しませんか？

このユースケースでは、貴社のWebサイトにサポートページがあると想定します。クライアントSDKを使用してVonage仮想番号に電話をかけ、サポートクエリを処理できる「実際の」番号に電話を転送するボタンを追加します。

この例では、クライアント側のJavaScriptを使用してボタンを表示し、バックエンドでコールとnode.jsを実行してユーザーを認証し、選択した番号にコールをルーティングします。ただし、代わりにクライアント[iOS](/sdk/stitch/ios/)または[Android](/sdk/stitch/android/) SDKと同様のアプローチを使用して、モバイルアプリを構築することもできます。

コードはすべて[GitHubで公開されています](https://github.com/nexmo-community/client-sdk-click-to-call)

準備
---

このユースケースを進めるためには、以下のものが必要になります。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli)がインストールされ、設定されている。
* VonageがアプリにWebhookリクエストを実行できるように、一般にアクセス可能なWebサーバー。ローカルで開発している場合、[ngrok](https://ngrok.com/)をお勧めします。

はじめに
----

コードを使って作業を始める前に、いくつかの初期設定が必要です。

### リポジトリのクローンを作成する

GitHubからソースコードをダウンロードします：

    git clone https://github.com/nexmo-community/client-sdk-click-to-call
    cd client-sdk-click-to-call

### Nexmo CLIをインストールする

[Developer Dashboard](https://dashboard.nexmo.com)を使用して、これらの初期手順の一部を実行できます。ただし、Nexmo CLIを使った方が簡単な場合が多く、後の手順で必要になるため、続行する前にNexmo CLIベータ版をインストールしてください。

```sh
npm install nexmo-cli@beta 
```

次に、APIキーとシークレットを使用してNexmo CLIを設定します。

```sh
nexmo setup API_KEY API_SECRET
```

### Vonage番号を購入する

顧客が電話をかけるには、Vonage仮想番号が必要です。次のCLIコマンドを使用して、選択した国コードで使用可能な番号を購入できます。

    nexmo number:buy -c GB --confirm

`GB`をご自分の[国コード](https://www.iban.com/country-codes)に置き換えてください。

アプリケーションを作成する
-------------

ロジックを含むアプリケーション自体とVonageアプリケーションを混同しないようにしましょう。

Vonageアプリケーションは、セキュリティおよび設定情報のコンテナです。Vonageアプリケーションを作成する際には、いくつかの[Webhook](https://developer.nexmo.com/concepts/guides/webhooks)エンドポイントを指定します。これらは、コードが公開するURLであり、一般にアクセス可能である必要があります。発信者がVonage番号に電話をかけると、Vonageは指定した`answer_url`エンドポイントにHTTPリクエストを送信し、そこにある指示に従います。`event_url`エンドポイントを指定すると、Vonageはコールイベントに関するアプリケーションを更新します。これは問題のトラブルシューティングに役立ちます。

Vonageアプリケーションを作成するには、Nexmo CLIを使用して以下のコマンドを実行し、両方のURLの`YOUR_SERVER_HOSTNAME`を自分のサーバーのホスト名に置き換えます。

```bash
nexmo app:create --keyfile private.key ClickToCall https://YOUR_SERVER_HOSTNAME/webhooks/answer https://YOUR_SERVER_NAME/webhooks/event
```

このコマンドは、一意のアプリケーションIDを返します。後で必要になるため、どこかにコピーしておいてください。

パラメーターは次のとおりです。

* `ClickToCall` - Vonageアプリケーションの名前
* `private.key` - 認証のための秘密鍵を格納するファイルの名前。これはアプリケーションのルートディレクトリにダウンロードされます。
* `https://example.com/webhooks/answer` - Vonage番号への着信コールを受信すると、Vonageは`GET`リクエストを行い、VonageのAPIにコールの処理方法を指示する[NCCO](/voice/voice-api/ncco-reference)を取得します
* `https://example.com/webhooks/event` - 通話ステータスが変更されると、VonageはこのWebhookエンドポイントにステータスの更新を送信します

Vonage番号をリンクする
--------------

このアプリケーションが使用している仮想番号をVonageに伝える必要があります。次のCLIコマンドを実行し、`NEXMO_NUMBER`および`APPLICATION_ID`を自分の値に置き換えます。

    nexmo link:app NEXMO_NUMBER APPLICATION_ID

ユーザーを作成する
---------

Vonage番号を呼び出す前に、クライアントSDKを使用してユーザーを認証する必要があります。ユーザの一意のIDを返す次のCLIコマンドを使用して、`supportuser`というユーザを作成します。この例ではそのIDを追跡する必要はないので、このコマンドの出力を無視しても問題ありません。

    nexmo user:create name="supportuser"

JWTを生成する
--------

Client SDK（クライアントSDK）は、認証に[JWT](/concepts/guides/authentication#json-web-tokens-jwt)を使用します。次のコマンドを実行してJWTを作成し、`APPLICATION_ID`を自分のVonageアプリケーションIDに置き換えます。JWTは1日（Vonage JWTの最大有効期間）後に期限切れになります。その後は、JWTを再生成する必要があります。

    nexmo jwt:generate ./private.key sub=supportuser exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID

アプリケーションを構成する
-------------

サンプルコードは、`.env`ファイルを使用して設定の詳細を保存します。`example.env`を`.env`にコピーして、次のように入力します：

    PORT=3000
    JWT= /* The JWT for supportuser */
    SUPPORT_PHONE_NUMBER= /* The Vonage Number that you linked to your application */
    DESTINATION_PHONE_NUMBER= /* A target number to receive calls on */

`.env`で指定する電話番号では、先頭のゼロを省略し、国コードを含める必要があります。

例（英国の携帯電話番号`07700 900000`を使用）：`447700900000`

試行手順
----

次のコマンドを実行して、必要な依存関係をインストールします：

```sh
npm install
```

アプリケーションがパブリックインターネットからVonageのAPIにアクセスできることを確認してください。[これにはngrokを使うことができます](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr)：

```sh
ngrok http 3000
```

アプリケーション自体を起動します。

    npm start

ブラウザで`http://localhost:3000`にアクセスしてください。すべてが正しく構成されている場合は、「Acme Inc Support」ホームページと、`supportuser`がログインしていることを通知するメッセージが表示されます。

「今すぐ電話」ボタンをクリックすると、ウェルカムメッセージが聞こえ、`DESTINATION_PHONE_NUMBER`で指定した番号が鳴るはずです。「電話を切る」ボタンをクリックして、コールを終了します。

サーバー側のコード
---------

コードを掘り下げて、このサンプルがどのように機能するかを見てみましょう。ここでは、ユーザーを認証してコールを行うクライアント側のコードと、コール自体を管理するサーバー側のコードの2つの側面を考慮する必要があります。

サーバー側のコードは`server.js`ファイルに含まれています。`express`フレームワークを使用してサーバーを作成し、アプリケーションに必要なURLを公開し、`pug`テンプレートエンジンを使用して`views`ディレクトリのテンプレートからWebページを作成します。ユーザーがアプリケーション（`https://localhost:3000`）のルートにアクセスすると、`index.pug`で定義されている初期ビューがレンダリングされます。

`public`ディレクトリ（クライアント側のコードとスタイルシート）ですべてを提供することにより、クライアントが必要とするすべてが提供されます。クライアントコードでJavaScript用のクライアントSDKを利用できるようにするために、`node_modules`からも適切なコードファイルを提供しています。

```javascript
const express = require('express');
const app = express();

require('dotenv').config();

app.set('view engine', 'pug');

app.use(express.static('public'))
app.use('/modules', express.static('node_modules/nexmo-client/dist/'));

const server = app.listen(process.env.PORT || 3000);

app.get('/', (req, res) => {
  res.render('index');
})
```

### JWTの提供

クライアントは`/auth`ルートを呼び出して、指定されたユーザーの正しいJWTを取得します。このサンプルでは、JWTが`.env`ファイルで構成されている単一のユーザーがいますが、本番アプリケーションでは、これらのJWTを動的に生成する必要があります。

```javascript
app.get('/auth/:userid', (req, res) => {
  console.log(`Authenticating ${req.params.userid}`)
  return res.json(process.env.JWT);
})
```

### 応答Webhook

顧客がVonage仮想番号に電話をかけると、VonageのAPIは応答URLとして指定したWebhookに`GET`リクエストを行い、Vonageにコールの処理方法を指示するアクションの配列を含むJSONオブジェクト（Nexmo Call Control Object、つまりNCCO）を取得することを期待します。

この例では、`talk`アクションを使用してウェルカムメッセージを読み取り、次に`connect`アクションを使用して、選択した番号にコールをルーティングします。

```javascript
app.get('/webhooks/answer', (req, res) => {
  console.log("Answer:")
  console.log(req.query)
  const ncco = [
    {
      "action": "talk",
      "text": "Thank you for calling Acme support. Transferring you now."
    },
    {
      "action": "connect",
      "from": process.env.NEXMO_NUMBER,
      "endpoint": [{
        "type": "phone",
        "number": process.env.DESTINATION_PHONE_NUMBER
      }]
    }]
  res.json(ncco);
});
```

### イベントWebhook

VonageのAPIは、コールに関連するイベントが発生するたびに、Vonageアプリケーションの作成時に指定したイベントWebhookエンドポイントにHTTPリクエストを行います。ここでは、その情報をコンソールに出力しているだけなので、何が起こっているのか確認できます。

```javascript
app.post('/webhooks/event', (req, res) => {
  console.log("EVENT:")
  console.log(req.body)
  res.status(200).end()
});
```

クライアント側のコード
-----------

クライアント側のコードは`/public/js/client.js`にあり、ページの読み込みが完了すると実行されます。これはユーザーの認証と呼び出しを行います。

### ユーザーの認証

クライアントコードが最初に行うことは、クライアントSDKを使用してそのユーザーを認証できるように、サーバーからユーザーの正しいJWTを取得することです。

```javascript
  // Fetch a JWT from the server to authenticate the user
  const response = await fetch('/auth/supportuser');
  const jwt = await response.json();

  // Create a new NexmoClient instance and authenticate with the JWT
  let client = new NexmoClient();
  application = await client.login(jwt);
  notifications.innerHTML = `You are logged in as ${application.me.name}`;
```

### コールの発信

ユーザーが「今すぐ電話」をクリックすると、認証済み`application`オブジェクトの`callServer`メソッドを使用してコールを開始し、ボタンの状態を変更します。

```javascript
  // Whenever we click the call button, trigger a call to the support number
  // and hide the Call Now button
  btnCall.addEventListener('click', () => {
    application.callServer();
    toggleCallStatusButton('in_progress');
  });
});

function toggleCallStatusButton(state) {
  if (state === 'in_progress') {
    btnCall.style.display = "none";
    btnHangup.style.display = "inline-block";
  } else {
    btnCall.style.display = "inline-block";
    btnHangup.style.display = "none";
  }
}
```

VonageのAPIは、仮想番号で着信コールを受信し、サーバーの応答URLエンドポイントにリクエストを行い、NCCOを取得して、選択したデバイスにコールを転送します。

### コールの終了

他に行うことは、会話のいずれかの参加者が [電話を切る] ボタンをクリックして通話を終了できるようにすることだけです。コールが進行中であることを確認するイベントを受信すると、そのボタンを使用できるようにします。

イベントは、呼び出しを制御するために使用できるパラメーターとして`call`オブジェクトを受け取ります。この場合、`hangup`メソッドを呼び出して終了します。

また、`member:left`イベントを監視して、どちらかの当事者がコールを終了し、それに応じてボタンの状態を変更するかどうかを判断できるように、`call`からアクティブな会話を取得する必要があります：

```javascript
  // Whenever a call is made bind an event that ends the call to
  // the hangup button
  application.on("member:call", (member, call) => {
    let terminateCall = () => {
      call.hangUp();
      toggleCallStatusButton('idle');
      btnHangup.removeEventListener('click', terminateCall)
    };
    btnHangup.addEventListener('click', terminateCall);

    // Retrieve the Conversation so that we can determine if a 
    // Member has left and refresh the button state
    conversation = call.conversation;
    conversation.on("member:left", (member, event) => {
      toggleCallStatusButton('idle');
    });
  });
```

まとめ
---

このユースケースでは、Webページのボタンをクリックして顧客があなたに電話をかけるための迅速で便利な方法を実装する方法を学びました。その過程で、Vonageアプリケーションを作成し、仮想番号をそれにリンクし、ユーザーを作成して認証する方法を学びました。

関連情報
----

* [完全なソースコード](https://github.com/nexmo-community/client-sdk-click-to-call)
* [クライアントSDKドキュメント](/client-sdk/overview)
* [アプリ内音声ドキュメント](/client-sdk/in-app-voice/overview)
* [コンタクトセンターのユースケース](/client-sdk/in-app-voice/contact-center-overview)

