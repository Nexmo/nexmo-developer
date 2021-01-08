---
title:  音声アプリケーションの作成
description:  このステップでは、音声アプリケーションの作成方法を学びます。音声アプリケーションには、応答WebhookとイベントWebhookがあります。
meta_title:  Vonage API用の音声アプリケーションを作成する
meta_description:  音声アプリケーションには、応答WebhookとイベントWebhookがあります。

---

音声アプリケーションを作成するには、次の2つの方法があります：

1. Nexmo CLI を使用する
2. Dashboardを使用する

これらの各方法については、以降のセクションで説明します。

### Nexmo CLIを使用して音声アプリケーションを作成する方法

Nexmo CLIを使用してアプリケーションを作成するには、次のコマンドをシェルに入力し、Ngrokを設定したときに取得したNgrokホストで`NGROK_HOST_NAME`を置き換えます：

```shell
nexmo app:create "AspNetTestApp" http://NGROK_HOST_NAME/webhooks/answer http://NGROK_HOST_NAME/webhooks/events
```

このコマンドは、音声[機能](/application/overview#capabilities)を持つVonageアプリケーションを作成します。応答とイベントのWebhook URLを使用してアプリケーションを設定し、秘密鍵ファイル`private.key`を生成します。このファイルはプロジェクトディレクトリに保存する必要があります。

このコマンドは、一意のアプリケーションIDを返します。このアプリケーションIDを使用して、以下を実行して、Vonage仮想番号をアプリケーションにリンクします：

```shell
nexmo link:app VONAGE_NUMBER APPLICATION_ID
```

これにより、そのVonage仮想番号がアプリケーションにリンクされ、その番号で発生したすべての音声イベントが指定されたURLにルーティングされます。

### Dashboardを使用して音声アプリケーションを作成する方法

音声アプリケーションは、[Dashboard](https://dashboard.nexmo.com/applications)で作成できます。

Dashboardを使用してアプリケーションを作成するには、次の手順に従います：

1. Dashboardの[アプリケーション](https://dashboard.nexmo.com/applications)で、 **[Create a new application (新しいアプリケーションの作成)]** ボタンをクリックします。

2. **[Name (名前)]** に、アプリケーション名を入力します。後で参照しやすくするために、名前を選択してください。

3. **[Generate public and private key (公開鍵と秘密鍵を生成)]** ボタンをクリックします。これにより、公開鍵と秘密鍵のペアが作成され、秘密鍵がブラウザによってダウンロードされます。生成された秘密鍵を保存します。

4. **[Capabilities (機能)]** で **[Voice (音声)]** ボタンを選択します。

5. **[Answer URL (応答URL)]** ボックスに、着信通話WebhookのURL（`http://example.com/webhooks/answer`など）を入力します。

6. **[Event URL (イベントURL)]** ボックスに、通話ステータスWebhookのURL（`http://example.com/webhooks/events`など）を入力します。

7. **[Generate new application (新しいアプリケーションの生成)]** ボタンをクリックします。

8. これで、アプリケーションの作成手順の次の手順に進みます。ここで、Vonage番号をアプリケーションにリンクします。

これでアプリケーションが作成されました。

> **注：** アプリケーションをテストする前に、Webhookが設定され、Webhookサーバーが実行されていることを確認してください。

