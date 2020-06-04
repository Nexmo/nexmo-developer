---
title: Before you Begin
navigation_weight: 0
---

# Before you Begin

Some tips on using the Reports API code snippets.

## Common variables

When you use the code snippets you copy in your replacements for variables such as your API key and API secret, as well as other variables that control the API request. Some commonly replaced variables are shown in the following table:

Variable | Description
----|----
`NEXMO_API_KEY` | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`NEXMO_API_SECRET` | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | The account ID (same as `NEXMO_API_KEY`) for the account you want to generate reports, or retrieve records for.
`REPORT_PRODUCT` | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.
`REQUEST_ID` | When you request creation of report asynchronously, a `request_id` for the report generation is returned.
`DATE_START` | Date of time window from when you want to start gathering records in ISO-8601 format.
`DATE_END` | Date of time window from when you want to stop gathering records in ISO-8601 format.

## Product

The _product_ specifies the product for which reports and records are obtained. Product can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.

> In the following examples you can enter the product you want, but please note that some parameters are required for certain products, for example, `CONVERSATIONS` requires `type`. See also [parameters](#parameters).

## Date ranges

For many of the calls you can specify either an ID or a date range, but not both. The date ranges are from oldest to newest and are in ISO-8601 format.

The dates can use either of the following formats: `yyyy-mm-ddThh:mm:ss[.sss]±hh:mm` or `yyyy-mm-ddThh:mm:ss[.sss]Z`. A maximum window of 24 hours may be specified.

### Example

This example shows fetching a list of records using a date range:

```sh
curl -u "$NEXMO_API_KEY:$NEXMO_API_SECRET" \
     "https://api.nexmo.com/v2/reports/records?account_id=abcd1234&product=MESSAGES&direction=outbound&date_start=2020-06-04T00:01:00Z&date_end=2020-06-04T00:02:00Z"
```

## Parameters

The parameters specified in API calls may vary with product. The following table shows use of a parameter for different products:

Parameter | SMS | VOICE-CALL | VERIFY-API | NUMBER-INSIGHT | MESSAGES | CONVERSATIONS | Description
----|----|----|----|----|----|----|----
`direction` | required | optional | invalid | invalid | optional | invalid | Direction of messages or call. Can be `inbound` or `outbound`.
`type` | invalid | invalid | invalid | invalid | invalid | required | For `CONVERSATIONS` only. Can be `ip-voice` or `cs-custom-event`.
`status` | optional | optional | invalid | invalid | optional  | optional | Checks for records with specified status. For example `delivered` (for messages) or `answered` (for a voice call). For report status checking it may be `SUCCESS` or one of the other supported values.
`include_message` | optional | invalid | invalid | invalid | optional | invalid | If `true`, the body of the message will be included in the response.

> `status` is invalid if ID is specified in request.

## Request ID

When you request asynchronous creation of a report, a request ID will be returned. You can use this in subsequent calls, for example to check on report status, or cancel a report. An example response to an asynchronous report creation request is as follows:

```json
{
  "request_id": "ri3p58f-48598ea7-1234-5678-9012-faabd79bdc2e",
  "request_status": "PENDING",
  "direction": "outbound",
  "product": "SMS",
  "account_id": "abcd1234",
  "date_start": "2020-05-21T13:27:00+0000",
  "date_end": "2020-05-21T13:57:00+0000",
  "include_subaccounts": false,
  "status": "delivered",
  "include_message": false,
  "receive_time": "2020-06-03T15:24:31+0000",
  "_links": {
    "self": {
      "href": "https://api.nexmo.com/v2/reports/ri3p58f-48598ea7-cb2d-1234-5678-fa1234567890"
    }
  }
}
```
