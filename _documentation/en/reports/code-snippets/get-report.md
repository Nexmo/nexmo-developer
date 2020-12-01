---
title: Download report file
description: Retrieve the report file generated as a result of a asynchronous report generation request.
navigation_weight: 6
---

# Download report file

This code snippet shows you how to retrieve a report file. The report file is a Zipped CSV file containing all the records for the request.

## Example

```snippet_variables
- VONAGE_API_KEY
- VONAGE_API_SECRET
- FILE_ID.REPORTS
```

```code_snippets
source: '_examples/reports/get-report'
```

## Try it out

1. Set the replaceable variables for your account.
2. Set the `FILE_ID`. You can obtain this from the details of a [get report status](/reports/code-snippets/get-report-status) or [list reports](/reports/code-snippets/list-reports) call. The response will contain JSON similar to:

    ```json
        "download_report": {
        "href": "https://api.nexmo.com/v3/media/84a14d67-1234-5678-9012-ac042b16092a"
        }
    ```

    In this case `84a14d67-1234-5678-9012-ac042b16092a` is the `FILE_ID`.
3. Run the script to download a Zip file containing the report in CSV format.

## See also

* [Information on valid parameters](/reports/code-snippets/before-you-begin#parameters)
* [API Reference](/api/reports)
