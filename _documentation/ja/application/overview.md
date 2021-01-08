---
title:  概要
meta_title: アプリケーションバージョン 2 の概要
Description: Vonage API アプリケーションには、Vonage エンドポイントに接続し、Vonage API を使用するために必要なセキュリティおよび構成情報が含まれています。(Nexmo は Vonage になりました）
navigation_weight:  1

---


概要
===

> **注：** ドキュメントのこのセクションでは、[アプリケーション V2](/api/application.v2)の機能について説明しています。

Vonage API アプリケーションには、Vonage エンドポイントに接続し、Vonage API を使用するために必要なセキュリティおよび構成情報が含まれています。

作成された各 Vonage アプリケーションは、複数の機能をサポートできます。たとえば、音声、メッセージ、RTC API の使用をサポートするアプリケーションを作成できます。

![アプリケーションの概要](/images/nexmo_application_v2.png "アプリケーションの概要")

Vonage アプリケーションの使用方法を説明するために、Vonage 音声アプリケーションを作成して使用するための簡単な概要を説明します。

1. CLI、ダッシュボード、またはアプリケーション API を使用して Vonage アプリケーションを作成します。
2. Webhook URL を必ず設定してください。Vonage は、重要な情報とともにこれらの URL にコールバックします。
3. Vonage の番号を Vonage アプリケーションに関連付けます。
4. Web アプリケーションを記述します。必要に応じて Vonage API を使用して、手順 2 で設定した Webhook エンドポイントを実装します。

たとえば、宛先の電話に[着信コールを転送する](/voice/voice-api/code-snippets/connect-an-inbound-call)アプリケーションを作成する場合は、次の手順を実行します。

1. 音声機能を持つ Vonage アプリケーションを作成します。
2. 応答およびイベント用の Webhook URL を設定します。
3. Vonage の番号を Vonage アプリケーションに関連付けます。
4. Webhook URL のコールバックに応答する Web アプリケーションを実装します。
5. Vonage アプリケーションに関連付けられた Vonage 番号に着信コールがあると、`answer_url` で [NCCO](/voice/voice-api/ncco-reference) が返されます。

メッセージや配信機能を備えたアプリケーションなど、他のタイプのアプリケーションでは手順が若干異なり、この[ドキュメント](/application/overview)の関連セクションで説明しています。

以降のセクションでは、Vonage アプリケーションについてさらに詳しく説明しています。

構築
---

各アプリケーションには次のものがあります。

|名前 | 説明|
| -- | -- |
|`id`| 各アプリケーションを識別するために使用され、`private_key` とともに使用され、JWT を生成します。|
|`name` | アプリケーション名。|
|`capabilities` | このアプリケーションがサポートする機能の種類を説明します。機能 `voice`、`messages`、`rtc`、`vbc`。1 つのアプリケーションで、これらの機能をいくつでもサポートできます。また、指定した機能ごとに `webhooks` を設定します。Vonage は、Webhook エンドポイントを介して情報を送信および取得します。|
|`keys` | `private_key` と `public_key` が含まれています。公開鍵を使用して、Vonage API への呼び出しを認証するために使用される JWT を生成します。公開鍵は、Vonage API へのリクエストで JWT を認証するために Vonage によって使用されます。|

機能
---

Vonage アプリケーションは、音声、メッセージと配信、会話、クライアント SDK など、さまざまな API を使用できます。

アプリケーションを作成するときに、アプリケーションでサポートする機能を指定できます。機能ごとに、必要な機能に応じて Webhook を設定できます。たとえば、`rtc` 機能を備えたアプリケーションの場合、RTC イベントを受信するイベント URL を指定できます。アプリケーションで `voice` 機能も使用する必要がある場合は、応答 URL を設定して、通話応答 Webhook、応答 URL が失敗した場合のフォールバック URL、音声通話関連のイベントを受信するための別のイベント URL などを受信することもできます。

機能の概要を次の表に示します。

|     機能     |                     説明                      |
|------------|---------------------------------------------|
| `voice`    | 音声機能のサポートに使用されます。                           |
| `messages` | メッセージと配信 API 機能のサポートに使用されます。                |
| `rtc`      | WebRTC 機能のサポートに使用されます。通常、クライアント SDK で使用します。 |
| `vbc`      | 価格を決定するために使用されますが、現在他の機能はありません。             |

Web フック
-------

アプリケーションの作成時に指定する Webhook URL は、必要なアプリケーションの機能によって異なります。次の表は、Webhook をまとめたものです。

|     機能     | 使用された API  |                  利用可能な Webhook                   |
|------------|------------|--------------------------------------------------|
| `voice`    | 音声         | `answer_url`, `fallback_answer_url`, `event_url` |
| `messages` | メッセージと配信   | `inbound_url`, `status_url`                      |
| `rtc`      | Client SDK | `event_url`                                      |
| `vbc`      | VBC        | なし                                               |

Webhook のタイプ
------------

次の表は、機能ごとに使用できる Webhook について説明しています。

|     機能     |        Webhook        |                               API                               |                   例                   |                                                                                                                                                             説明                                                                                                                                                             |
|------------|-----------------------|-----------------------------------------------------------------|---------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `voice`    | `answer_url`          | [音声](/voice/voice-api/overview)                                 | https://example.com/webhooks/answer   | Vonage がコールを発信/受信したときに要求する URL。NCCO を返す必要があります。                                                                                                                                                                                                                                                                            |
| `voice`    | `fallback_answer_url` | [音声](/voice/voice-api/overview)                                 | https://example.com/webhooks/fallback | `fallback_answer_url` が設定されており、`answer_url` がオフラインであるか、HTTP エラーコードを返すか、`event_url` がオフラインであるか、エラーコードを返し、イベントが NCCO を返すことが予想される場合、Vonage はそれにリクエストを送信します。`fallback_answer_url` は NCCO を返す必要があります。最初の NCCO を 2 回試行した後、`fallback_answer_url` が失敗した場合、コールは終了します。実行中のコールを 2 回試行した後、`fallback_answer_url` が失敗した場合、コールフローは続行されます。 |
| `voice`    | `event_url`           | [音声](/voice/voice-api/overview)                                 | https://example.com/webhooks/event    | Vonage はこの URL にコールイベント（例：呼び出し中、応答など）を送信します。                                                                                                                                                                                                                                                                               |
| `messages` | `inbound_url`         | [メッセージ](/messages/overview)、[配信](/dispatch/overview)            | https://example.com/webhooks/inbound  | Vonage は、この URL に着信メッセージを転送します。                                                                                                                                                                                                                                                                                            |
| `messages` | `status_url`          | [メッセージ](/messages/overview)、[配信](/dispatch/overview)            | https://example.com/webhooks/status   | Vonage は、メッセージステータスの更新（例：`delivered`、`seen`）をこの URL に送信します。                                                                                                                                                                                                                                                                |
| `rtc`      | `event_url`           | [クライアント SDK](/client-sdk/overview)、[会話](/conversation/overview) | https://example.com/webhooks/rtcevent | Vonage は RTC イベントをこの URL に送信します。                                                                                                                                                                                                                                                                                           |
| `vbc`      | なし                    | [音声エンドポイント](/voice/voice-api/ncco-reference#connect)            | なし                                    | 使用されていません                                                                                                                                                                                                                                                                                                                  |

アプリケーションの作成
-----------

アプリケーションを作成するには、主に次の 4 つの方法があります。

1. Vonage [ダッシュボード](https://dashboard.nexmo.com)を使用する。アプリケーションは、ダッシュボードの[お使いのアプリケーション](https://dashboard.nexmo.com/applications)セクションに一覧表示されます。
2. [Nexmo CLI](/application/nexmo-cli)を使用する。
3. [アプリケーション API](/api/application.v2)を使用する。
4. Vonage [サーバー SDK](/tools)のいずれかを使用する。

CLI を使用したアプリケーションの管理
--------------------

* [Nexmo CLI を使用したアプリケーションの管理](/application/nexmo-cli)

コードスニペット
--------

```code_snippet_list
product: application
```

関連情報
----

* [アプリケーション API](https://developer.nexmo.com/api/application.v2)

