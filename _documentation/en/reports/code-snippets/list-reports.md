---
title: List reports
description: Obtain a list of all asynchronously requested reports.
navigation_weight: 4
---

# List reports

This code snippet shows you how to list all asynchronous report requests with the specified status. If required, you can also specify a date range.

## Example

Variable | Required | Description
----|----|----
`VONAGE_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`VONAGE_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | Yes | The API key for the target account. Reports generated, or records retrieved, are for this account.
`REPORT_STATUS` | Yes | A comma-separated list of report status values. Reports with any of the statuses specified are returned. The values in the comma-separated list specified for `status` can be any of `PENDING`, `PROCESSING`, `SUCCESS`, `ABORTED`, `FAILED`, `TRUNCATED`.

If you don't specify a date range, you receive the reports generated over the previous seven days.

```code_snippets
source: '_examples/reports/list-reports'
```

## Try it out

1. Set the replaceable variables. [Parameter](/reports/code-snippets/before-you-begin#parameters) validity may vary with [product](/reports/code-snippets/before-you-begin#product).

2. Run the script and you receive a response similar to the following:

```json
{
  "self_link": "https://api.nexmo.com/v2/reports?account_id=abcd1234&status=SUCCESS",
  "items_count": 17,
  "reports": [
    {
      "request_id": "ri3p58f-48598ea7-1234-5678-90ab-faabd79abcde",
      "request_status": "SUCCESS",
      "direction": "outbound",
      "product": "SMS",
      "account_id": "abcd1234",
      "date_start": "2020-05-21T13:27:00+0000",
      "date_end": "2020-05-21T13:57:00+0000",
      "include_subaccounts": false,
      "status": "delivered",
      "include_message": false,
      "receive_time": "2020-06-03T15:24:31+0000",
      "start_time": "2020-06-03T15:24:32+0000",
      "_links": {
        "self": {
          "href": "https://api.nexmo.com/v2/reports/ri3p58f-48598ea7-1234-5678-90ab-faabd79abcde"
        },
        "download_report": {
          "href": "https://api.nexmo.com/v3/media/e87a2d7c-abcd-1234-aa45-9bf17a1eb2a1"
        }
      },
      "items_count": 4
    },
    ...
  ]
}
```

Note the report `request_id` is in the response. Also the `file_id`, in this case `e87a2d7c-abcd-1234-aa45-9bf17a1eb2a1`.

## See also

* [Information on valid parameters](/reports/code-snippets/before-you-begin#parameters)
* [API Reference](/api/reports)
