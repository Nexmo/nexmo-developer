---
title:  Postmanを使用してCSVレポートを作成する
description:  Postmanツールを使用してCSV形式のレポートを作成します

---

Postmanを使用してCSVレポートを作成する
========================

Postmanのワークスペースで、HTTPメソッドを`POST`に設定し、次のURLを入力します： `https://api.nexmo.com/v2/reports/`

その後、次のことを行う必要があります：

* [リクエストを承認する](#authorize-the-request)
* [リクエスト本文を書式設定する](#format-the-request-body)
* [リクエストを作成する](#create-the-request)
* [リクエストを実行する](#execute-the-request)

リクエストを承認する
----------

[Authorization (認証)]タブを選択し、次の値を入力します：

* タイプ： `Basic Auth`
* ユーザー名：Vonage APIキー
* パスワード：Vonage APIシークレット

> **注** ：APIキーとシークレットは、[Developer Dashboard](https://dashboard.nexmo.com)で確認できます。

![レポートの作成](/images/reports-api/create-report-postman.png)

リクエスト本文を書式設定する
--------------

[Body (本文)]タブで、[raw (未加工)]ラジオボタンと、フォーマットのドロップダウンリストから[JSON]を選択します：

![リクエストをフォーマットする](/images/reports-api/format-request-body-postman.png)

リクエストを作成する
----------

[Body (本文)]タブで、以下に示すように、リクエスト本文を入力します。APIキーを独自のAPIキー、`date_start`および`date_end`に置き換え、必要な期間の適切な値に置き換えます。

> **注** ：`end_date`パラメータは期間に含まれません。生成されたレポートは、`start_date`から、`end_date`で指定された日時の直前までの期間をカバーします。

### SMSレポートの場合

![SMSレポートリクエストの作成](/images/reports-api/create-request-body-sms-postman.png)

### ボイスレポートの場合

![SMSレポートリクエストの作成](/images/reports-api/create-request-body-voice-postman.png)

> **注** ：`product`は、`SMS`、`VOICE-CALL`、`VERIFY-API`、`NUMBER-INSIGHT`、`MESSAGES`、`CONVERSATION`のいずれかである必要があります。

リクエストを実行する
----------

[Send (送信)]ボタンをクリックします。応答は、次の形式で表示されます：

```json
{
    "request_id": "a68908f0-4f23-4b47-a09b-9f4de0ce0737",
    "request_status": "PENDING",
    "product": "SMS",
    "account_id": "VONAGE_API_KEY",
    "date_start": "2019-04-01T00:00:00+0000",
    "date_end": "2019-07-01T00:00:00+0000",
    "include_subaccounts": false,
    "direction": "outbound",
    "include_message": false,
    "receive_time": "2019-10-25T14:13:38+0000",
    "_links": {
        "self": {
            "href": "https://api.nexmo.com/v2/reports/a68908f0-4f23-4b47-a09b-9f4de0ce0737"
        }
    }
}
```

> **注** ：クエリするデータが大量にある場合、レポートの生成に時間がかかる場合があります。

