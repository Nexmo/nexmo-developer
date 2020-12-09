---
title:  Web フックの関連情報
description:  Nexmo が音声コールに関して送信する Web フックの詳細。
api:` 「音声用 `API:  Web フック」

---


音声用 API Web フックの関連情報
====================

Nexmo は音声用 API と Web フックを併用して、アプリケーションがコールと交信できるようにします。Web フックのエンドポイントには次の 3 つ (必須 2、任意 1) があります。

* [応答 Web フック](#answer-webhook)はコールの応答時に送信され、着信と発信の両方のコールに使用されます。
* [イベント Web フック](#event-webhook)はコール中に発生するすべてのイベント用に送信されます。アプリケーションは各イベントタイプを記録、反応、無視できます。
* [フォールバック URL](#fallback-url) は応答またはイベント Web フックが応答に失敗するか、HTTP エラーステータスを返す場合に使用されます。
* 発生した場合、[エラー](#errors) もイベント Web フックに送信されます。

一般的な情報については、[Web フックガイド](/concepts/guides/webhooks)をご覧ください。

応答 Web フック
----------

着信コールが応答されると、アプリケーション設定時に指定した `answer_url` に HTTP リクエストが送信されます。発信コールでは、コール発信時に `answer_url` を指定します。

応答 Web フックはデフォルトでは `GET` リクエストですが、`POST` に上書きされるように `answer_method` フィールドを設定できます。着信コールではアプリケーション作成時にこれらの値を設定します。発信コールではコール発信時にこれらの値を指定します。

### 応答 Web フックのデータフィールド

フィールド | 例 | 説明
-- | -- | --
`to` | `442079460000` | コールの発信元番号 (コールがプログラムによって開始される場合、発信者の Nexmo 番号である場合あり)
`from` | `447700900000` | コールの発信先番号 (Nexmo 番号または別の電話番号)
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子

#### SIP ヘッダ付きの追加データの転送

上記フィールドに加え、SIP Connect の使用時に必要な追加ヘッダを指定できます。追加するヘッダは `X-` で開始する必要があり、`answer_url` にプレフィックス `SipHeader_` を付けて送信されます。たとえば値が`1938ND9` である `X-UserId` ヘッダを追加する場合、Nexmo はユーザーが `answer_url` に出したリクエストに `SipHeader_X-UserId=1938ND9` を追加します。

> **警告:** `X-Nexmo` で始まるヘッダは<code translate="no">answer\_url</code>に送信されません `answer_url`

### 応答 Web フックのデータフィールドの例

`GET` リクエストでは、変数は URL に組み込まれます (以下参照)。

```text
/answer.php?to=442079460000&from=447700900000&conversation_uuid=CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab&uuid=aaaaaaaa-bbbb-cccc-dddd-0123456789ab&SipHeader_X-UserId=1938ND9
```

`answer_method` を `POST` に設定すると、本文に JSON 形式のデータが入ったリクエストを受信します (以下参照)。

```text
{
  "from": "442079460000",
  "to": "447700900000",
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "conversation_uuid": "CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "SipHeader_X-UserId": "1938ND9"
}
```

### 応答 Web フックへの応答

Nexmo では実行アクションを含む [NCCO](/voice/voice-api/ncco-reference) を JSON 形式で返すようにしてください。

イベント Web フック
------------

コールのステータスが変更すると、イベント Web フックエンドポイントに HTTP リクエストが届きます。コール開始時に特定の `event_url` を指定して上書きされる場合を除き、アプリケーション作成時に指定した URL `event_url` が使用されます。

デフォルトの着信リクエストは、本文が JSON 形式の `POST` リクエストです。`event_url` に加えて `event_method` を設定することで、メソッドを `GET` に上書きできます。

含まれるデータの形式は発生したイベント (以下参照) に応じて異なります。

* [`started`](#started)
* [`ringing`](#ringing)
* [`answered`](#answered)
* [`busy`](#busy)
* [`cancelled`](#cancelled)
* [`unanswered`](#unanswered)
* [`disconnected`](#disconnected)
* [`rejected`](#rejected)
* [`failed`](#failed)
* [`human/machine`](#human-machine)
* [`timeout`](#timeout)
* [`completed`](#completed)
* [`record`](#record)
* [`input`](#input)
* [`transfer`](#transfer)

### 開始済み

コールが作成されたことを示します。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `started` | コールのステータス
`direction` | `outbound` | コールの方向 (`inbound` または `outbound`)
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 呼び出し中

コール先にアクセスでき、呼び出し中です。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `ringing` | コールのステータス
`direction` | `outbound` | コールの方向 (`inbound` または `outbound`)
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 応答済み

コールが応答されました。

フィールド | 例 | 説明
-- | -- | --
`start_time` | - | *空*
`rate` | - | *空*
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `answered` | コールのステータス
`direction` | `inbound` | コールの方向 (`inbound` または `outbound`)
`network` | - | *空*
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### ビジー

コール先は別のコール者と交信中です。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `busy` | コールのステータス
`direction` | `outbound` | コールの方向であり、このコンテキストでは `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### キャンセル済み

発信コールは応答前に発信者によってキャンセルされています。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `cancelled` | コールのステータス
`direction` | `outbound` | コールの方向であり、このコンテキストでは `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 応答無し

受信者にアクセス不能であるか、受信者がコールを拒否しました。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `unanswered` | コールのステータス
`direction` | `outbound` | コールの方向であり、このコンテキストでは `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 接続切断

WebSocket 接続が何らかの理由によりアプリケーション側で打ち切られた場合、中断イベントのコールバックが送信されます。応答に NCCO が含まれる場合はコールバックが処理され、NCCO が含まれない場合は通常の実行操作が継続されます。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`status` | `disconnected` | コールのステータス
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 拒否

コールは接続前に Nexmo によって拒否されました。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `rejected` | コールのステータス
`direction` | `outbound` | コールの方向であり、このコンテキストでは `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 失敗

発信コールは接続されませんでした。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `failed` | コールのステータス
`direction` | `outbound` | コールの方向であり、このコンテキストでは `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 人間/マシン

プログラムによって発信されるコールで、`machine_detection` オプションが設定される場合、ステータスが `human` または `machine` のイベントは人がコールに応答したかどうかに応じて送信されます。

フィールド | 例 | 説明
-- | -- | --
`call_uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子 ( **注** `call_uuid` であり、他の一部のエンドポイントのように `uuid` ではない)
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`status` | `human` | コールのステータスで、`human` (人が応答した場合)、または `machine` (ボイスメールなどの自動サービスが応答した場合)
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### タイムアウト

呼び出し音が鳴るフェーズが指定した `ringing_timeout` 期間を超える場合、このイベントが送信されます。

フィールド | 例 | 説明
-- | -- | --
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `timeout` | コールのステータス
`direction` | `outbound` | コールの方向であり、このコンテキストでは `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 完了

コールは終了しました。このイベントにはコールの要約データも含まれます。

フィールド | 例 | 説明
-- | -- | --
`end_time` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`network` | `GB-FIXED` | コールに使用されたネットワークのタイプ
`duration` | `2` | コールの所要時間 (秒単位)
`start_time` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)
`rate` | `0.00450000` | コールの 1 分あたり料金 (ユーロ)
`price` | `0.00015000` | コールの合計料金 (ユーロ)
`from` | `442079460000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`status` | `completed` | コールのステータス
`direction` | 着信 | コールの方向 (`inbound` または `outbound`)
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 録音 (record)

この Web フックは「録音」アクションを含む NCCO が終了すると到達します。録音アクションの作成時に、このイベントの送信先として別の `eventUrl` を設定できます。このオプションは、このイベントタイプを別々のコードを使って処理する場合に便利です。

フィールド | 例 | 説明
-- | -- | --
`start_time` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)
`recording_url` | `https://api.nexmo.com/v1/files/bbbbbbbb-aaaa-cccc-dddd-0123456789ab` | 録音のダウンロード先
`size` | 12222 | 録音ファイルのサイズ (バイト)
`recording_uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | この録音に固有の識別子
`end_time` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 入力 (input)

Nexmo は「入力」アクションがある NCCO の終了時にこの Web フックを送信します。

フィールド | 例 | 説明
-- | -- | --
`from` | `447700900000` | コールの発信元番号
`to` | `447700900000` | コールの発信先番号
`dtmf` | `42` | ユーザーが押したボタン
`timed_out` | `true` | 入力アクションでのタイムアウトの有無: タイムアウトした場合は `true`、しなかった場合は `false`
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

### 転送 (transfer)

この Web フックは、カンバセーション間でレッグが転送される場合に Nexmo によって送信されます。実行するには、NCCO または [`transfer` アクション](/api/voice#updateCall)を使用することができます。

フィールド | 例 | 説明
-- | -- | --
`conversation_uuid_from` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | レッグの転送元のカンバセーション ID
`conversation_uuid_to` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | レッグの転送先のカンバセーション ID
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このコールに固有の識別子
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

[イベント Web フックリストに戻る](#event-webhook)

フォールバック URL
-----------

NCCO を使ったイベントへの応答が期待される場合に、応答 Web フックまたはイベント Web フックのいずれかが HTTP エラーステータスを返すかアクセス不能のときは、フォールバック Web フックにアクセスされます。フォールバック URL から返されるデータは、当初の応答 URL またはイベント URL で受信されるものと同じデータに、次のとおり、新しいパラメーター、`reason` と `original_request` が追加されます。

```text
{
  "reason": "Connection closed.",
  "original_request": {
    "url": "https://api.example.com/webhooks/event",
    "type": "event"
  }
}
```

最初の NCCO 中に接続が遮断/リセット/タイムアウトしたか、HTTP ステータスコードが `429`、`503` または `504` であるため、`answer_url` が 2 度試される場合は、次の手順が踏まれます。

1. `fallback_answer_url` へのアクセスを 2 度試みます
2. アクセスできない場合、コールは終了します

コール中に接続が遮断/リセット/タイムアウトしたか、HTTP ステータスコードが `429`、`503` または `504` であるため、NCCOを返すものと予想されるイベント (例: `input` または `notify` を返す) の `event_url` が 2 度試される場合は、次の手順が踏まれます。

1. `fallback_answer_url` へのアクセスを 2 度試みます
2. アクセスできない場合、コールフローを続行します

エラー
---

イベントエンドポイントはエラーイベントでも Web フックを受信します。これはアプリケーションをデバッグするのに役立ちます。

フィールド | 例 | 説明
-- | -- | --
`reason` | `Syntax error in NCCO. Invalid value type or action.` | エラーの性質に関する情報
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | このカンバセーションに固有の識別子
`timestamp` | `2020-01-01T12:00:00.000Z` | タイムスタンプ (ISO 8601 形式)

