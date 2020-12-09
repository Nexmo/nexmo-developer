---
title:  監査イベントを取得する

products: audit

description:  「フィルタリングされた監査イベントのリストを取得できます。監査イベントは、Vonageアカウントのアクティビティを記録します」

languages:
  - Curl


---

監査イベントを取得する
===========

Vonageアカウントに関連するすべての監査イベントの記録を取得できます。このリストは、日付、キーワード、ユーザー、イベントタイプに基づいてフィルタリングすることもできます。

このチュートリアルの内容
------------

フィルタリングされた監査イベントのリストを取得する方法を説明します。

* [準備](#prerequisites)
* [監査イベントのリストを取得する](#retrieve-a-list-of-audit-events)
* [フィルタリングされた監査イベントのリストを取得する](#retrieve-a-filtered-list-of-audit-events)
* [特定の監査イベントを取得する](#retrieve-a-specific-audit-event)
* [まとめ](#conclusion)
* [関連情報](#resources)

準備
---

このチュートリアルを進めるためには、以下のものが必要になります。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)。
* Curlコマンドを入力または貼り付けることができる実行中のターミナルアプリケーション。また、PawやPostmanなどのアプリケーションを使用することもできます。
* [Dashboard](https://dashboard.nexmo.com/sign-in)から取得できる`VONAGE_API_KEY`と`VONAGE_API_SECRET`を知っている必要があります。

また、[Audit APIのドキュメント](/audit/overview)も参照してください。

> **注：** 以下の例では、`VONAGE_API_KEY`と`VONAGE_API_SECRET`を[Dashboard](https://dashboard.nexmo.com)から取得した実際の値に置き換えてください。

監査イベントのリストを取得する
---------------

すべての監査イベントのリストを受信するには、ターミナルに次のように入力します。

```bash
$ curl "https://api.nexmo.com/beta/audit/events" \
     -u 'VONAGE_API_KEY:VONAGE_API_SECRET'
```

このコマンドを実行すると、すべての監査イベントのリストが表示されます。

フィルタリングされた監査イベントのリストを取得する
-------------------------

前のステップで受け取った監査イベントのリストは、特にVonageアカウントをしばらく使用していた場合には、きわめて大きく可能性があります。このリストは、いくつかのパラメーターに基づいてフィルタリングできます。

|   クエリパラメーター   |                                                              説明                                                              |
|---------------|------------------------------------------------------------------------------------------------------------------------------|
| `event_type`  | 監査イベントの種類です（例：`APP_CREATE`、`NUMBER_ASSIGN`）ここでは、カンマ区切りの[イベントタイプ](/audit/concepts/audit-events#audit-event-types)のリストを指定できます。 |
| `search_text` | JSON互換の検索文字列です。監査イベント内の特定のテキストを検索します。                                                                                        |
| `date_from`   | この日付からの監査イベントを取得します（ISO-8601形式）。                                                                                           |
| `date_to`     | この日付までの監査イベントを取得します（ISO-8601形式）。                                                                                           |
| `page`        | 1ページ目から始まるページ番号です。                                                                                                           |
| `size`        | 1ページあたりの要素数です（1～100、デフォルトは30）。                                                                                               |

たとえば、日付に基づいてフィルタリングするには、次のようなコマンドを入力します。

    $ curl "https://api.nexmo.com/beta/audit/events?date_from=2018-08-01&date_to=2018-08-31" \
         -u 'VONAGE_API_KEY:VONAGE_API_SECRET'

これにより、2018年8月中に発生したすべての監査イベントが返されます。

これをさらにいろいろな方法で絞り込むことができます。たとえば、[監査イベントタイプ](/audit/concepts/audit-events#audit-event-types)に基づいてフィルタリングすることもできます。

たとえば、タイプ`NUMBER_ASSIGN`の8月の監査イベントを見つけるには、次のように入力します。

    $  curl "https://api.nexmo.com/beta/audit/events?date_from=2018-08-01&date_to=2018-08-31&event_type=NUMBER_ASSIGN" \
         -u 'VONAGE_API_KEY:VONAGE_API_SECRET'

さらに、`search_text`に基づいてフィルタリングすることができます。たとえば、「password」というテキストを含むすべての監査イベントを検索するには、以下のコマンドを入力します。

    $  curl "https://api.nexmo.com/beta/audit/events?search_text=password" \
         -u 'VONAGE_API_KEY:VONAGE_API_SECRET'

特定の監査イベントを取得する
--------------

特定の監査イベントのUUIDが分かれば、その監査イベントオブジェクトの情報だけを取得できます。たとえば、イベントUUIDが`aaaaaaaa-bbbb-cccc-dddd-0123456789ab`の場合は、次のように入力します。

    $ curl "https://api.nexmo.com/beta/audit/events/aaaaaaaa-bbbb-cccc-dddd-0123456789ab" \
         -u 'VONAGE_API_KEY:VONAGE_API_SECRET'

これにより、指定された監査イベントの監査イベントオブジェクトJSONが返されます。

まとめ
---

Audit APIのフィルタリング機能を使用することで、取得する監査イベントを完全に制御できます。

関連情報
----

* [Audit APIのドキュメント](/audit/overview)
* [Audit APIの関連情報](/api/audit)

