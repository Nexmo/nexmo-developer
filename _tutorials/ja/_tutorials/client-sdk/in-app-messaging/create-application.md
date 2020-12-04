---
title:  Vonageアプリケーションの作成
description:  このステップでは、Vonageアプリケーションの作成方法を学びます。

---

Vonageアプリケーションを作成する
===================

このステップでは、アプリ内チャット通信のユースケースに対応できるVonage[アプリケーション](/conversation/concepts/application)を作成します。

> **注：** これは、クライアントアプリケーションがVonageバックエンドを使用できるようにするVonageアプリケーションプロジェクトです。

**1\.** プロジェクトディレクトリを作成していない場合は、作成します。

```shell
mkdir vonage-tutorial
```

**2\.** プロジェクトディレクトリに移動します。

```shell
cd vonage-tutorial
```

**3\.** 以下のコマンドをコピーしてターミナルに貼り付けて、Vonageアプリケーションを作成します。

```shell
nexmo app:create "App to App Chat Tutorial" --capabilities=rtc --keyfile=private.key  --rtc-event-url=https://example.com/
```

`.nexmo-app`という名前のファイルがプロジェクトディレクトリに作成され、新しく作成されたVonageアプリケーションIDと秘密鍵が含まれます。`private.key`という名前の秘密鍵ファイルも作成されます。

**今後必要になるので、アプリケーションIDを書き留めてください。** 

```screenshot
image: public/screenshots/tutorials/client-sdk/nexmo-application-created.png
```

> **注：** アプリケーションは、CLIの[対話モード](/application/nexmo-cli#interactive-mode)を使用して作成することもできます。

> **注：** アプリケーションの作成方法と利用可能なさまざまなアプリケーション機能の詳細については、当社の[ドキュメント](/application/overview)を参照してください。

> **注：** アプリケーションIDなど、アプリケーションに関する情報を[Dashboard](https://dashboard.nexmo.com/voice/your-applications)で取得することもできます。

