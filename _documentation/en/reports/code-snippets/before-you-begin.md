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
`PRODUCT` | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.

## Product

Product specifies the product for which reports and records are obtained. It can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`. In the following examples this is usually hard-coded into the example, as the parameters passed to the API call may depend on the product specified.

## Date ranges

For many of the calls you can specify either an ID or a date range, but not both. The date ranges are from oldest to newest and are in ISO-8601 format. The dates can use either of the following formats: `yyyy-mm-ddThh:mm:ss[.sss]±hh:mm` or `yyyy-mm-ddThh:mm:ss[.sss]Z`. A maximum window of 24 hours may be specified.

### Example

This example shows fetching a list of records using a date range:

```sh
curl -u "$NEXMO_API_KEY:$NEXMO_API_SECRET" \
     "https://api.nexmo.com/v2/reports/records?account_id=$ACCOUNT_ID&product=MESSAGES&direction=$REPORT_DIRECTION&date_start=2020-06-04T00:01:00Z&date_end=2020-06-04T00:02:00Z"
```

## Parameters

The parameters specified in API calls may vary with product. The following table shows use of a parameter for different products:

Parameter | SMS | VOICE-CALL | VERIFY-API | NUMBER-INSIGHT | MESSAGES | CONVERSATION
----|----|----|----|----|----|----
`direction` | required | optional | invalid | invalid | optional | invalid
`type` | invalid | invalid | invalid | invalid | invalid | required
`status` | optional | optional | invalid | invalid | optional  | optional
`include_message` | optional | invalid | invalid | invalid | optional | invalid

> `status` is invalid if ID specified in request.
