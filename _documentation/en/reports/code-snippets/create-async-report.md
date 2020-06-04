---
title: Create report
navigation_weight: 3
---

# Create report asynchronously

Code snippets...

## Example

Variable | Required | Description
----|----|----
`NEXMO_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`NEXMO_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | Yes | The API key for the target account. Reports generated, or records retrieved, are for this account.
`REPORT_DIRECTION` | Yes | Either `inbound` or `outbound`
`PRODUCT` | Yes | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.
`DATE_START` | Yes | Date of time window from when you want to start gathering records in ISO-8601 format.
`DATE_END` | Yes | Date of time window from when you want to stop gathering records in ISO-8601 format.

```code_snippets
source: '_examples/reports/create-async-report'
```

## Try it out

xxx
