---
title:  メッセージWebhookサーバーのテスト
description:  ローカルのWebhookサーバーをインターネットに公開する

---

アプリケーションをローカルでテストする場合は、Ngrokを使用できます。

[ローカル開発のためのNgrokの使用](/tools/ngrok)に関する情報を参照してください

この方法でNgrokを使用する場合は、Webhook URLにNgrok URLを使用します：

* `https://abcdef1.ngrok.io/webhooks/inbound-message`
* `https://abcdef1.ngrok.io/webhooks/message-status`

