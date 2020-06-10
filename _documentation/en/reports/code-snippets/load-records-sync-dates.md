---
title: Get records by dates
description: Retrieve records synchronously using a date range (limited to a maximum period of 24 hours). 
navigation_weight: 2
---

# Get records synchronously by date range

This code snippet shows you how to retrieve a set of records using a date range. This is a synchronous call, and so will block until it returns a response. It is used where you want to return a limited number of records (thousands) immediately. If you want to obtain large numbers of records (millions) use [Create Report](/reports/code-snippets/create-async-report).

**Date ranges are limited to a window of 24 hours for synchronous queries.**

## Example

Variable | Required | Description
----|----|----
`NEXMO_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`NEXMO_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | Yes | The API key for the target account. Reports generated, or records retrieved, are for this account.
`REPORT_DIRECTION` | Yes | Either `inbound` or `outbound`
`REPORT_PRODUCT` | Yes | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.
`DATE_START` | Yes | Date of time window from when you want to start gathering records in ISO-8601 format.
`DATE_END` | Yes | Date of time window from when you want to stop gathering records in ISO-8601 format.

```code_snippets
source: '_examples/reports/load-records-sync-dates'
```

## Try it out

1. Set the replaceable variables for your account.  

2. For this example, set `REPORT_PRODUCT` to `SMS`.

3. Using the table as a guide set values for the remaining variables.

4. Run the script and you receive a response similar to the following:

```json
{
  "_links": {
    "self": {
      "href": "https://api.nexmo.com/v2/reports/records?account_id=abcd1234&product=SMS&direction=outbound&date_start=2020-06-04T08%3A00%3A00Z&date_end=2020-06-04T14%3A00%3A00Z&status=delivered"
    }
  },
  "request_id": "450b434a-ff4f-40f1-80a5-8d6e24d91234",
  "request_status": "SUCCESS",
  "received_at": "2020-06-04T12:22:25+0000",
  "price": 0.0,
  "currency": "EUR",
  "direction": "outbound",
  "product": "SMS",
  "account_id": "abcd1234",
  "date_start": "2020-06-04T08:00:00+0000",
  "date_end": "2020-06-04T14:00:00+0000",
  "include_subaccounts": false,
  "status": "delivered",
  "include_message": false,
  "items_count": 2,
  "records": [
    {
      "account_id": "abcd1234",
      "message_id": "12000000E506AC66",
      "client_ref": null,
      "direction": "outbound",
      "from": "Acme Inc.",
      "to": "447700123456",
      "network": "23410",
      "network_name": "Telefonica UK Limited",
      "country": "GB",
      "country_name": "United Kingdom",
      "date_received": "2020-06-04T12:21:35+0000",
      "date_finalized": "2020-06-04T12:21:37+0000",
      "latency": "2274",
      "status": "delivered",
      "error_code": "0",
      "error_code_description": "Delivered",
      "currency": "EUR",
      "total_price": "0.03330000"
    },
    ...
  ]
}
```

## See also

* [Information on valid parameters](/reports/code-snippets/before-you-begin#parameters)
* [API Reference](/api/reports)
