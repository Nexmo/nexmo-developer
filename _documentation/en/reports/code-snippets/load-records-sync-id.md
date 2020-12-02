---
title: Get records by UUID
description: How to fetch a record by specifying a message or call UUID. You can also retrieve multiple records by specifying a comma-separated list of UUIDs.
navigation_weight: 1
---

# Get specific records by UUID

This code snippet shows you how to retrieve a specific record by specifying a **message or call** UUID. It is also possible to specify a comma-separated list of UUIDs to retrieve multiple records, for example:

``` shell
curl -u "$VONAGE_API_KEY:$VONAGE_API_SECRET" https://api.nexmo.com/v2/reports/records?account_id=abcd1234&product=VERIFY-API&id=7b1091b8-1a05-11eb-bad9-38f9d331493,7b109636-1a05-11eb-bad9-38f9d3316493,7b109a1e-1a05-11eb-bad9-38f9d3316493,7b10a0c2-1a05-11eb-bad9-38f9d331649
```

If records corresponding to any of the specified UUIDs are not found, then a list of those not found are returned in the `ids_not_found` parameter, for example:

``` json
"ids_not_found": "7b10a0c2-1a05-11eb-bad9-38f9d331649,7b1091b8-1a05-11eb-bad9-38f9d331493"
```

> **NOTE:** This is a synchronous call and so will block until it returns a response.

## Example

Variable | Required | Description
----|----|----
`VONAGE_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`VONAGE_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | Yes | The API key for the target account. Reports generated, or records retrieved, are for this account.
`REPORT_DIRECTION` | Yes | Either `inbound` or `outbound`
`REPORT_PRODUCT` | Yes | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `WEBSOCKET-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES`, `CONVERSATIONS`, or `ASR`.
`ID` | Yes | The UUID of the message or call to retrieve record for. It is possible to specify a comma-separated list of UUIDs to retrieve multiple records.

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
