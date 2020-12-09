---
title:  Webhookを設定する方法を学びましょう
description:  選択したチャネルからメッセージを受信するようにWebhookを設定する方法を学びます

---

設定する必要があるWebhookは少なくとも2つあります：

* メッセージステータスWebhook
* 着信メッセージWebhook

`delivered`、`rejected`、`accepted`など、メッセージステータスの更新が生成されると、コールバックは *メッセージステータス* WebhookURLで受信されます。

着信メッセージを受信すると、 *着信メッセージ* Webhook URLでメッセージペイロード付きのコールバックが呼び出されます。

> **重要：** 両方のWebhook URLを設定する必要があります。少なくとも、Webhookハンドラは、着信メッセージとメッセージステータスの両方のコールバックに対して200応答を返す必要があります。

### Webhook URLを設定するには

[Dashboard](https://dashboard.nexmo.com)で、[[Messages and Dispatch（メッセージと配信)]](https://dashboard.nexmo.com/messages/create-application)に移動します。

> **ヒント：** VonageアカウントのメッセージのWebhook URLがすでに本番で使用されていて、メッセージ用APIを使用するための2つ目のURLを希望する場合は、[support@nexmo.com](mailto:support@nexmo.com)にメールを送信し、サブAPI Keyを要求してください。

**[Status URL (ステータスURL)]** と **[Inbound URL (着信URL)]** のフィールドに、Webhook URLを入力します。

Webhook URLに入力する値は、Webhookサーバーの配置場所によって異なります、次に例を示します：

| Webhook  |                        URL                         |
|----------|----------------------------------------------------|
| ステータスURL | `https://www.example.com/webhooks/message-status`  |
| 着信URL    | `https://www.example.com/webhooks/inbound-message` |

> **注：** `POST`のデフォルトのメソッドは、両方のWebhook URLに使用する必要があります。

### 着信SMS Webhook

メッセージ用APIは、前のセクションで説明したアプリケーション固有のWebhookを介した着信SMSメッセージおよびSMS受信確認のコールバックをサポートしていません。SMSメッセージおよびSMS受信確認のコールバックを受信するには、[SMS用のアカウントレベルのWebhook](https://dashboard.nexmo.com/settings)を設定する必要があります。

### Webhookキュー

Vonageから発せられるWebhook（メッセージステータスWebhook URLや着信メッセージURLなど）は、メッセージごとにVonageによってキューに入れられます。

すべてのアプリケーションが200応答でWebhookを認識するようにしてください。

### 署名付きWebhook

Webhookの送信元を検証するには、Webhookの署名を検証できます、[こちら](https://developer.nexmo.com/messages/concepts/signed-webhooks)の説明を参照してください

