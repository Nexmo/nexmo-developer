---
title: Request a report
description: Submit the initial request to create a report
---

# Request a report

In the Postman workspace, set the HTTP method to `POST` and enter the following URL: `https://api.nexmo.com/v2/reports/`

You then need to:

* [Authorize the request](#authorize-the-request)
* [Format the request body](#format-the-request-body)
* [Create the request](#create-the-request)
* [Execute the request](#execute-the-request)

## Authorize the request

Select the "Authorization" tab and enter the following values:

* Type: `Basic Auth`
* Username: Your Nexmo API key
* Password: Your Nexmo API secret

> **Note**: You can find your API key and secret in the [developer dashboard](https://dashboard.nexmo.com).

![Create Report](/assets/images/reports-api/create-report-postman.png)

## Format the request body

In the "Body" tab select the "raw" radio button and "JSON" from the dropdown list of formats:

![Format the request](/assets/images/reports-api/format-request-body-postman.png)

## Create the request

In the "Body" tab, enter the request body as shown below, replacing  `NEXMO_API_KEY` with your own API key and `date_start` and `date_end` with suitable values for the time period you are interested in.

> **Note**: The `end_date` parameter is exclusive - the report generated  covers the period from `start_date` to just before the time and date specified in `end_date`.

### For an SMS report

![Create SMS report request](/assets/images/reports-api/create-request-body-sms-postman.png)

### For a Voice report

![Create SMS report request](/assets/images/reports-api/create-request-body-voice-postman.png)

> **Note**: The `product` must be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATION`.

## Execute the request

Click the "Send" button. The response will appear in the following format:

```json
{
    "request_id": "a68908f0-4f23-4b47-a09b-9f4de0ce0737",
    "request_status": "PENDING",
    "product": "SMS",
    "account_id": "NEXMO_API_KEY",
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

> **Note**: If there is a large volume of data to query, the report can take a while to generate.