---
title:  Vonageアプリケーションの作成
description:  このステップでは、Vonageアプリケーションの作成方法を学びます。

---

Vonageアプリケーションを作成する
===================

これで、Vonage[アプリケーション](/conversation/concepts/application)を作成する必要があります。このステップでは、アプリ内音声とアプリ内メッセージの両方のユースケースを処理できるアプリケーションを作成します。

**1\.** プロジェクトディレクトリを作成していない場合は、作成します。

```shell
mkdir vonage-tutorial
```

**2\.** プロジェクトディレクトリに移動します。

```shell
cd vonage-tutorial
```

**3\.** Vonageアプリケーションを[インタラクティブ](/application/nexmo-cli#interactive-mode)に作成します。次のコマンドはインタラクティブモードに入ります：

```shell
nexmo app:create
```

**4\.** アプリケーション名を指定します。Enterキーを押して続行します。

**5\.** これで、矢印キーを使用してアプリケーション機能を選択し、スペースバーを押して
アプリケーションに必要な機能を選択します。この例では、矢印キーとスペースバーを使用して[Voice (音声)]と[RTC]の両方の機能を選択します。[Voice (音声)]と[RTC]の両方の機能を選択したら、Enterキーを押して続行します。

> **注：** アプリケーションがアプリ内音声のみの場合は、音声機能を選択するだけです。アプリ内メッセージが必要な場合は、RTC機能のみを選択してください。アプリにアプリ内音声とアプリ内メッセージの両方がある場合は、両方の機能を選択します。

**6** .「Use the default HTTP methods? (デフォルトのHTTP方式を使用しますか？)]の場合は、Enterキーを押してデフォルトを選択します。

**7\.** 「Voice Answer URL (音声応答URL)」の場合は、`https://example.ngrok.io/webhooks/answer`またはその他の適切なURLを入力します（これはテスト方法によって異なります）。

**8\.** 次に、「Voice Fallback Answer URL (音声フォールバック応答URL)」の入力を求められます。これはオプションのフォールバックURLで、メインの
音声
応答URLが何らかの理由で失敗しています。この場合、Enterキーを押すだけです。後でフォールバックURLが必要な場合は、[Dashboard](https://dashboard.nexmo.com/sign-in)またはNexmo CLIを使用してフォールバックURLを追加できます。

**9\.** これで、「Voice Event URL (音声イベントURL)」を入力する必要があります。`https://example.ngrok.io/webhooks/event`と入力します。

**10\.** 「RTC Event URL (RTCイベントURL)」の場合は、`https://example.ngrok.io/webhooks/rtc`を入力します。

**11\.** 「公開キーのパス」の場合は、Enterキーを押してデフォルトを選択します。独自の公開鍵と秘密鍵のペアを使用する場合は
[このドキュメント](/application/nexmo-cli#creating-an-application-with-your-own-public-private-key-pair)を参照
してください。

**12\.** 「Private Key path (秘密鍵パス)」の場合は、`private.key`を入力し、Enterキーを押します。

`.nexmo-app`という名前のファイルがプロジェクトディレクトリに作成され、新しく作成されたVonageアプリケーションIDと秘密鍵が含まれます。`private.key`という名前の秘密鍵ファイルも作成されます。

**今後必要になるのでメモしておいてください。** 

```screenshot
image: public/screenshots/tutorials/client-sdk/nexmo-application-created.png
```

> **注：** アプリケーションの作成方法と利用可能なさまざまなアプリケーション機能の詳細については、当社の[ドキュメント](/application/overview)を参照してください。

> **注：** アプリケーションIDなど、アプリケーションに関する情報を[Dashboard](https://dashboard.nexmo.com/voice/your-applications)で取得することもできます。

