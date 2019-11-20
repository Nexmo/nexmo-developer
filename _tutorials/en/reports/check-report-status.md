---
title: Check report status
---

# Check report status

Once a report has been requested, it may take some time to generate. You can check on the progress of your report by calling the `GET /v2/reports/:id` endpoint, for example:

```bash
curl -u API_KEY:API_SECRET https://api.nexmo.com/v2/reports/REQUEST_ID
```

Replace `REQUEST_ID` with the `request_id` returned by the [initial call to the create report endpoint](/reports/tutorials/create-and-retrieve-a-report/reports/create-report).

> In addition to polling for the report's status, you can register a webhook that Nexmo's APIs will make a request to when the report has been generated. To do this, specify a `callback_url` parameter when creating the report.

The response will contain information about the report. The `download_report` field only becomes visible when the report generation is completed. You can use it to [retrieve the report](/reports/tutorials/create-and-retrieve-a-report/reports/download-report), as will be shown in the next step.

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
