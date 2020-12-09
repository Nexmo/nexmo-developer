---
title:  コマンドラインを使用してCSVレポートを作成する
description:  このステップでは、コマンドラインツール`curl`を使用してレポートを作成する方法を学習します。

---

レポートの作成
=======

レポートを作成するには、`https://api.nexmo.com/v2/reports`に`POST`リクエストを送信します。リクエストに含めるパラメータによって、返されるレコードが決まります。

たとえば、2019年6月にVonageアカウントから送信されたすべてのSMSメッセージを表示するには、次のリクエストを使用します：

```bash
curl -X POST https://api.nexmo.com/v2/reports/ \
  -u $API_KEY:$API_SECRET \
  -H "Content-Type: application/json" \
  -d '{"account_id": "API_KEY","product": "SMS","direction": "outbound","date_start": "2019-06-01T00:00:00+0000","date_end": "2019-07-01T00:00:00+0000"}'
```

応答には`request_id`が含まれています。[レポートのステータスを確認](/reports/tutorials/create-and-retrieve-a-report/reports/check-report-status)するために必要になるので、これを書き留めます。

> **注** ：日付範囲を使用してフィルタすると、`start_date`は含まれますが、`end_date`は含まれません。つまり、上記の例には、`00:00:00`に送信されたSMSメッセージは含まれません。

使用可能なフィルタパラメータの全リストについては、[レポートAPIリファレンス](/api/reports)を参照してください。

