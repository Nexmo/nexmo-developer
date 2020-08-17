---
title:  概要
meta_title:  Nexmo の音声用 API をテキスト読み上げ、IVR、コール録音などに活用
navigation_weight:  1
description:  音声用 API の概要。

---


音声用 API の概要
===========

Nexmo 音声用 API は質の高い音声アプリケーションをクラウドで構築するきわめて簡単な方法であり、次の用途で利用できます。

* 現在利用中の Web 技術と共に拡張するアプリを構築する
* Nexmo Call Control Objects (NCCO) を使って、JSON 形式で着信と発信コールフローを制御する
* 着信と発信コールを録音・保存する
* カンファレンスコールを作成する
* テキスト読み上げメッセージを性別やアクセントを変えて40言語で送信する

内容
---

このドキュメントでは次のトピックを取り上げます。

* [Nexmo 音声用 API の基本概念](#concepts) で基本用語を学ぶ
* [**音声用 API を使い始める方法**](#getting-started) (使用言語での例を交えて)
* [ガイド](#guides) 音声用 API の操作方法
* [コードスニペット](#code-snippets) 特定のタスクに役立つコードスニペット
* [ユースケース](#use-cases) コードサンプルを使った詳細なユースケース
* [関連情報](#reference) API に関するドキュメントとその他の補足コンテンツ

基本概念
----

* **JWT で認証** - 音声用 API との交信は JWT (JSON Web Tokens) を使って認証されます。[Nexmo ライブラリ](/tools)は Nexmo 音声アプリケーションの固有 ID と秘密鍵を使って JWT 生成を処理します。詳細については、[アプリケーションの認証](/concepts/guides/authentication)を参照してください。

* **Nexmo 音声アプリケーション** - Nexmo 音声アプリケーションはユーザーが構築しているアプリケーションと 1 対 1 でマッピングします。仮想番号や Web フックコールバック URL などの設定を含みます。Nexmo 音声アプリケーションは、[Nexmo Dashboard](https://dashboard.nexmo.com/sign-in)、[Nexmo CLI](/tools) を使用するか[アプリケーション用 API](/concepts/guides/applications) を介して作成可能です。

* **[NCCO](/voice/voice-api/ncco-reference)** - Nexmo Call Control Objects とは、Nexmo アプリケーションへのコールの操作方法を Nexmo に指示する一連のアクションです。たとえば、コールを `connect` したり、`talk` を使用した合成発話を送信したり、オーディオを `stream` したり、コールを `record` したりできます。これらのアクションは JSON 形式のオブジェクト配列として表示されます。詳細については、[NCCO の関連情報](/voice/voice-api/ncco-reference)を参照してください。

* **[番号](/voice/voice-api/guides/numbers)** - Nexmo 音声用 API の電話番号を使用する主な基本概念。

* **[Web フック](/concepts/guides/webhooks)** - HTTP リクエストをアプリケーションの Web サーバーに出してそれに基づいて行動できるようにします。たとえば着信は Web フックを送信します。

最初のステップ
-------

### 音声プレイグラウンド

[Nexmo Dashboard](https://dashboard.nexmo.com) では、音声用 API を音声プレイグラウンドでインタラクティブに試すことができます。[Nexmo アカウントにサインアップ](https://dashboard.nexmo.com/signup)したら、Nexmo Dashboard の [音声プレイグラウンド](https://dashboard.nexmo.com/voice/playground)に進みます ([音声] ‣ [音声プレイグラウンド])。

こちらのブログ投稿で詳細をお読みいただけます: [音声プレイグラウンド、Nexmo 音声用 API のテストサンドボックスの紹介 (英語)](https://www.nexmo.com/blog/2017/12/12/voice-playground-testing-sandbox-nexmo-voice-apps/)

### API の使用

Nexmo 音声プラットフォームとの交信には[パブリック API](/voice/voice-api/api-reference) が主に使用されます。コールを外部に発信するには、`POST` リクエストを `https://api.nexmo.com/v1/calls` に出します。

このプロセスを簡素化するため、Nexmo では認証や適切なリクエスト本文の作成をユーザーのために処理するサーバー SDK を多様な言語で提供しています。

開始するには、以下から言語を選択し、コードサンプルの次の変数を置き換えます。

キー | 説明
-- | --
`NEXMO_NUMBER` | コールを発信可能な Nexmo の番号。例: `447700900000`。
`TO_NUMBER` | E.164 format でコールする番号。例: `447700900001`。

```code_snippets
source: '_examples/voice/make-an-outbound-call'
application:
  type: voice
  name: 'Outbound Call code snippet'
  answer_url: https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/text-to-speech.json
```

ガイド
---

```concept_list
product: voice/voice-api
```

コードスニペット
--------

```code_snippet_list
product: voice/voice-api
```

ユースケース
------

```use_cases
product: voice/voice-api
```

関連情報
----

* [音声用 API の関連情報](/api/voice)
* [NCCO の関連情報](/voice/voice-api/ncco-reference)
* [Web フックの関連情報](/voice/voice-api/webhook-reference)

