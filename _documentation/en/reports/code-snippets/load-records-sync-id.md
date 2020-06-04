---
title: Load records by ID
navigation_weight: 1
---

# Load records synchronously by ID

Code snippets...

## Example

Variable | Required | Description
----|----|----
`NEXMO_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`NEXMO_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | Yes | The API key for the target account. Reports generated, or records retrieved, are for this account.
`REPORT_DIRECTION` | Yes | Either `inbound` or `outbound`
`PRODUCT` | Yes | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.
`ID` | Yes | The UUID of the message or call to retrieve records for.

```code_snippets
source: '_examples/reports/load-records-sync-id'
```

## Try it out

....

Need to talk about options here...
For example if product is conversation need type
Reference my variable table and also API refrence
