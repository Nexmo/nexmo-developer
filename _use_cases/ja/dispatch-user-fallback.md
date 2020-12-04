---
title:  Dispatch APIを使用したマルチユーザー、マルチチャネルフェイルオーバー

products: dispatch

description:  このチュートリアルでは、指定されたチャネルでユーザーへのメッセージの送信を試みるユースケースについて説明します。ユーザーへのメッセージが既読にならない場合、リストの次のユーザーに対してこのプロセスが繰り返されます。このユースケースでは、Dispatch APIをフェイルオーバーを伴うユーザーごとの複数の指定チャネルとして使用します。

languages:
  - Python
*** ** * ** ***
Dispatch APIを使用したマルチユーザー、マルチチャネルフェイルオーバー
========================================
このチュートリアルでは、自動フェイルオーバーを使用してユーザーのリストにメッセージを送る方法について説明します。
ユーザーのリストを用意します。各ユーザーには複数の指定チャネルがあり、それぞれ最後のチャネルが最終的なフォールバックチャネルになります。指定されたチャネルのユーザーの優先順位リストの最初のユーザーに、メッセージの送信を試行します。各チャネルは、適切なフェイルオーバー状態で順番に処理されます。
あるユーザーに送信したメッセージがすべて既読にならなかった場合、優先順位リストの次のユーザーに処理が移ります。
たとえば、メインサーバーに障害が発生していて、通話中のシステム管理者のリストに通知したいとします。各管理者とは、複数のチャネルを使用して連絡をとることができる場合があります。ユーザーのリストは、管理者の少なくとも1人がこの重要なメッセージを読むまで処理されます。
サンプルシナリオ
--------
このユースケースをしっかりと理解するために、サンプルの構成ファイル`sample.json`をご覧ください。
```json
{
    "APP": {
        "APP_ID": "abcd1234-8238-42d0-a03a-abcd1234...",
        "PRIVATE_KEY": "private.key"
    },
    "FROM": {
        "MESSENGER": "COMPANY MESSENGER ID",
        "VIBER": "COMPANY VIBER ID",
        "WHATSAPP": "COMPANY WHATSAPP NUMBER",
        "SMS": "COMPANY SMS NAME/NUMBER"
    },
    "USERS": [
        {
            "name": "Tony",
            "channels": [
                {
                    "type": "messenger",
                    "id_num": "USER MESSENGER ID"
                },
                {
                    "type": "sms",
                    "id_num": "USER PHONE NUMBER"
                }
            ]
        },
        {
            "name": "Michael",
            "channels": [
                {
                    "type": "viber_service_msg",
                    "id_num": "USER PHONE NUMBER"
                },
                {
                    "type": "whatsapp",
                    "id_num": "USER PHONE NUMBER"
                },
                {
                    "type": "sms",
                    "id_num": "USER PHONE NUMBER"
                }
            ]
        }
    ]
}
```
この構成ファイルの最も重要な部分は、`USERS`セクションです。ここに、ユーザーの優先順位リストがあります。この例では、アプリケーションはTonyにメッセージを送信しようとします。期限内に、Tonyのどの指定チャネルでもこのメッセージが既読にならなかった場合、この処理がMichealに対して繰り返されます。

