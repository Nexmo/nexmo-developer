---
title:  Node.jsでWebSocketに通話を発信する

products: voice/voice-api

description:  このチュートリアルでは、WebSocketエンドポイントに通話を接続して通話音声を発信者にエコーバックさせる方法について説明します。

languages:
  - Node
*** ** * ** ***
Node.jsでWebSocketに通話を発信する
=========================
Vonage音声用APIを使用すると、通話を[WebSocket](/voice/voice-api/guides/websockets)に接続し、WebSocketプロトコルを経由して配信される通話音声の双方向ストリームをリアルタイムで提供できます。これにより、通話音声を処理して、感情分析、リアルタイムの文字起こし、人工知能を使用した意思決定などのタスクを実行できます。
このチュートリアルでは、WebSocketエンドポイントに着信コールを接続します。WebSocketサーバーは通話音声を聞き、それをエコーバックします。[Express](https://expressjs.com) Webアプリケーションフレームワークと[express-ws](https://www.npmjs.com/package/express-ws)を使用して実装します。これにより、他の`express`ルートと同様にWebSocketエンドポイントを定義できます。
準備
---
このチュートリアルを完了するには、以下のものが必要です。
* [Vonageアカウント](https://dashboard.nexmo.com/sign-up) - APIキーおよびシークレット用
* [ngrok](https://ngrok.com/) - 開発用Webサーバーをインターネット経由でVonageのサーバーにアクセスできるようにする
Nexmo CLIをインストールする
------------------
着信コールを受信するには、Vonage仮想番号が必要です。まだお持ちでない場合は、[Developer Dashboard](https://dashboard.nexmo.com)で番号を購入して設定するか、[Nexmo CLI](https://github.com/Nexmo/nexmo-cli)を使用します。このチュートリアルでは、CLIを使用します。
ターミナルプロンプトで以下のコマンドを実行し、CLIをインストールして、APIキーとシークレットを使用して設定します。これらは[Developer Dashboard](https://dashboard.nexmo.com)で確認できます。
```sh
npm install -g nexmo-cli
nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```
Vonage番号を購入する
-------------
まだお持ちでない場合は、着信コールを受信するためにVonage仮想番号を購入してください。
まず、お住まいの国で利用可能な番号をリストします（`GB`を2文字の[国コード](https://www.iban.com/country-codes)に置き換えてください）：
```sh
nexmo number:search GB
```
利用可能な番号のいずれかを購入してください。たとえば、番号`447700900001`を購入するには、次のコマンドを実行します。
```sh
nexmo number:buy 447700900001
```
音声用APIアプリケーションを作成する
-------------------
CLIを使用して、Vonage番号（`/webhooks/answer`）でのコールへの応答と通話イベントのログ記録（`/webhooks/events`）をそれぞれ行うWebhookで音声用APIアプリケーションを作成します。
これらのWebhookは、Vonageのサーバーからアクセスできる必要があるため、このチュートリアルでは、`ngrok`を使用してローカル開発環境をパブリックインターネットに公開します。[このブログ記事](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)では、`ngrok`をインストールして実行する方法について説明しています。
次のコマンドを使用して`ngrok`を実行します。
```sh
ngrok http 3000
```
`ngrok`が提供する一時的なホスト名をメモしておき、次のコマンドで`example.com`の代わりに使用します。
```sh
nexmo app:create "My Echo Server" https://example.com/webhooks/answer https://example.com/webhooks/events
```
このコマンドは、アプリケーションID（メモしておく必要があります）と公開鍵情報（このチュートリアルでは無視しても問題ありません）を返します。
番号をリンクする
--------
Vonage番号を、作成した先ほど作成し音声用APIアプリケーションにリンクする必要があります。次のコマンドを使用します。
```sh
nexmo link:app NEXMO_NUMBER NEXMO_APPLICATION_ID
```
これで、アプリケーションコードを書く準備ができました。
プロジェクトを作成する
-----------
アプリケーション用のディレクトリを作成し、そのディレクトリに`cd`して、Node.jsパッケージマネージャー`npm`を使用して、アプリケーションの依存性用の`package.json`ファイルを作成します。
```sh
$ mkdir myapp
$ cd myapp
$ npm init
```
Enterキーを押して、既定値を受け入れます。
次に、[Express](https://expressjs.com) Webアプリケーションフレームワーク、[express-ws](https://www.npmjs.com/package/express-ws)、[body-parser](https://www.npmjs.com/package/body-parser)パッケージをインストールします。
```sh
$ npm install express express-ws body-parser
```
応答Webhookを記述する
--------------
Vonageが仮想番号で着信コールを受信すると、`/webhooks/answer`ルートにリクエストを送信します。このルートは、HTTP `GET`リクエストを受け入れて、Vonageにコールの処理方法を指示する[Nexmo Call Control Object（NCCO）](/voice/voice-api/ncco-reference)を返す必要があります。
NCCOは、`text`アクションを使用して発信者に挨拶し、`connect`アクションを使用して、Webhookに通話を接続します。
```javascript
'use strict'
const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const expressWs = require('express-ws')(app)
app.use(bodyParser.json())
app.get('/webhooks/answer', (req, res) => {
  let nccoResponse = [
    {
      "action": "talk",
      "text": "Please wait while we connect you to the echo server"
    },
    {
      "action": "connect",
      "from": "NexmoTest",
      "endpoint": [
        {
          "type": "websocket",
          "uri": `wss://${req.hostname}/socket`,
          "content-type": "audio/l16;rate=16000",
        }
      ]
    }
  ]
  res.status(200).json(nccoResponse)
})
```
`endpoint`の`type`は`websocket`です。`uri`は、WebSocketサーバーがアクセス可能な`/socket`ルートで、`content-type`は音声品質を指定します。
イベントWebhookを記述する
----------------
コンソールでコールのライフサイクルを監視できるように、通話イベントをキャプチャするWebhookを実装します。
```javascript
app.post('/webhooks/events', (req, res) => {
  console.log(req.body)
  res.send(200);
})
```
Vonageは通話ステータスが変更されるたびに、このエンドポイントに`POST`リクエストを送信します。
WebSocketを作成する
--------------
まず、`connection`イベントを処理し、Webhookサーバーがオンラインで、通話音声を受信する準備ができていることを報告できるようにします。
```javascript
expressWs.getWss().on('connection', function (ws) {
  console.log('Websocket connection is open');
});
```
次に、`/socket`ルートのルートハンドラを作成します。これは、WebSocketが通話から音声を受信するたびに発生する`message`イベントをリッスンします。アプリケーションは、`send()`メソッドを使用して、発信者に音声をエコーバックして応答します。
```javascript
app.ws('/socket', (ws, req) => {
  ws.on('message', (msg) => {
    ws.send(msg)
  })
})
```
Node.jsサーバーを作成する
----------------
最後に、Nodeサーバーをインスタンス化するコードを記述します。
```javascript
const port = 3000
app.listen(port, () => console.log(`Listening on port ${port}`))
```
アプリケーションをテストする
--------------
1. 次のコマンドを実行して、Node.jsアプリケーションを実行します。
```sh
node index.js
```
1. Vonage番号に電話して、ウェルカムメッセージを聞いてください。
2. 何かを言うと、通話の他の参加者であるWebSocketサーバーから音声がエコーバックされるのが聞こえます。
まとめ
---
このチュートリアルでは、音声用APIを使用してWebSocketエンドポイントに接続するアプリケーションを作成しました。
作成したWebSocketは非常にシンプルなものですが、通話音声を聞いてそれに応答することができました。これによって、人工知能、分析、通話音声の文字起こしなど、非常に強力で高度なユースケースを実現することができます。
関連情報

---

以下のリソースは、音声用APIアプリケーションでWebSocketを使用する際に役立ちます。

* GitHubにあるこのチュートリアルの[ソースコード](https://github.com/Nexmo/node-websocket-echo-server)
* [WebSocketガイド](/voice/voice-api/guides/websockets)
* [WebSocketプロトコル標準](https://tools.ietf.org/html/rfc6455)
* [Vonage音声用APIとWebSocketの入門ウェビナー（録画）](https://www.nexmo.com/blog/2017/02/15/webinar-getting-started-nexmo-voice-websockets-dr/)
* Vonage開発者ブログの[WebSocketに関する記事](https://www.nexmo.com/?s=websockets)
* [NCCO接続アクション](/voice/voice-api/ncco-reference#connect)
* [エンドポイントガイド](/voice/voice-api/guides/endpoints)
* [音声用APIリファレンスドキュメント](/voice/voice-api/api-reference)

