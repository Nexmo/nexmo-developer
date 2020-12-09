---
title:  レポートのステータスを確認する
description:  レポートの進捗状況を確認する

---

レポートのステータスを確認する
===============

[レポートの作成リクエスト](/reports/tutorials/create-report-using-graphical-tools/reports/create-report-postman#create-the-request)への応答で、`href`（`_links`の下）で指定されたURLに`GET`リクエストを送信して、レポートの準備ができているかどうかを確認します。

ステータス取得リクエストを作成する
-----------------

リクエストを行う手順は、次のとおりです：

1. HTTPメソッドを`GET`に変更します。
2. アドレスバーにレポート固有のURLを入力します。
3. 前の手順の説明に従って、[Authorization (認証)]タブを完了します。
4. [Body (本文)]タブで、[none (なし)]ラジオボタンを選択します。

![レポートのステータスをリクエストする](/images/reports-api/request-status-postman.png)

ステータス取得リクエストの実行
---------------

[Send (送信)]ボタンをクリックします。レスポンスの`request_status`フィールドには、`PROCESSING`または`SUCCESS`のいずれかが含まれている必要があります。`PROCESSING`の場合、さらに数分待ってから、同じステータス確認要求を繰り返します。

以下は一例です。

```json
{
    "request_id": "a68908f0-4f23-4b47-a09b-9f4de0ce0737",
    "request_status": "PROCESSING",
    "product": "SMS",
    "account_id": "NEXMO_API_KEY",
    "date_start": "2019-04-01T00:00:00+0000",
    "date_end": "2019-07-01T00:00:00+0000",
    "include_subaccounts": false,
    "direction": "outbound",
    "include_message": false,
    "receive_time": "2019-10-25T14:13:38+0000",
    "start_time": "2019-10-25T14:13:39+0000",
    "_links": {
        "self": {
            "href": "https://api.nexmo.com/v2/reports/a68908f0-4f23-4b47-a09b-9f4de0ce0737"
        },
        "download_report": {
            "href": "https://api.nexmo.com/v3/media/885f608c-76af-4c5f-a0bb-242dee60ffd8"
        }
    },
    "items_count": 45544
}
```

