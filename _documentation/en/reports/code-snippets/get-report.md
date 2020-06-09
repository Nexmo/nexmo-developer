---
title: Get report
navigation_weight: 7
---

# Get report

This code snippet shows you how to retrieve a report file.

## Example

Variable | Required | Description
----|----|----
`NEXMO_API_KEY` | Yes | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`NEXMO_API_SECRET` | Yes | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`FILE_ID` | Yes | The file ID of the report to retrieve.

```code_snippets
source: '_examples/reports/get-report'
```

## Try it out

1. Set the replaceable variables for your account.

2. Set the `FILE_ID`. You can obtain this from the details of a get report status or list reports call. The response will contain JSON similar to:

```json
    "download_report": {
      "href": "https://api.nexmo.com/v3/media/84a14d67-1234-5678-9012-ac042b16092a"
    }
```

In this case `84a14d67-1234-5678-9012-ac042b16092a` is the `FILE_ID`.

3. Run the script to download a Zip file containing the report in PDF format.

## See also

* [Information on valid parameters](/reports/code-snippets/before-you-begin#parameters)
* [API Reference](/api/reports)
