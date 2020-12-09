---
title:  Facebook Messangerを介した製品情報の自動受信

products: messages

description:  このチュートリアルでは、ユーザーがFacebook Messangerを介して、サポート要員を必要とせずに、関連する製品情報を自動的に受け取るユースケースを見ていきます。

languages:
  - Python


---

Facebook Messangerを介した製品情報の自動受信
===============================

このチュートリアルでは、ユーザーにFacebook Messangerを介して関連する製品情報を自動的に提供する方法について説明します。

このユースケースでは、ユーザーは、会社のFacebookページを介して会社とコンタクトをとります。メッセージは自動的にユーザーに返信されます。キーワードマッチングを使用して、ユーザーはカスタマイズされた製品やサービスの情報を受け取ることができます。

> **注：** このチュートリアルでは、FacebookのプロフィールやFacebookページを作成済みであるものとします。

ソースコード
------

このプロジェクトのソースコードは、[GitHubリポジトリ](https://github.com/nexmo-community/fbm-product-info)コミュニティで入手できます。

準備
---

1. [Vonageアカウントを作成する](https://dashboard.nexmo.com/sign-in)
2. [Node JSをインストールする](https://nodejs.org/en/download/) - Nexmoコマンドラインインターフェース（CLI）を使用するために必要です。
3. [Nexmo CLIのベータ版をインストールする](/messages/code-snippets/install-cli)
4. [Webhookサーバーをローカルでテストする方法を知っている](/messages/code-snippets/configure-webhooks#testing-locally-via-ngrok)
5. [Python 3がインストール済みである](https://www.python.org/)
6. [Flaskがインストール済みである](http://flask.pocoo.org/)

手順
---

前提条件を満たしていることが確認されたら、次の手順を行います。

1. [Vonageアプリケーションを作成する](#create-your-nexmo-application)
2. [VonageアプリケーションとFacebookページをリンクする](#link-your-application-to-your-facebook-page)
3. [Ngrokを稼働させる](#get-ngrok-up-and-running)
4. [基本的なアプリケーションを記述する](#write-your-basic-application)
5. [Facebookページとやり取りする](#interact-with-your-facebook-page)
6. [Pythonを使用してFacebook Messangerメッセージを送信するための最低限のクライアント](#minimal-client-for-sending-facebook-messenger-messages-using-python)
7. [ユースケースの再確認](#the-use-case-revisited)
8. [シンプルな実装](#a-simple-implementation)

Vonageでは、さまざまな方法で同じ結果を得ることができます。このチュートリアルでは、そうした方法のうち1つだけを示しています。たとえば、Dashboardではなく、コマンドラインを使用してアプリケーションを作成する方法です。他の方法については、他のチュートリアルで説明しています。

Vonageアプリケーションを作成する
-------------------

アプリケーションをまだ作成していない場合は、プロジェクトに新しいディレクトリ（`fbm-app`など）を作成し、このディレクトリに移動します。

CLIを使用してVonageアプリケーションを作成します。

```shell
nexmo app:create "FBM App" https://abcd1234.ngrok.io/inbound https://abcd1234.ngrok.io/status --keyfile=private.key --type=messages
```

生成されたアプリケーションIDをメモします。またこれは、[Dashboard](https://dashboard.nexmo.com/messages/applications)で確認することもできます。

このコマンドで秘密鍵`private.key`が現在のディレクトリに作成されます。

このコマンドではまた、設定する必要がある2つのWebhookも設定されます。アプリとVonage間のすべてのやり取りは、これらのWebhookを通じて行われます。少なくとも、アプリでこれらのWebhookの受領確認を行う必要があります。

アプリケーションとFacebookページをリンクする
--------------------------

```partial
source: _partials/reusable/link-facebook-to-nexmo.md
```

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

基本的なアプリケーションを記述する
-----------------

最もシンプルなケースでは、アプリケーションは次のようになります。

```python
from flask import Flask, request, jsonify
from pprint import pprint

app = Flask(__name__)

@app.route('/inbound', methods=['POST'])
def inbound_message():
    data = request.get_json()
    pprint(data)
    return ("200")

@app.route('/status', methods=['POST'])
def message_status():
    data = request.get_json()
    pprint(data)
    return ("200")

if __name__ == '__main__':
    app.run(host="localhost", port=9000)
```

このコードを`app1.py`ファイルに追加して保存します。

次を使用して、このファイルをローカルで実行します。

```shell
python3 app1.py
```

基本のアプリケーションが起動し、イベントをログに記録する準備が整いました。

Facebookページとやり取りする
------------------

これで、基本のアプリが起動し、Facebookページにメッセージを送信してメッセージがログに記録されていることを確認することができるようになりました。ですから、Messangerを使用してFacebookページに基本的なメッセージを送信すると、次のようにログ記録されます。

    {'direction': 'inbound',
     'from': {'id': '1234567890123456', 'type': 'messenger'},
     'message': {'content': {'text': 'Hello Mr. Cat', 'type': 'text'}},
     'message_uuid': 'da13a7b0-307c-4029-bbcd-ec2a391873de',
     'timestamp': '2019-04-09T12:26:47.242Z',
     'to': {'id': '543210987654321', 'type': 'messenger'}}
    127.0.0.1 - - [09/Apr/2019 13:26:58] "POST /inbound HTTP/1.1" 200 -

より便利なアプリケーションを構築するために役立つ、重要な情報をいくつかご紹介します。

|   フィールド   |                     説明                      |
|-----------|---------------------------------------------|
| `from`    | Facebookページ宛てにメッセージを送信してきた人物のFacebook IDです。 |
| `to`      | ページ（メッセージの送信先のページ）のFacebook IDです。           |
| `message` | 送信されるメッセージです。                               |

メッセージはJSONオブジェクトであることが分かります。メッセージテキストをこのオブジェクトから抽出できます。

ページのFacebook ID（知らない場合もあります）とメッセージを送信してきたユーザーのFacebook IDの両方を記録しておくと便利です。Facebook IDは、アプリケーションで複数のFacebookページを処理している場合に特に役立ちます。

Pythonを使用してFacebook Messangerメッセージを送信するための最低限のクライアント
----------------------------------------------------

現在、VonageではPython Server SDKでのメッセージおよびDispatch APIは正式にサポートしていませんが、VonageのREST APIは完全にサポートされており、[Pythonコードは再利用可能なクラスとしてプロジェクトで提供](https://github.com/nexmo-community/fbm-product-info/blob/master/FBMClient/FBMClient.py)されています。コードが提供されているため、このチュートリアルでは詳しく説明しません。

ユースケースの再確認
----------

では、このユースケースをさらに詳しく確認し、アプリケーションをより効果的に構築できるようにしましょう。

ユーザーが、Messangerを介してFacebookページに「こんにちは」というようなメッセージを送ってきたとしましょう。しかし、タイムゾーンの違いにより、このメッセージに返信することができません。そうすると、送信したユーザーはがっかりするでしょう。ですが、もし有用な情報を自動的に返信することができるのなら、それに超したことはありません。たとえば、「こんにちは」というようなメッセージに対して「T's Cat Suppliesへようこそ。当社では、おもちゃ、食品、薬、アクセサリーを扱っています」といったメッセージを返信できます。

`if keyword in msg`などのPython構造を使用すると、キーワードを検出し、それに基づいて情報を送信できます。たとえば、ユーザーが「タンクの整理が必要です」というようなメッセージを送ってきたとします。その場合、`tank`という単語を検出して、タンク清掃サービスに関する情報が送信されます。あるいは、「パイプラインをつり上げるためにクレーンが必要です」というメッセージを受け取った場合は、クレーンレンタルサービスの情報を送信できます。キーワードが検出されない場合は、ユーザーに一般的なメッセージを返信し、ユーザーの方向性を明らかにすることができます。

この自動応答機能は、会社に何百もの製品やサービスがある場合に便利です。

もう1つの便利なのが、直接やり取りするために自動応答をオフにする機能です。`auto: off`や`auto: on`などのコマンドを組み込んで、顧客がFacebookページとやり取りする方法を制御できます。

以降のセクションで、このユースケースの実装方法を説明します。

シンプルな実装
-------

このユースケースを実装する際に役立つデータ構造が、Pythonディクショナリです。以下がその例です。

```python
cats_dict = {
    'other': 'Our products: toys, food, meds, and bling',
    'toys': 'More info on cat toys here https://bit.ly/abc',
    'food': 'More info on cat food here https://bit.ly/def',
    'meds': 'More info on cat meds here https://bit.ly/ghi',
    'bling': 'More info on cat bling here https://bit.ly/jkl'
}
```

全体を把握できるよう、次のコードを確認しましょう。

```python
class ProductMatcher:

    auto_mode = True

    cats_dict = {
        'other': 'Our products: toys, food, meds, and bling',
        'toys': 'More info on cat toys here https://bit.ly/abc',
        'food': 'More info on cat food here https://bit.ly/def',
        'meds': 'More info on cat meds here https://bit.ly/ghi',
        'bling': 'More info on cat bling here https://bit.ly/jkl'
    }

...

    def product_matcher(self, fb_sender, user, msg):
        product = 'other'
        msg = msg.lower().strip()
        if self.auto_mode:
            if "auto: off" in msg:
                self.auto_mode = False
                self.fbm.send_message(fb_sender, user, "Auto mode is off")
                return
            for k in self.cats_dict.keys():
                if k in msg:
                    product = k
                    break
            self.fbm.send_message(fb_sender, user, self.cats_dict[product])
        if "auto: on" in msg:
                self.auto_mode = True
                self.fbm.send_message(fb_sender, user, "Auto mode is on")
        return product
```

ユーザーがMessanger経由でメッセージを送信し、返信する担当者が不在の場合、ユーザーには簡単なメニューが返送されます。ユーザーのメッセージから製品名が抽出され、適切なメッセージが送信されます。もちろん、このコードは単純なアプローチ方法ですが、うまくいけば可能性が広がります。

この方法では、担当者と直接やり取りしたいと考えているユーザーは苛立つのではないかと思うかもしれませんが、自動応答は、担当者がオンラインになってメッセージを受け取ることができるようになったら無効にできます。このコードでは、ユーザーは`auto: off`コマンドと`auto: on`コマンドを使用してやり取りを制御できます。また、チャネルマネージャーからも制御できます。

上記のコードでは、ユーザーが興味を持っている製品も返されます。これは、ユーザーとユーザーが選択した製品をデータベースに記録したい場合などに使用できます。また、データベースのユーザーを検索して、新規顧客なのか、以前に会社と取引があった顧客なのかを確認することができます。

まとめ
---

このチュートリアルでは、Facebook Messangerを介してユーザーが自動的に製品情報を取得できるユースケースについて見てきました。これは、単純なキーワードマッチングに基づく方法でした。また、ユーザーは必要に応じて自動応答モードを切り替えることもできました。

その他のリソース
--------

* 完全な[ソースコード](https://github.com/nexmo-community/fbm-product-info)。
* Messages APIの[ドキュメント](/messages/overview)

