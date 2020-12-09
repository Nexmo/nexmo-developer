---
title:  メッセージと配信アプリケーションの作成
description:  このステップでは、メッセージと配信アプリケーションの作成方法を学習します。メッセージと配信アプリケーションには、メッセージステータスWebhookと着信メッセージWebhookがあり、着信メッセージのタイプは`whatsapp`、`messenger`、または`viber_service_msg`です。着信SMSは、アカウントレベルのSMS Webhookを介して処理する必要があります。
meta_title:  Vonage APIのメッセージと配信アプリケーションを作成する
meta_description:  メッセージと配信アプリケーションには、メッセージステータスWebhookと着信メッセージWebhookがあり、着信メッセージのタイプは`whatsapp`、`messenger`または`viber_service_msg`です。着信SMSは、アカウントレベルのSMS Webhookを介して処理する必要があります。

---

アプリケーションを作成する
-------------

メッセージと配信アプリケーションを作成するには、次の2つの方法があります：

1. Nexmo CLI を使用する
2. Dashboardを使用する

これらの各方法については、以降のセクションで説明します。

### Nexmo CLIを使用してメッセージと配信アプリケーションを作成する方法

Nexmo CLIを使用してアプリケーションを作成するには、シェルに次のコマンドを入力します：

```shell
nexmo app:create "My Messages App" --capabilities=messages --messages-inbound-url=https://example.com/webhooks/inbound-message --messages-status-url=https://example.com/webhooks/message-status --keyfile=private.key
```

これにより、指定どおりに設定されたWebhook URLを使用して、メッセージ[機能](/application/overview#capabilities)を持つVonageアプリケーションが作成され、秘密キーファイル`private.key`が生成されます。

### Dashboardを使用してメッセージと配信アプリケーションを作成する方法

[Dashboard](https://dashboard.nexmo.com/applications)でメッセージと配信アプリケーションを作成できます。

Dashboardを使用してアプリケーションを作成するには、次の手順に従います：

1. Dashboardの[アプリケーション](https://dashboard.nexmo.com/applications)で、 **[Create a new application (新しいアプリケーションの作成)]** ボタンをクリックします。

2. **[Name (名前)]** に、アプリケーション名を入力します。後で参照しやすくするために、名前を選択してください。

3. **[Generate public and private key (公開鍵と秘密鍵を生成)]** ボタンをクリックします。これにより、公開鍵と秘密鍵のペアが作成され、秘密鍵がブラウザによってダウンロードされます。

4. **[Capabilities (機能)]** で **[Messages (メッセージ)]** ボタンを選択します。

5. **[Inbound URL (着信URL)]** ボックスに、着信メッセージWebhook URLのURLを入力します（`https://example.com/webhooks/inbound-message`など）。

6. **[Status URL (ステータスURL)]** ボックスに、メッセージステータスWebhookのURLを入力します（`https://example.com/webhooks/message-status`など）。

7. **[Generate new application (新しいアプリケーションの生成)]** ボタンをクリックします。これで、アプリケーション作成手順の次のステップに進みます。ここでは、Vonage番号をアプリケーションにリンクし、Facebookなどの外部アカウントをこのアプリケーションにリンクできます。

8. このアプリケーションをリンクする外部アカウントがある場合は、 **[Linked external accounts (リンクされた外部アカウント)]** タブをクリックし、リンク先のアカウントに対応する **[Link (リンク)]** ボタンをクリックします。

これでアプリケーションが作成されました。

> **注：** アプリケーションをテストする前に、Webhookが設定され、Webhookサーバーが実行されていることを確認してください。

