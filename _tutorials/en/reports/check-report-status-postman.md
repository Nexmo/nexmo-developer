---
title: Check the report status
description: Check on the progress of your report
---

# Check the report status

Check if your report is ready by making a `GET` request to the URL specified in `href` (under `_links`) in the response to your [create report request](/reports/tutorials/create-report-using-graphical-tools/reports/create-report-postman#create-the-request).

## Create the get status request

To make the request:

1. Change the HTTP method to `GET`.
2. Enter the report-specific URL in the address bar.
3. Complete the "Authorization" tab as described in the preceding step.
4. In the "Body" tab, select the "none" radio button.

![Request the report status](/assets/images/reports-api/request-status-postman.png)

## Execute the get status request

Click the "Send" button. The `request_status` field in the response should contain either `PROCESSING` or `SUCCESS`. If it is `PROCESSING`, wait a few more minutes before repeating the same check status request.

For example:

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
