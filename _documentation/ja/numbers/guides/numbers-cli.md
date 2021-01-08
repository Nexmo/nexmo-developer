---
title:  Nexmo CLI を使用した番号の管理
description:  Nexmo CLI を使用した Number inventory のレンタル、設定、管理
navigation_weight: 2

---


Nexmo CLI を使用した番号の管理
====================

[Nexmo CLI](https://github.com/Nexmo/nexmo-cli)を使用して、次の操作を実行できます。

* [番号をリストアップする](#list-your-numbers)
* [新しい番号を検索する](#search-for-new-numbers)
* [番号をレンタルする](#rent-a-number)
* [番号を更新する](#update-a-number)
* [番号をキャンセルする](#cancel-a-number)

[インストール手順](https://github.com/Nexmo/nexmo-cli#installation) を読んで開始してください。

番号をリストアップする
-----------

`nexmo numbers:list` コマンドは、アカウントが所有するすべての番号を一覧表示します。

オプションのフラグは次のとおりです。

|     フラグ     |                                             説明                                             |
|-------------|--------------------------------------------------------------------------------------------|
| `--size`    | 返す結果の数                                                                                     |
| `--page`    | 1 ページあたりの結果の数                                                                              |
| `--pattern` | 検索するパターン。番号の先頭または末尾とマッチさせるには、`*` ワイルドカードを使用します。たとえば、`*123*` は、パターン `123` を含むすべての番号とマッチします。 |

````
> nexmo numbers:list
31555555555
44655555555
44555555555

> nexmo numbers:list --verbose
Item 1-3 of 3

msisdn      | country | type       | features  | voiceCallbackType | voiceCallbackValue | moHttpURL | voiceStatusCallbackUrl
----------------------------------------------------------------------------------------------------------------------------
31555555555 | NL      | mobile-lvn | VOICE,SMS | app               | b6d9f957           | undefined | https://example.com
44655555555 | GB      | mobile-lvn | VOICE,SMS | app               | b6d9f957           | undefined | https://example.com
44555555555 | GB      | mobile-lvn | SMS       | app               | b6d9f957           | undefined | https://example.com
````

新しい番号を検索する
----------

購入可能な番号を一覧表示するには、`nexmo number:search` コマンドを使用します。

オプションのフラグは次のとおりです。

|     フラグ     |                                             説明                                             |
|-------------|--------------------------------------------------------------------------------------------|
| `--pattern` | 検索するパターン。番号の先頭または末尾とマッチさせるには、`*` ワイルドカードを使用します。たとえば、`*123*` は、パターン `123` を含むすべての番号とマッチします。 |
| `--voice`   | 音声対応番号を検索するには                                                                              |
| `--sms`     | SMS 対応番号を検索するには                                                                            |
| `--size`    | 返す結果の数                                                                                     |
| `--page`    | 1 ページあたりの結果の数                                                                              |

````
> nexmo number:search US
12057200555
12069396555
12069396555
12155961555

> nexmo number:search NL --sms --pattern *007 --verbose
msisdn      | country | cost | type       | features
-----------------------------------------------------
31655551007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
31655552007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
31655553007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
````

番号をレンタルする
---------

使用可能な番号をレンタルするには、`nexmo number:buy` コマンドを使用します。購入の確認を求められます。

**次のいずれか** を指定する必要があります。

* レンタルしたい `number`
* `country_code` および `pattern` を使用すると、マッチする使用可能な番号が自動的に選択されます。

````
> nexmo number:buy 12069396555
Buying 12069396555\. This operation will charge your account.

Please type "confirm" to continue: confirm

Number purchased

> nexmo number:buy US *555
Buying 12069396555\. This operation will charge your account.

Please type "confirm" to continue: confirm

Number purchased: 12069396555

> nexmo number:buy 12069396555 --confirm
Number purchased: 12069396555
````

番号を更新する
-------

指定した番号の音声プロパティを更新するには、`nexmo number:update` コマンドを使用します。

> **注** ：アプリケーション ID、リンクされた電話番号、SIP URI、または Webhook を変更するには、[こちらで説明](https://github.com/Nexmo/nexmo-cli#linking)しているように、`nexmo link` コマンドを代わりに使用できます。

````
> nexmo number:update 445555555555 --voice_callback_type app --voice_callback_value asdasdas-asdd-2344-2344-asdasdasd345
--voice_callback_status https://example.com/webhooks/status
Number updated
````

番号をキャンセルする
----------

アカウントの既存の番号をキャンセルするには、`nexmo number:cancel` コマンドを使用します。キャンセルする番号を指定する必要があります。その番号がアカウントから削除される前に、キャンセルを確認するメッセージが表示されます。

````
> nexmo number:cancel 12069396555
This is operation can not be reversed.

Please type "confirm" to continue: confirm

Number cancelled: 12069396555

> nexmo number:cancel 12069396555 --confirm
Number cancelled: 12069396555
````
