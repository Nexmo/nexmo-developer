---
title:  メッセージ用APIを使用した複数のチャネルへのリアルタイムデータフィード

products: messages

description:  このチュートリアルでは、ユーザーが自分のチャネルにリアルタイムデータを受信するユースケースについて説明します。サポートされているチャネルは、Facebook Messenger、WhatsApp、Viber、SMSです。

languages:
  - Python
*** ** * ** ***
メッセージ用APIを使用した複数のチャネルへのリアルタイムデータフィード
====================================
このチュートリアルでは、メッセージ用APIを使用して、リアルタイムで複数のチャネルにデータをフィードする方法について説明します。このチュートリアルでは、サポートされているすべてのチャネルにデータを送信する方法を示します。すべてのチャネルのテストに関する情報が提供されます。Facebook Messengerを使用したテストに関心がある場合は、まず[このチュートリアル](/tutorials/fbm-product-info)を実施することをお勧めします。このチュートリアルには、Facebook固有のさまざまな情報が含まれています。WhatsAppとViberをテストするには、各プロバイダーのビジネスアカウントが必要です。
サンプルシナリオ
--------
このチュートリアルでは、選択したチャネルのユーザーにリアルタイムの株価を送信する方法について説明します。ユーザーは、サポートされている任意のチャネルでデータを受信するように登録することができます。たとえば、SMSを使用して、またはFacebook Messengerを介して、携帯電話で株価を受け取ることができます。WhatsAppとViberもサポートされています。Facebook Messenger、WhatsApp、およびSMSユーザーは、興味のある特定の株式を登録することができます。ただし、Viberは企業への着信メッセージをサポートしていないため、ユーザーはデータを受信するために、Webサイト経由でメッセージを受信するように登録する必要があります。また、WhatsAppには、ユーザーがメッセージの受信に同意する前に、企業がユーザーに[MTM](/messages/code-snippets/send-whatsapp-template)を送信する必要があるという複雑な問題もあります。

