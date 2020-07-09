---
title:  SMS を受信
navigation_weight:  5

---


SMS の受信
=======

SMS を受信する要件は以下のとおりです。

* メッセージを受信する[仮想番号をレンタル](/numbers/guides/number-management#rent-a-virtual-number)します
* 以下のサンプルコードのいずれかを使って [Web フックエンドポイント](/messaging/sms/code-snippets/before-you-begin#webhooks)を作成します
* [Nexmo Dashboard で Web フックを設定します](#configure-the-webhook-endpoint-in-your-nexmo-dashboard)

```code_snippets
source: '_examples/messaging/sms/receiving-an-sms'
```

Nexmo Dashboard で Web フックエンドポイントを設定します
--------------------------------------

Nexmo が Web フックにアクセスできるようにするには、Nexmo アカウントでアクセス方法を設定する必要があります。

Web フックはコードスニペットの `/webhooks/inbound-sms` にあります。Ngrok を使用している場合、[Nexmo Dashboard の API 設定ページ](https://dashboard.nexmo.com/settings)で設定が必要な Web フックは「`https://demo.ngrok.io/webhooks/inbound-sms`」フォームを取ります。「`demo`」部分を Ngrok から提供されるサブドメインに置き換えて、 **着信メッセージ用 Web フックの URL** というラベルが付いたフィールドにエンドポイントを入力します。

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/meta/screenshots/smsInboundWebhook.png
```

試行手順
----

上記準備を完了して Nexmo の番号を SMS に送信すると、その番号はコンソールに記録されるようになります。メッセージオブジェクトには次のプロパティが含まれます。

```json
{
  "msisdn": "447700900001",
  "to": "447700900000",
  "messageId": "0A0000000123ABCD1",
  "text": "Hello world",
  "type": "text",
  "keyword": "Hello",
  "message-timestamp": "2020-01-01T12:00:00.000+00:00",
  "timestamp": "1578787200",
  "nonce": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "concat": "true",
  "concat-ref": "1",
  "concat-total": "3",
  "concat-part": "2",
  "data": "abc123",
  "udh": "abc123"
}
```

