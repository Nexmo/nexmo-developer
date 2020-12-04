---
title:  進行中の音声通話の会話の詳細を取得する

products: conversation

description:  「進行中の音声通話の会話オブジェクトの詳細を取得する」

languages:
  - Curl
  - Python
*** ** * ** ***
会話の詳細を取得する
==========
Conversation APIを使用して、音声通話の会話オブジェクトの詳細を取得できます。
このチュートリアルでは、特に音声通話の詳細を取得することに焦点を当てていますが、ビデオ通話やテキストチャットセッションなど、他の機能を使用したさまざまなユースケースがあります。このチュートリアルの目的は、会話の構造について理解を深めることです。会話は、Vonageの技術の基礎となる重要なオブジェクトであるためです。すべてのコミュニケーションが会話を介して行われるため、会話はコミュニケーション活動の基本となるデータ構造です。
このチュートリアルで使用するセットアップは、次の図のとおりです。
![カンバセーション](/images/conversation-api/call-forward-conversation.png)
このチュートリアルの内容
------------
* [準備](#prerequisites)
* [Vonageアプリケーションを作成する](#create-a-nexmo-application)
* [JWTを作成する](#create-a-jwt)
* [Webhookサーバーを稼働させる](#run-your-webhook-server)
* [Vonage番号に電話する](#call-your-nexmo-number)
* [会話の詳細を取得する](#get-the-conversation-details)
* [まとめ](#conclusion)
* [関連情報](#resources)
準備
---
1. [Vonageアカウントを作成する](/account/guides/management#create-and-configure-a-nexmo-account) - これがないと先に進めません。
2. [Vonage番号をレンタルする](/account/guides/numbers#rent-virtual-numbers) - 2、3ユーロの無料クレジットが必要です。それだけあれば十分です。
3. [Nexmoコマンドラインツールをインストールする](/tools) - [Node](https://nodejs.org)をインストールする必要がありますが、Nexmo CLIを使用するとすばやくて便利です。
4. [Python 3](https://realpython.com/installing-python/)と[Flask](http://flask.pocoo.org/)がインストールされている必要があります。これらはWebhookサーバーに必要です。
このチュートリアルでは、[Webhook](/concepts/guides/webhooks)サーバーをローカルで実行するために[Ngrok](https://ngrok.com)を実行していることを前提としています。
Ngrokに馴染みがない方は、先に進む前に[Ngrokのチュートリアル](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)を参照してください。
また、このチュートリアルでは2台の電話へのアクセスが必要です。
準備ができたら次へ進みましょう。
Vonageアプリケーションを作成する
-------------------
まだ作成していない場合は、Vonageアプリケーションを作成する必要があります。
```bash
nexmo app:create "Conversation App" http://demo.ngrok.io/webhooks/answer http://demo.ngrok.io/webhooks/event --keyfile private.key
```
この前のコマンドでは、`demo`をセットアップに適用されるものに置き換える必要があります。
生成されたアプリケーションID（`APP_ID`）をメモしておきます。これは、JWTを生成する際に必要になります。
Vonage番号をアプリケーションにリンクする
-----------------------
すでにVonage番号（`VONAGE_NUMBER`<code translate="no">VONAGE\_NUMBER</code>）をレンタルしている場合、Dashboardまたはコマンドラインを介してアプリケーションとVonage番号をリンクできます。
```bash
nexmo link:app VONAGE_NUMBER APP_ID
```
JWTを作成する
--------
Conversation APIはJWTを使用して認証されます。次のコマンドを使用して、JWTを生成できます。
```bash
JWT="$(nexmo jwt:generate private.key exp=$(($(date +%s)+86400)) application_id=APP_ID)"
```
`APP_ID`をアプリケーションのIDに置き換える必要があります。また、`private.key`は、この同じアプリケーションに関連付けられたキーです。

> **注：** このJWTの有効期限は1日です。
次に、次のものを使用してJWTを表示できます。
```bash
echo $JWT
```

> **ヒント：** JWTは[jwt.io](https://jwt.io)で確認できます。
Webhookサーバーを稼働させる
-----------------
進行中の通話のカンバセーションIDを取得するためには、Webhookサーバーを実行する必要があります。次のPythonコードで十分です。
```python
from flask import Flask, request, jsonify
from pprint import pprint
app = Flask(__name__)
ncco = [{
        "action": "connect",
        "endpoint": [{
            "type": 'phone',
            "number": 'TO_NUMBER'
        }]
}]
@app.route("/webhooks/answer")
def answer_call():
    params = request.args
    pprint(params)
    return jsonify(ncco)
if __name__ == '__main__':
    app.run(port=3000)
```

> **重要：*  - TO_NUMBERを2番目の電話の番号、電話2（Bob）に置き換える必要があります。
このWebhookサーバーをローカルで実行します。
```bash
python3 app.py
```
Vonage番号に電話する
-------------
電話1（Alice）でVonage番号をダイヤルします。着信コールは、2番目の電話、電話2（Bob）に転送されます。電話2（Bob）でコールに応答します。この時点で通話をキャンセルしないでください。
Webhookサーバーによって生成されたログを確認します。次のようなものが表示されます。
    ...
    {
       'conversation_uuid': 'CON-bc643220-2542-499a-892e-c982c4150c06',
       'from': '447700000001',
       'to': '447700000002',
       'uuid': '797168e24c19a3c45e74e05b10fef2b5'
    }
    ...
`CON-<uuid>`という形式のカンバセーションIDだけが必要です。そのIDをどこか便利な場所にコピーして貼り付けてください。
会話の詳細を取得する
----------
別のターミナルタブで以下のコマンドを実行することで、現在のコールの会話オブジェクトの詳細を取得できます。

> **注：*  - $CONVERSATION_ID`を以前に取得したIDに、`$JWTを以前に作成したJWTに置き換える必要があります。
次を使用して、音声通話の会話の詳細を取得します。
```code_snippets
source: '_examples/conversation/conversation/get-conversation'
```
このAPIコールでは、以下のような応答が得られます。
```json
{
    "uuid": "CON-bc643220-2542-499a-892e-c982c4150c06",
    "name": "NAM-1b2c4274-e3f2-494e-89c4-46856ee84a8b",
    "timestamp": {
        "created": "2018-10-25T09:26:18.999Z"
    },
    "sequence_number": 8,
    "numbers": {},
    "properties": {
        "ttl": 172800,
        "video": false
    },
    "members": [
        {
            "member_id": "MEM-f44c872e-cba9-444f-88ae-0bfa630865a6",
            "user_id": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6",
            "name": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6",
            "state": "JOINED",
            "timestamp": {
                "joined": "2018-10-25T09:26:30.334Z"
            },
            "channel": {
                "type": "phone",
                "id": "797168e24c19a3c45e74e05b10fef2b5",
                "from": {
                    "type": "phone",
                    "number": "447700000001"
                },
                "to": {
                    "type": "phone",
                    "number": "447700000002"
                },
                "leg_ids": [
                    "797168e24c19a3c45e74e05b10fef2b5"
                ]
            },
            "initiator": {
                "joined": {
                    "isSystem": true
                }
            }
        },
        {
            "member_id": "MEM-25ccda92-839d-4ac6-a7b2-de310224878b",
            "user_id": "USR-b9948493-be4a-4b36-bb4d-c96bcc2af85b",
            "name": "vapi-user-f59c1ff26c0543fdb6c02fd30617a1c0",
            "state": "JOINED",
            "timestamp": {
                "invited": "2018-10-25T09:26:19.385Z",
                "joined": "2018-10-25T09:26:30.270Z"
            },
            "invited_by": "USR-b9948493-be4a-4b36-bb4d-c96bcc2af85b",
            "channel": {
                "type": "phone",
                "id": "30cecc87-7ac9-4d03-910a-e9d69558263c",
                "from": {
                    "number": "Unknown",
                    "type": "phone"
                },
                "leg_ids": [
                    "30cecc87-7ac9-4d03-910a-e9d69558263c"
                ],
                "to": {
                    "number": "447700000001",
                    "type": "phone"
                },
                "cpa": false,
                "preanswer": false,
                "ring_timeout": 60000,
                "cpa_time": 5000,
                "max_length": 7200000
            },
            "initiator": {
                "invited": {
                    "isSystem": true
                }
            }
        }
    ],
    "_links": {
        "self": {
            "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06"
        }
    }
}
```
この応答については、[会話](/conversation/concepts/conversation)のトピックで詳しく説明しています。
これで電話1（Alice）と電話2（Bob）を切って通話を終了できます。
まとめ
---
Conversation APIを使用して、音声通話の会話オブジェクトを取得する方法を確認しました。
関連情報

---

* [Conversation APIのドキュメント](/conversation/overview)
* [Conversation APIの関連情報](/api/conversation/)

