---
title: Get a record by UUID
description: How to get a record by specifying a message or call UUID.
navigation_weight: 1
---

# Get a specific record by UUID

This code snippet shows you how to retrieve a specific record by specifying a **message or call** UUID. This is a synchronous call and so will block until it returns a response.

## Example

Variable | Required | Description
----|----|----
`VONAGE_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`VONAGE_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | Yes | The API key for the target account. Reports generated, or records retrieved, are for this account.
`REPORT_DIRECTION` | Yes | Either `inbound` or `outbound`
`REPORT_PRODUCT` | Yes | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.
`ID` | Yes | The UUID of the message or call to retrieve records for.

```code_snippets
source: '_examples/reports/load-records-sync-id'
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
      "href": "https://api.nexmo.com/v2/reports/records?account_id=abcd1234&product=SMS&direction=outbound&id=15000000E1F8B123"
    }
  },
  "request_id": "0ec00351-5357-4321-9a08-fa3d4a4e1234",
  "request_status": "SUCCESS",
  "id": "15000000E1F8B123",
  "received_at": "2020-06-04T11:55:42+0000",
  "price": 0.0,
  "currency": "EUR",
  "account_id": "abcd1234",
  "product": "SMS",
  "direction": "outbound",
  "include_message": false,
  "items_count": 1,
  "records": [
    {
      "account_id": "abcd1234",
      "message_id": "15000000E1F8B123",
      "client_ref": null,
      "direction": "outbound",
      "from": "Vonage APIs",
      "to": "447700123456",
      "network": "23410",
      "network_name": "Telefonica UK Limited",
      "country": "GB",
      "country_name": "United Kingdom",
      "date_received": "2020-06-01T15:08:10+0000",
      "date_finalized": "2020-06-01T15:08:11+0000",
      "latency": "1366",
      "status": "delivered",
      "error_code": "0",
      "error_code_description": "Delivered",
      "currency": "EUR",
      "total_price": "0.03330000"
    }
  ]
}
```

## See also

* [Information on valid parameters](/reports/code-snippets/before-you-begin#parameters)
* [API Reference](/api/reports)
