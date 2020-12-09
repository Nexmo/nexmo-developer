---
title:  Vonageアプリケーションの作成
description:  このステップでは、Vonageアプリケーションの作成方法を学びます。

---

Vonageアプリケーションを作成する
===================

これで、Vonage[アプリケーション](/conversation/concepts/application)を作成する必要があります。このステップでは、音声ユースケースを処理できるアプリケーションを作成します。

**1\.** プロジェクトディレクトリを作成していない場合は、作成します。

```shell
mkdir vonage-tutorial
```

**2\.** プロジェクトディレクトリに移動します。

```shell
cd vonage-tutorial
```

**3\.** 以下のコマンドをコピーしてターミナルに貼り付けて、Vonageアプリケーションを作成します。 `GIST-URL`を前の手順のgist URLに置き換えて、`--voice-answer-url`引数の値を変更してください。

```shell
nexmo app:create "App to App Tutorial" --capabilities=voice --keyfile=private.key  --voice-event-url=https://example.com/ --voice-answer-url=GIST-URL
```

`.nexmo-app`という名前のファイルがプロジェクトディレクトリに作成され、新しく作成されたVonageアプリケーションIDと秘密鍵が含まれます。`private.key`という名前の秘密鍵ファイルも作成されます。

**今後必要になるので、アプリケーションIDを書き留めてください。** 

```screenshot
image: public/screenshots/tutorials/client-sdk/nexmo-application-created.png
```

> **注：** アプリケーションの作成方法と利用可能なさまざまなアプリケーション機能の詳細については、当社の[ドキュメント](/application/overview)を参照してください。

> **注：** アプリケーションIDなど、アプリケーションに関する情報を[Dashboard](https://dashboard.nexmo.com/voice/your-applications)で取得することもできます。

