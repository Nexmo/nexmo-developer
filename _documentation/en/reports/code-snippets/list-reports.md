---
title: List reports
navigation_weight: 4
---

# List reports

List reports stuff ...

## Example

Variable | Required | Description
----|----|----
`NEXMO_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`NEXMO_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | Yes | The API key for the target account. Reports generated, or records retrieved, are for this account.
`REPORT_STATUS` | Yes | Can be one of `PENDING`, `PROCESSING`, `SUCCESS`, `ABORTED`, `FAILED`, `TRUNCATED`.

```code_snippets
source: '_examples/reports/list-reports'
```
