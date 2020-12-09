---
title:  PythonでWebSocketに通話を発信する

products: voice/voice-api

description:  このチュートリアルでは、WebSocketエンドポイントに通話を接続して通話音声を発信者にエコーバックさせる方法について説明します。

languages:
  - Python


---

PythonでWebSocketに通話を発信する
========================

音声用APIを使用すると、通話を[WebSocket](/voice/voice-api/guides/websockets)に接続し、WebSocketプロトコルを経由して配信される通話音声の双方向ストリームをリアルタイムで提供できます。これにより、通話音声を処理して、感情分析、リアルタイムの文字起こし、人工知能を使用した意思決定などのタスクを実行できます。

このチュートリアルでは、WebSocketエンドポイントに着信コールを接続します。WebSocketサーバーは通話音声を聞き、それをエコーバックします。[Flask](http://flask.pocoo.org/) Webアプリケーションフレームワークと[Flask-Sockets](https://www.npmjs.com/package/express-ws)を使用して実装します。これにより、他のFlaskルートと同様にWebSocketエンドポイントを定義できます。

準備
---

このチュートリアルを完了するには、以下のものが必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up) - APIキーおよびシークレット用
* [ngrok](https://ngrok.com/) - 開発用Webサーバーをインターネット経由でVonageのサーバーにアクセスできるようにする
* [Node.js](https://nodejs.org/en/download/) - `npm`パッケージインストーラを使用してNexmo CLIをイントールできるようにする

Nexmo CLIをインストールする
------------------

着信コールを受信するには、Vonage仮想番号が必要です。まだお持ちでない場合は、[Developer Dashboard](https://dashboard.nexmo.com)で番号を購入して設定するか、[Nexmo CLI](https://github.com/Nexmo/nexmo-cli)を使用します。このチュートリアルでは、CLIを使用します。

ターミナルプロンプトで以下のNode Package Manager（`npm`）コマンドを実行し、CLIをインストールして、APIキーとシークレットを使用して設定します。これらは[Developer Dashboard](https://dashboard.nexmo.com)で確認できます。

```sh
npm install -g nexmo-cli
nexmo setup VONAGE_API_KEY VONAGE_API_SECRET
```

Vonage番号を購入する
-------------

まだお持ちでない場合は、着信コールを受信するためにVonage番号を購入してください。

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
nexmo link:app VONAGE_NUMBER VONAGE_APPLICATION_ID
```

これで、アプリケーションコードを書く準備ができました。

プロジェクトを作成する
-----------

アプリケーション用のディレクトリを作成し、そのディレクトリに`cd`して、アプリケーションコードを記述するための`server.py`というファイルを作成します。

次に、[Flask](http://flask.pocoo.org/)、[Flask-Sockets](https://www.npmjs.com/package/express-ws)、[gevent](https://pypi.org/project/gevent/)（`Flask-Sockets`が依存するネットワークライブラリ）モジュールをインストールします。

```sh
$ pip3 install Flask gevent Flask-Sockets
```

応答Webhookを記述する
--------------

Vonageが仮想番号で着信コールを受信すると、`/webhooks/answer`ルートにリクエストを送信します。このルートは、HTTP `GET`リクエストを受け入れて、Vonageにコールの処理方法を指示する[Nexmo Call Control Object（NCCO）](/voice/voice-api/ncco-reference)を返す必要があります。

NCCOは、`text`アクションを使用して発信者に挨拶し、`connect`アクションを使用して、Webhookに通話を接続します。

```python
#!/usr/bin/env python3
from flask import Flask, request, jsonify
from flask_sockets import Sockets

app = Flask(__name__)
sockets = Sockets(app)


@app.route("/ncco")
def answer_call():
    ncco = [
        {
            "action": "talk",
            "text": "Please wait while we connect you to the echo server",
        },
        {
            "action": "connect",
            "from": "VonageTest",
            "endpoint": [
                {
                    "type": "websocket",
                    "uri": "wss://{0}/socket".format(request.host),
                    "content-type": "audio/l16;rate=16000",
                }
            ],
        },
    ]

    return jsonify(ncco)
```

`endpoint`の`type`は`websocket`です。`uri`は、WebSocketサーバーがアクセス可能な`/socket`ルートで、`content-type`で音声品質を指定します。

イベントWebhookを記述する
----------------

通話イベントについての最新情報を通知するためにVonageのサーバーが呼び出すことができるWebhookのスタブを作成します。このチュートリアルではリクエストデータを使用しないため、`HTTP 200`応答（`success`）が返されるだけです。

```python
@app.route("/webhooks/event", methods=["POST"])
def events():
    return "200"
```

Vonageは通話ステータスが変更されるたびに、このエンドポイントに`POST`リクエストを送信します。

WebSocketを作成する
--------------

`/socket`ルートのルートハンドラを作成します。これは、WebSocketが通話から音声を受信するたびに発生する`message`イベントをリッスンします。アプリケーションは、`send()`メソッドを使用して、発信者に音声をエコーバックして応答します。

```javascript
@sockets.route("/socket", methods=["GET"])
def echo_socket(ws):
    while not ws.closed:
        message = ws.receive()
        ws.send(message)
```

サーバーを作成する
---------

最後に、サーバーをインスタンス化するコードを記述します。

```python
if __name__ == "__main__":
    from gevent import pywsgi
    from geventwebsocket.handler import WebSocketHandler

    server = pywsgi.WSGIServer(("", 3000), app, handler_class=WebSocketHandler)
    server.serve_forever()
```

アプリケーションをテストする
--------------

1. 次のコマンドを実行して、Pythonアプリケーションを実行します。

```sh
python3 server.py
```

1. Vonage番号に電話して、ウェルカムメッセージを聞いてください。

2. 何かを言うと、通話の他の参加者であるWebSocketサーバーから音声がエコーバックされるのが聞こえます。

まとめ
---

このチュートリアルでは、音声用APIを使用してWebSocketエンドポイントに接続するアプリケーションを作成しました。

作成したWebSocketは非常にシンプルなものですが、通話音声を聞いてそれに応答することができました。これによって、人工知能、分析、通話音声の文字起こしなど、非常に強力で高度なユースケースを実現することができます。

関連情報
----

以下のリソースは、音声用APIアプリケーションでWebSocketを使用する際に役立ちます。

* GitHubにあるこのチュートリアルの[ソースコード](https://github.com/Nexmo/python-websocket-echo-server)
* [WebSocketガイド](/voice/voice-api/guides/websockets)
* [WebSocketプロトコル標準](https://tools.ietf.org/html/rfc6455)
* [Vonage音声用APIとWebSocketの入門ウェビナー（録画）](https://www.nexmo.com/blog/2017/02/15/webinar-getting-started-nexmo-voice-websockets-dr/)
* Vonage開発者ブログの[WebSocketに関する記事](https://www.nexmo.com/?s=websockets)
* [NCCO接続アクション](/voice/voice-api/ncco-reference#connect)
* [エンドポイントガイド](/voice/voice-api/guides/endpoints)
* [音声用APIリファレンスドキュメント](/voice/voice-api/api-reference)

