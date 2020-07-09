---
title:  受信確認
description:  SMS 受領確認の取得方法
navigation_weight:  4

---


受信確認
====

通信会社に[受信確認](/messaging/sms/guides/delivery-receipts)をリクエストすることにより、Nexmo の SMS 用 API を使って送信したメッセージが顧客に届いたことを確認できます。

> **注:** ネットワークや国によっては受信確認を利用できない場合があります。ネットワークが受信確認に対応しない場合の[代替確認ツール](https://help.nexmo.com/hc/en-us/articles/204014863)に関する詳しい情報は、当社ナレッジベースをご覧ください。受信確認の詳細については、当社[ドキュメント](/messaging/sms/guides/delivery-receipts)を参照してください。

受信確認にアクセスする要件は以下のとおりです。

* 以下のサンプルコードのいずれかを使って [Web フックエンドポイント](/messaging/sms/code-snippets/before-you-begin#webhooks)を作成します
* [Nexmo Dashboard で Web フックエンドポイントを設定します](#configure-the-webhook-endpoint-in-your-nexmo-dashboard)

> **注:** メッセージの送信後に受信確認を受け取るまでタイムラグがある場合があります。

```code_snippets
source: '_examples/messaging/sms/delivery-receipts'
```

Nexmo Dashboard で Web フックエンドポイントを設定します
--------------------------------------

Nexmo が Web フックにアクセスできるようにするには、Nexmo アカウントでアクセス方法を設定する必要があります。

Web フックはコードスニペットの `/webhooks/delivery-receipt` にあります。Ngrok を使用している場合、[Nexmo Dashboard の API 設定ページ](https://dashboard.nexmo.com/settings)で設定が必要な Web フックは「`https://demo.ngrok.io/webhooks/delivery-receipt`」フォームを取ります。「`demo`」部分を Ngrok から提供されるサブドメインに置き換えて、 **受信確認用 Web フックの URL** というラベルが付いたフィールドにエンドポイントを入力します。

```screenshot
script: app/screenshots/webhook-url-for-delivery-receipt.js
image: public/meta/screenshots/smsDLRsettings.png
```

試行手順
----

携帯電話番号に[メッセージを送信](send-an-sms)すると、ネットワークがサポートしている場合は、次の形式で受信確認を受領します。

```json
{
  "err-code": "0",
  "message-timestamp": "2020-10-25 12:10:29",
  "messageId": "0B00000127FDBC63",
  "msisdn": "447700900000",
  "network-code": "23410",
  "price": "0.03330000",
  "scts": "1810251310",
  "status": "delivered",
  "to": "Nexmo CLI"
}
```

> **注:** メッセージの送信後に受信確認を受け取るまでタイムラグがある場合があります。

補足情報
----

* [SMS 受領確認ドキュメント](/messaging/sms/guides/delivery-receipts)