> このチュートリアルでは、シミュレートされた株価のみが使用されることに注意してください。
ソースコード
------
このプロジェクトのPythonソースコードは、Vonageコミュニティの[GitHubリポジトリ](https://github.com/nexmo-community/messages-api-real-time-feed)で入手できます。特に興味深いのは、単一のメソッド呼び出しで、サポートされている任意のチャネルにメッセージを送信する便利な方法を提供する、汎用クライアントです。また、WhatsApp、SMS、Messengerで着信メッセージを処理するPythonコードも表示されます。
準備
---
1. [Vonageアカウントを作成する](https://dashboard.nexmo.com/sign-in)
2. [Node JSのインストール](https://nodejs.org/en/download/) - Nexmoコマンドラインインターフェース（CLI）を使用するために必要です。
3. [Nexmo CLIのベータ版をインストールする](/messages/code-snippets/install-cli)
4. [Webhookサーバーをローカルでテストする方法を知っている](/messages/code-snippets/configure-webhooks#testing-locally-via-ngrok)
5. [Python 3がインストール済みである](https://www.python.org/)
6. [Flaskがインストール済みである](http://flask.pocoo.org/)
7. サポートするチャネル（Facebook、Viber、WhatsAppなど）のアカウントを用意してください。
また、次の概要トピックが役に立ちます。
* [Facebook Messenger](/messages/concepts/facebook)
* [Viber](/messages/concepts/viber)
* [WhatsApp](/messages/concepts/whatsapp)
このユースケースをFacebook Messangerでテストする場合、[こちらのチュートリアル](/tutorials/fbm-product-info)を最初に行うことをお勧めします。
手順
---
前提条件を満たしていることが確認されたら、次の手順を行います。
1. [Vonageアプリケーションを作成する](#create-your-nexmo-application)
2. [Ngrokを稼働させる](#get-ngrok-up-and-running)
3. [ダッシュボードでSMS Webhookを設定する](#set-your-sms-webhooks-in-dashboard)
4. [基本的なアプリケーションを記述する](#write-your-basic-application)
5. [SMSで送信する](#send-in-an-sms)
6. [汎用クライアントコードを確認する](#generic-client)
7. [ユースケースの再確認](#the-use-case-revisited)
8. [アプリのテスト](#testing-the-app)
Vonageでは、さまざまな方法で同じ結果を得ることができます。このチュートリアルでは、そうした方法のうち1つだけを示します。たとえば、Dashboardではなくコマンドラインを使用してアプリケーションを作成する方法を説明します。他の方法については、他のチュートリアルで説明します。
Vonageアプリケーションを作成する
-------------------
アプリケーションをまだ作成していない場合は、プロジェクトに新しいディレクトリ（`real-time-app`など）を作成し、このディレクトリに移動します。
CLIを使用してVonageアプリケーションを作成します。
```shell
nexmo app:create "Real-time App" https://abcd1234.ngrok.io/webhooks/inbound https://abcd1234.ngrok.io/webhooks/status --keyfile=private.key --type=messages
```
生成されたアプリケーションIDをメモします。またこれは、[Dashboard](https://dashboard.nexmo.com/messages/applications)で確認することもできます。
このコマンドで、秘密鍵`private.key`が現在のディレクトリに作成されます。
このコマンドではまた、設定する必要がある2つのWebhookも設定されます。アプリとVonage間のすべてのやり取りは、これらのWebhookを通じて行われます。少なくとも、アプリでこれらのWebhookの受領確認を行う必要があります。
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

> ここでは、NgrokはVonageアプリケーションの作成時に指定したVonage Webhookを`localhost:9000`に転用します。
ダッシュボードでSMS Webhookを設定する
------------------------
Dashboardで[アカウント設定](https://dashboard.nexmo.com/settings)に進みます。ここでは、アカウントレベルのSMS Webhookを設定することができます。
| Webhook |                                                      URL                                                       |
|---------|----------------------------------------------------------------------------------------------------------------|
| 受信確認    | [https://abcd1234\.ngrok.io/webhooks/delivery-receipt](https://abcd1234.ngrok.io/webhooks/delivery-receipt) |
| 着信 SMS  | [https://abcd1234\.ngrok.io/webhooks/inbound-sms](https://abcd1234.ngrok.io/webhooks/inbound-sms)           |
Webhook URLの「abcd1234」を独自の情報に置き換える必要があることに注意してください。有料のNgrokアカウントをお持ちの場合は、それをカスタムドメインにできます。

> **注：** メッセージと配信アプリケーションは現在、発信SMSのみをサポートしており、着信SMSはサポートされていないため、この手順を実行する必要があります。このため、アカウントレベルのSMS Webhookを使用して着信SMSをサポートしますが、発信SMSを送信するには、メッセージ用APIを使用します。
基本的なアプリケーションを記述する
-----------------
最も単純なケースでは、アプリケーションは着信メッセージ情報、受信確認、およびメッセージステータスデータをログアウトします。これは次のようになります。
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
@app.route('/webhooks/inbound-sms', methods=['POST'])
def inbound_sms():
    print ("** inbound_sms **")
    values = request.values
    pprint(values)
    return ("inbound_sms", 200)
@app.route('/webhooks/delivery-receipt', methods=['POST'])
def delivery_receipt():
    print ("** delivery_receipt **")
    data = request.get_json()
    pprint(data)
    return ("delivery_receipt", 200)
if __name__ == '__main__':
    app.run(host="localhost", port=9000)
```
このコードを`app1.py`ファイルに追加して保存します。
次を使用して、このファイルをローカルで実行します。
```shell
python3 app1.py
```
SMSで送信する
--------
基本のアプリケーションが起動し、イベントをログに記録する準備が整いました。この基本のアプリケーションをテストするには、Voiceアプリにリンクされている任意のVonage番号（Vonage番号には音声とSMS機能があります）にSMSを送信します。音声アプリケーションがなく、作成方法が分からない場合は、[この情報](/application/code-snippets/create-application)を確認できます。この追加手順を実行する理由は、メッセージと配信APIが現在、着信SMSをサポートしておらず、発信SMSのみをサポートしているため、アカウントレベルのWebhookを使用して着信SMSを受信する必要があるためです。
SMSで送信したときに生成されるトレース情報を調べると、次のような内容が表示されます。
    ** inbound_sms **
    {'keyword': 'MESSAGE',
     'message-timestamp': '2019-04-16 13:55:21',
     'messageId': '1700000240EAA6B6',
     'msisdn': '447700000001',
     'text': 'Message from Tony',
     'to': '447520635498',
     'type': 'text'}
汎用クライアント
--------
現在、VonageではPython Server SDKでのメッセージおよび配信用APIは正式にサポートしていませんが、VonageのREST APIはサポートしており（ベータ版）、[Pythonコードはプロジェクトで再利用可能なクラスとして提供](https://github.com/nexmo-community/messages-api-real-time-feed/blob/master/Client/Client.py)されています。このクラスでは、メッセージ用APIを使用して、サポートされているチャネルのいずれかにメッセージを送信できます。このコードは、簡単に見てみる価値があります。
```python
    def send_message (self, channel_type, sender, recipient, msg):
        if channel_type == 'messenger':
            from_field = "id"
            to_field = "id"
        elif channel_type == 'whatsapp' or channel_type == "sms": 
            from_field = "number"
            to_field = "number"
        elif channel_type == 'viber_service_msg':
            from_field = "id"
            to_field = "number"
               
        data_body = json.dumps({
            "from": {
	        "type": channel_type,
	        from_field: sender
            },
            "to": {
	        "type": channel_type,
	        to_field: recipient
            },
            "message": {
	        "content": {
	            "type": "text",
	            "text": msg
	        }
            }
        })
...
```
本文は、チャネルタイプに基づいて構築されます。これは、チャネル間で細部が若干異なるためです。たとえば、FacebookはIDを使用しますが、WhatsAppとSMSは番号のみを使用します。ViberはIDと番号を使用します。次に、コードはメッセージ用APIを使用してメッセージを送信します。これはユースケースの基本であり、ユーザーのサインアップを許可するために数ビットが追加されます。
ユースケースの再確認
----------
では、このユースケースをさらに詳しく確認し、アプリケーションをより効果的に構築できるようにしましょう。
着信メッセージをサポートするチャネル（Messenger、WhatsApp、SMS）の場合、ユーザーがサインアップするためにメッセージを送信することを許可できます。Viberの場合、これはWebアプリの別の部分から行う必要があります。通常は、ユーザーがリアルタイムフィードにサインアップできるフォームを提供します。
ユーザーが「こんにちは」などの着信メッセージを送信すると、アプリはヘルプメッセージで応答します。私たちの単純なケースでは、これは [Send us a message with MSFT or GOOGL in it for real-time data (リアルタイムデータ用に、MSFTまたはGOOGLでメッセージを送信してください)] です。このサインアップは、購読したフィードを確認する別のメッセージによって確認されます。
その後、選択した銘柄のリアルタイム価格を受け取ります。別のチャネルに追加でサインアップしたい場合は、自由にサインアップできます。また、銘柄を変更する場合は、単に新しい銘柄をメッセージで送信すると、それが承認され、それに応じてデータストリームが変更されます。
これを実装するためのコアコードは、`app_funcs.py`の`proc_inbound_msg`関数にあります。
WhatsAppの場合は、ユーザーがサインアップしてデータを受信するには、ユーザーに[MTMメッセージ](/messages/code-snippets/send-whatsapp-template)を送信する必要があります。わかりやすくするために、これは[別のコード](https://github.com/nexmo-community/messages-api-real-time-feed/blob/master/send_whatsapp_mtm.py)として提供されます。
アプリのテスト
-------
次のようにしてアプリを実行します。
```shell
python3 app.py APP_ID
```
メッセージアプリケーションのVonageアプリケーションIDは、`APP_ID`です。
### SMS
SMSでテストするには、以前と同じようにSMSを送信するだけです。ヘルプメッセージを受信します。`MSFT`または`GOOGL`のいずれかの銘柄をメッセージで返信します。これで、定期的に（シミュレートされた）価格更新を受け取ります。現在、これらを受け取らないようにするにはアプリを終了する必要がありますが、[このチュートリアル](/tutorials/fbm-product-info)で行ったように、これらのメッセージをオフにする機能を簡単に追加できます。
### Facebook Messenger
Facebook Messangerでテストするには、さらにいくつかの手順を行う必要があります。その手順については、[こちらのチュートリアル](/tutorials/fbm-product-info)で詳しく説明しているため、ここでは繰り返しません。
### Viber
これをテストするには、有効なViberのビジネスアカウントが必要です。ユーザーが[自分の電話番号と興味のある銘柄を入力](https://github.com/nexmo-community/messages-api-real-time-feed/blob/master/app_funcs.py#L21-L29)するように要求するWebアプリケーションがあるとします。ユーザーは、最初のメッセージを受信しますが、このメッセージはユーザーが受信することも拒否することもできます。Viberで汎用クライアントをテストする方法を示すための[小さなテストプログラム](https://github.com/nexmo-community/messages-api-real-time-feed/blob/master/test-viber.py)が用意されています。
### WhatsApp
WhatsAppのテストを完全に実施するには、追加の手順が必要です。ユーザーがメッセージを受信するには、ユーザーにWhatsApp MTM（テンプレート）を送信する必要があります。このためのコードはこのチュートリアルでは説明されていませんが、[ここから](https://github.com/nexmo-community/messages-api-real-time-feed/blob/master/send_whatsapp_mtm.py)サンプルコードを入手できます。これで、このチュートリアルで提供される汎用クライアントを使用して、後続のWhatsAppメッセージを送信することができます。
まとめ
---
このチュートリアルでは、ユーザーがメッセージ用APIでサポートされている任意のチャネルでリアルタイムデータを受信できるユースケースを見てきました。
その他のリソース

---

* [完全なソースコード](https://github.com/nexmo-community/messages-api-real-time-feed)。
* [メッセージ用APIのドキュメント](/messages/overview)
* [WhatsApp MTMの送信](/messages/code-snippets/send-whatsapp-template)

