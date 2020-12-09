---
title:  NodeベータサーバーSDKをインストールする
description:  Vonage NodeベータサーバーSDKをインストールして、最新の機能を入手してください。

---

JavaScriptを使用してアプリケーションを開発する場合は、Vonage NodeサーバーSDKのベータ版をインストール（または更新）する必要があります。

### インストール

ベータ版では、NodeサーバーSDKは次の方法でインストールできます：

```bash
$ npm install --save nexmo@beta
```

サーバーSDKが既にインストールされている場合は、上記のコマンドにより、サーバーSDKが最新バージョンにアップグレードされます。

### 使用

サーバーSDKを使用する場合は、次の情報が必要です：

|キー | 説明|
|-- | --|
|`NEXMO_API_KEY` | [Dashboard](https://dashboard.nexmo.com)から取得できるVonage APIキー。|
|`NEXMO_API_SECRET` | [Dashboard](https://dashboard.nexmo.com)から取得できるVonage APIシークレット。|
|`NEXMO_APPLICATION_ID` | [Dashboard](https://dashboard.nexmo.com)から取得できるVonageアプリケーションのVonageアプリケーションID。|
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | Vonageアプリケーションの作成時に生成された`private.key`ファイルへのパス。|

これらの変数は、サーバーSDKサンプルコード内の実際の値に置き換えることができます。

