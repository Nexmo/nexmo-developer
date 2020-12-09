---
title:  レポートのステータスを確認する
description:  レポートの進捗状況を確認する

---

レポートのステータスを確認する
===============

レポートがリクエストされると、生成に時間がかかる場合があります。`GET /v2/reports/:id`エンドポイントを呼び出して、レポートの進行状況を確認できます。次に例を示します：

```bash
curl -u API_KEY:API_SECRET https://api.nexmo.com/v2/reports/REQUEST_ID
```

`REQUEST_ID`を、[レポート作成エンドポイントへの最初の呼び出し](/reports/tutorials/create-and-retrieve-a-report/reports/create-report)によって返された`request_id`に置き換えます。

> レポートのステータスのポーリングに加えて、レポートが生成されたときにVonageのAPIがリクエストするWebhookを登録できます。これを行うには、レポートの作成時に`callback_url`パラメータを指定します。

応答には、レポートに関する情報が含まれます。この`download_report`フィールドは、レポートの生成が完了したときにのみ表示されます。次の手順に示すように、これを使用して[レポートを取得](/reports/tutorials/create-and-retrieve-a-report/reports/download-report)できます。

```json
{
  "request_id": "6c5506b7-f16a-44dc-af06-756bbf467488",
  "request_status": "SUCCESS",
  "product": "SMS",
  "account_id": "$API_KEY",
  "date_start": "2019-02-27T00:00:00+0000",
  "date_end": "2019-02-28T23:59:59+0000",
  "include_subaccounts": false,
  "direction": "outbound",
  "include_message": false,
  "receive_time": "2019-06-17T16:39:06+0000",
  "start_time": "2019-06-17T16:39:06+0000",
  "_links": {
    "self": {
      "href": "https://api.nexmo.com/v2/reports/6c5506b7-f16a-44dc-af06-756bbf467488"
    },
    "download_report": {
      "href": "https://api.nexmo.com/v3/media/b003ed27-b4b2-4a7d-b4a5-6255ce08eea5"
    }
  },
  "items_count": 14952
}
```

