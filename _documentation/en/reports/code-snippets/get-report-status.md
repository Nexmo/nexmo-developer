---
title: Get report status
description: Allows you to retrieve the status of asynchronous report generation.
navigation_weight: 5
---

# Get report status

This code snippet shows you how to obtain the status of a report. It is often used to determine whether a report generation has successfully completed or not.

## Example

Variable | Required | Description
----|----|----
`NEXMO_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`NEXMO_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`REQUEST_ID` | Yes | The request ID of the report to check the status of.

```code_snippets
source: '_examples/reports/get-report-status'
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

The `file_id` is also returned in the response, in this case `e87a2d7c-abcd-1234-aa45-9bf17a1eb2a1`. The `file_id` is used to subsequently download a report Zip file.

## See also

* [Information on valid parameters](/reports/code-snippets/before-you-begin#parameters)
* [API Reference](/api/reports)