> **注：** 期限が`600`の`read`という各チャネルのフェイルオーバー条件は、現在、アプリケーションにハードコードされていますが、構成ファイルに簡単に追加できます（この方法のコードについては、[ケース-3](https://github.com/nexmo-community/dispatch-user-fallback/tree/master/case-3)を参照してください）。
次の条件が適用されることに注意してください。
* ユーザーは2つ以上のチャネルを持つ必要があります。
* ユーザーは、チャネルが2つ以上である限り、任意の数のチャネルとタイプを混在して持つことができます。たとえば、ユーザーは3つのSMS番号とMessenger IDを持つことができます。
* ユーザーごとに指定された最後のチャネルは、最終フォールバックチャネルになります。このチャネルは、ワークフローモデルでフェイルオーバー条件に関連付けられていないため、処理方法は少し異なります。これが失敗すると、リストの次のユーザーに処理が移ります。
* 最終フォールバックチャネルはSMSである必要はありませんが、通常はそうなります。
* ワークフローはユーザー単位で作成されますが、各ユーザーに一意のワークフローを指定できます。
* 構成ファイルにリストされた順序で、ワークフローを各ユーザーに適用するよう試行されます。
* あるチャネルから次のチャネルへのフェイルオーバーは自動で行われ、Dispatch APIによって透過的に処理されます。
ソースコード
------
このプロジェクトのPythonソースコードは、[GitHubリポジトリ](https://github.com/nexmo-community/dispatch-user-fallback)コミュニティで入手できます。このコードベースには実際には3つのユースケースが含まれていますが、このチュートリアルでは`case-2`についてのみ説明します。`case-2`の具体的なコードは[こちら](https://github.com/nexmo-community/dispatch-user-fallback/tree/master/case-2)から入手できます。ファイルは、サンプル構成ファイルである`sample.json`と、アプリケーションである`app.py`の2つのみです。
準備
---
1. [Vonageアカウントを作成する](https://dashboard.nexmo.com/sign-in)
2. [Node JSをインストールする](https://nodejs.org/en/download/) - Nexmoコマンドラインインターフェース（CLI）を使用するために必要です。
3. [Nexmo CLIのベータ版をインストールする](/messages/code-snippets/install-cli)
4. [Webhookサーバーをローカルでテストする方法を知っている](/messages/code-snippets/configure-webhooks#testing-locally-via-ngrok)
5. [Python 3がインストール済みである](https://www.python.org/)
6. [Flaskがインストール済みである](http://flask.pocoo.org/)
7. サポートするチャネル（Facebook、Viber、WhatsAppなど）のアカウントを用意してください。
また、次の概要トピックが役に立ちます。
* [配信用 API](/dispatch/overview)
* [Facebook Messenger](/messages/concepts/facebook)
* [Viber](/messages/concepts/viber)
* [WhatsApp](/messages/concepts/whatsapp)
このユースケースをFacebook Messangerでテストする場合、[こちらのチュートリアル](/tutorials/fbm-product-info)を最初に行うことをお勧めします。
手順
---
前提条件を満たしていることが確認されたら、次の手順を行います。
1. [Vonageアプリケーションを作成する](#create-your-nexmo-application)
2. [Ngrokを稼働させる](#get-ngrok-up-and-running)
3. [Webhookサーバーを稼働させる](#run-your-webhook-server)
4. [アプリケーションコードを確認する](#review-the-application-code)
5. [アプリをテストする](#test-the-app)
Vonageでは、さまざまな方法で同じ結果を得ることができます。このチュートリアルでは、そうした方法のうち1つだけを示しています。たとえば、Dashboardではなく、コマンドラインを使用してアプリケーションを作成する方法です。他の方法については、他のチュートリアルで説明しています。
Vonageアプリケーションを作成する
-------------------
アプリケーションをまだ作成していない場合は、プロジェクトに新しいディレクトリ（`multi-user-dispatch`など）を作成し、このディレクトリに移動します。
CLIを使用してVonageアプリケーションを作成します。
```shell
nexmo app:create "Multi-user Dispatch App" https://abcd1234.ngrok.io/webhooks/inbound https://abcd1234.ngrok.io/webhooks/status --keyfile=private.key --type=messages
```
生成されたアプリケーションIDをメモします。またこれは、[Dashboard](https://dashboard.nexmo.com/messages/applications)で確認することもできます。
このコマンドで秘密鍵`private.key`が現在のディレクトリに作成されます。
このコマンドではまた、設定する必要がある2つのWebhookも設定されます。アプリとVonage間のすべてのやり取りは、これらのWebhookを通じて行われます。少なくとも、WebhookサーバーでこれらのWebhookの受領確認を行う必要があります。
Ngrokを稼働させる
-----------
ローカルでのテスト用にNgrokが起動していることを確認します。Ngrokを起動するには、次のように入力します。
```shell
ngrok http 9000
```
一時Ngrok URLを生成します。有料会員の場合、次のように入力できます。
```shell
ngrok http 9000 -subdomain=your_domain
```

> **注：** ここでは、NgrokはVonageアプリケーションの作成時に指定したVonage Webhookを`localhost:9000`に転用します。
Webhookサーバーを稼働させる
-----------------
Webhookが受領確認し、送信メッセージの詳細がログ記録されるようWebhookサーバーを稼働させておく必要があります。Webhookサーバーは次のようになります。
```python
from flask import Flask, request, jsonify
from pprint import pprint
app = Flask(__name__)
@app.route('/webhooks/inbound', methods=['POST'])
def inbound_message():
    print ("** inbound_message **")
    data = request.get_json()
    pprint(data)
    return ("inbound_message", 200)
@app.route('/webhooks/status', methods=['POST'])
def message_status():
    print ("** message_status **")
    data = request.get_json()
    pprint(data)
    return ("message_status", 200)
if __name__ == '__main__':
    app.run(host="localhost", port=9000)
```
このコードを`server.py`ファイルに追加して保存します。
次を使用して、このファイルをローカルで実行します。
```shell
python3 server.py
```
アプリケーションコードを確認する
----------------
便宜上、このコードは`app.py`という1つのファイルに含まれています。このファイルと、最初に`sample.json`をコピーして作成できるJSON構成ファイル、`config.json`のみがあります。
最も重要なのは、構成ファイルにはユーザーの連絡先リストが指定チャネルとともに優先順に保存されていることです。この実装では、各ユーザーには少なくとも2つのチャネルが必要ですが、ユーザーごとにその組み合わせは任意で構いません。たとえば、あるユーザーにはSMS番号が3つあり、別のユーザーはMessanger ID、Viber、さらに2つのSMS番号を持っているといったことも可能です。
各ユーザーに対してリストされた最後のチャネルは、最終フォールバックとして処理されてから、別のユーザーに切り替わります。各ユーザーに対して、各チャネルにDispatch APIを使用してメッセージが送信されます。メッセージが600秒以内に既読にならなかった場合に、 **自動的** にフェイルオーバーして次のチャネルに移ります。
アプリケーションコード`app.py`の最初の部分では単純に構成ファイルを読み取って重要な変数とデータ構造をロードします。会社は、Dispatch APIがサポートしている`messenger`、`viber_service_msg`、`whatsapp`、および`sms`の4つすべてのチャネルをサポートすることが想定されますが、ターゲットユーザーに割り当てられるのは優先チャネルのみです。たとえば、一部のユーザーの連絡手段がSMSのみという場合もあります。
一部のチャネルでは`numbers`、また一部では`ids`、Viberでは`ids`と`numbers`の両方を使用しているという状況を管理するためのヘルパー関数`set_field_types`があります。
このユースケースでの主な機能は、`build_user_workflow`関数にあります。このコードは次のようなワークフローを構築します。
```json
{
    "template": "failover",
    "workflow": [
        {
            "from": {
                "type": "messenger",
                "id": "from_messenger"
            },
            "to": {
                "type": "messenger",
                "id": "user_id_num"
            },
            "message": {
                "content": {
                    "type": "text",
                    "text": "This is a Facebook Messenger message sent using the Dispatch API"
                }
            },
            "failover": {
                "expiry_time": "600",
                "condition_status": "read"
            }
        },
        {
            "from": {
                "type": "viber_service_msg",
                "id": "from_viber"
            },
            "to": {
                "type": "viber_service_msg",
                "number": "user_id_num"
            },
            "message": {
                "content": {
                    "type": "text",
                    "text": "This is a Viber Service Message sent using the Dispatch API"
                }
            },
            "failover": {
                "expiry_time": "600",
                "condition_status": "read"
            }
        },
        {
            "from": {
                "type": "sms",
                "number": "from_sms"
            },
            "to": {
                "type": "sms",
                "number": "user_id_num"
            },
            "message": {
                "content": {
                    "type": "text",
                    "text": "This is an SMS sent using the Dispatch API"
                }
            }
        }
    ]
}
```
関数`build_user_workflow`は、構成ファイルから読み取った値がワークフローに埋め込まれているかを確認します。
`expiry_time`および`condition_status`は、`build_user_workflow`で構築されているように、ワークフローにハードコードされていることにお気づきでしょうか。これは、コードをできる限りシンプルに保つために行ったことですが、これらのパラメーターを、チャネル単位で構成ファイルに追加することもできます。この場合、一部のユーザーは一部のチャネルで期限を300秒にしたり、チャネル単位で`read`や`delivered`のフェイルオーバー条件を指定したりすることができます。これは[ケース-3](https://github.com/nexmo-community/dispatch-user-fallback/tree/master/case-3)で実装済みですが、すべてのコードが修正されたサンプル構成ファイルとともに提供されているため、このチュートリアルでは詳しく説明しません。
ワークフローが構築されたら、[Dispatch API](/dispatch/overview)を使用してメッセージを送信します。
```python
r = requests.post('https://api.nexmo.com/v0.1/dispatch', headers=headers, data=workflow)
```
JWTがAPI呼び出しの認証のために生成されます。このため、Vonageアプリケーションの作成時に`app_id`と`private_key`の値をメモしておき、この値を構成ファイルに追加する必要があります。
アプリをテストする
---------
`sample.json`を`config.json`にコピーします。
`app_id`、`private_key`、サポートされているそれぞれのチャネルの詳細などのパラメーターの適切な値を`config.json`に設定したことを確認します。テスト方法に従って、ユーザーリストを構成していることを確認します。

> **ヒント：** ここで、[JSON linter](https://jsonlint.com/)を使用して変更した構成ファイルを検証するとよいでしょう。
その後、次のようにしてアプリを実行します。
```shell
python3 app.py
```
アプリケーションで構成ファイルが処理され、メッセージが既読になるまで各ユーザーに順番に連絡します。
### SMS
このチュートリアルでは、SMSを受信できる任意の携帯電話を使用してテストすることができます。
### Facebook Messenger
Facebook Messangerでテストするには、さらにいくつかの手順を行う必要があります。その手順については、[こちらのチュートリアル](/tutorials/fbm-product-info)で詳しく説明しているため、ここでは繰り返しません。
### Viber
このチュートリアルでViberを使用してテストするには、Viber Service Message IDが必要です。
### WhatsApp
このチュートリアルでWhatsAppを使用してテストするには、WhatsAppビジネスアカウントが必要です。また、ターゲットユーザーにMTMを送信しないと、会社からのメッセージが受信できるようになりません。
まとめ
---
このチュートリアルでは、複数のチャネルを持つユーザーのリストにメッセージの送信を試みるユースケースについて説明しました。アプリケーションは、メッセージが既読になると終了します。
その他のリソース

---

* [完全なソースコード](https://github.com/nexmo-community/dispatch-user-fallback)。
* [Dispatch APIのドキュメント](/dispatch/overview)
* [WhatsApp MTMの送信](/messages/code-snippets/send-whatsapp-template)

