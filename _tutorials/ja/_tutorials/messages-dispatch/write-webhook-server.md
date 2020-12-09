---
title:  メッセージWebhookサーバーを作成する
description:  Webhookサーバーで着信メッセージを受信する

---

このコードスニペットでは、着信メッセージの処理方法を学習します。

> **注：** メッセージ用APIは、アプリケーション固有のWebhookを介した着信SMSメッセージおよびSMS受信確認コールバックをサポートしていません。SMSメッセージとSMS受信確認のコールバックを受信するには、[SMS用のアカウントレベルのWebhook](https://dashboard.nexmo.com/settings)を設定する必要があります。

例
---

着信メッセージのDashboardで[Webhookが設定](/tasks/olympus/configure-webhooks)されていることを確認します。不要なコールバックキューイングを避けるために、最低でも、ハンドラはステータスコード200を返さなければなりません。メッセージ用アプリケーションをテストする前に、Webhookサーバーが実行されていることを確認してください。

```code_snippets
source: '_examples/messages/webhook-server'
```

