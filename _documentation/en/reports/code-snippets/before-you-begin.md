---
title: Before you Begin
description: Some tips on how to get started using the Reports API code snippets.
navigation_weight: 0
---

# Before you Begin

Some tips on using the Reports API code snippets. Also please review the [Overview](/reports/overview) and refer to the [API Reference](/api/reports). Call Details Records (CDRs) are often referred to in these topics as 'records'.

## In this topic

* [Query methods](#query-methods)
* [Common variables](#common-variables)
* [Request parameters](#request-parameters)
* [Further request examples](#further-request-examples)
* [Request ID](#request-id)
* [File ID](#file-id)
* [See also](#see-also)

## Query methods

The Reports API allows you to retrieve Call Details Records (CDRs), either **synchronously** or **asynchronously**. The synchronous approach is blocking and used where you want to obtain a small number of records (thousands). The records are returned in an array in the response.

If you want to run queries that will retrieve a vast number of records (millions), that may take longer, and is best done using an asynchronous approach. Usually an asynchronous request will take a callback URL parameter and POST a notification to the callback URL when the operation completes. The other option is to periodically query report status. The result using the asynchronous approach will be the generation of a Zip file containing a CSV file of records.

## Common variables

When you use the code snippets you copy in your replacements for variables such as your API key and API secret, as well as other variables that control the API request. Some commonly replaced variables are shown in the following table:

Variable | Description
----|----
`VONAGE_API_KEY` | Your API key which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`VONAGE_API_SECRET` | Your API secret which you can obtain from your [Dashboard](https://dashboard.nexmo.com/sign-in).
`ACCOUNT_ID` | The account ID (same as `VONAGE_API_KEY`) for the account you want to generate reports, or retrieve records for.
`REPORT_PRODUCT` | Specifies the product for which reports and records are obtained. Can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.
`REQUEST_ID` | When you request creation of report asynchronously, a `request_id` for the report generation is returned.
`DATE_START` | Date of time window from when you want to start gathering records in ISO-8601 format.
`DATE_END` | Date of time window from when you want to stop gathering records in ISO-8601 format.
`STATUS` | Status of message or call.
`REPORT_STATUS` | Status of report generation, can be any of `PENDING`, `PROCESSING`, `SUCCESS`, `ABORTED`, `FAILED`, `TRUNCATED`. For [report listing](/reports/code-snippets/list-reports), `status` is passed in as a comma-separated list of report status values.

> In the following examples you can enter the product you want, but please note that some parameters are required for certain products, for example, `CONVERSATIONS` requires `type`.

## Request parameters

This section describes the main parameters and when to use them.

### ID

This is the UUID of the message or call you require a record for.

### Date ranges

For many of the calls you can specify either a message or call ID or a date range, but not both. The date ranges are from oldest to newest and are in ISO-8601 format.

The dates can use either of the following formats: `yyyy-mm-ddThh:mm:ss[.sss]±hhmm` or `yyyy-mm-ddThh:mm:ss[.sss]Z`.

This example shows fetching a list of records using a date range:

```sh
curl -u "$VONAGE_API_KEY:$VONAGE_API_SECRET" \
     "https://api.nexmo.com/v2/reports/records?account_id=abcd1234&product=MESSAGES&direction=outbound&date_start=2020-06-04T00:01:00Z&date_end=2020-06-04T00:02:00Z"
```

For dates containing a `+` in a `GET` query, where dates are passed as query parameters, you need to URL encode the dates, for example:

```sh
curl -G --data-urlencode date_start="2020-06-04T08:00:00+0000" --data-urlencode date_end="2020-06-04T14:00:00+0000" -u "$VONAGE_API_KEY:$VONAGE_API_SECRET" \
     "https://api.nexmo.com/v2/reports/records?account_id=abcd1234&product=SMS&direction=outbound"
```

### Product

The API calls Load Records Synchronously and Generate Report Asynchronously require you to specify a product. The `product` parameter specifies the Vonage API product for which reports and records are obtained. `product` can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.

The following table shows which API call use `product`:

Parameter | Load records sync | Generate report async | List reports | Get report status | Cancel report | Get report | Notes
----|:----:|:----:|:----:|:----:|:----:|:----:|:----:|----
`product` | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | Required to load records or generate reports. One of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.

**Table legend:** ✅ = required | ❌ = n/a

### Request parameters for Load Records Synchronously

The parameters specified in API calls may vary depending on the `product` specified. The following table shows use of a parameter for different products:

Parameter | SMS | Voice | Verify | Number Insight | Messages | Conversations | Description |
----------|:---:|:-----:|:------:|:--------------:|:--------:|:-------------:|:-----------:|
`product` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
`account_id` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Account to obtain records for.
`direction` | ✅ | 🔸 | ❌ | ❌ | ✅ | ❌ | Direction of messages or call. Can be `inbound` or `outbound`. |
`id` | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | Invalid if date range specified. |
`date_start` | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | Invalid if `id` specified. |
`date_end` | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | Invalid if `id` specified. |
`include_message` | 🔸 | ❌ | ❌ | ❌ | 🔸 | ❌ | If `true` include the body of the text message.
`type` | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | For `CONVERSATIONS` only. Can be `ip-voice` or `cs-custom-event`. |
`status` | 🔸 | 🔸 | ❌ | ❌ | 🔸 | ❌ | Checks for records with specified status. For example `delivered` (for messages) or `answered` (for a voice call). For report status checking it may be `SUCCESS` or one of the other supported values. |

**Table legend:** ✅ = required | 🔸 = optional | ❌ = n/a

### Request parameters for Create Asynchronous Report

The parameters specified in API calls may vary depending on the `product` specified. The following table shows use of a parameter for different products:

Parameter | SMS | Voice | Verify | Number Insight | Messages | Conversations | Description |
----------|:---:|:-----:|:------:|:--------------:|:--------:|:-------------:|:-----------:|
`product` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Required to load records or generate reports. |
`account_id` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
`direction` | ✅ | 🔸 | ❌ | ❌ | ✅ | ❌ | Direction of messages or call. Can be `inbound` or `outbound`. |
`date_start` | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 |
`date_end` | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 |
`include_subaccounts` | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 |
`callback_url` | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 | 🔸 |
`status` | 🔸 | 🔸 | ❌ | ❌ | 🔸 | 🔸 | Checks for records with specified status. For example `delivered` (for messages) or `answered` (for a voice call). For report status checking it may be `SUCCESS` or one of the other supported values. |
`client_ref` | 🔸 | ❌ | ❌ | ❌ | ❌ | ❌ |
`account_ref` | 🔸 | ❌ | ❌ | ❌ | ❌ | ❌ |
`include_message` | 🔸 | ❌ | ❌ | ❌ | 🔸 | ❌ | If `true`, the body of the message will be included in the response. |
`network` | 🔸 | 🔸 | 🔸 | 🔸 | ❌ | ❌ |
`from` | 🔸 | 🔸 | ❌ | ❌ | 🔸 | ❌ |
`to` | 🔸 | 🔸 | 🔸 | ❌ | 🔸 | ❌ |
`number` | ❌ | ❌ | ❌ | 🔸 | ❌ | ❌ |
`id` | ❌ | ❌ | ❌ | ❌ | 🔸 | ❌ |
`type` | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | For `CONVERSATIONS` only. Can be `ip-voice` or `cs-custom-event`.

**Table legend:** ✅ = required | 🔸 = optional | ❌ = n/a

> These parameter tables do not include all available parameters. See the [API Reference](/api/reports) for all parameters.

## Further request examples

You can find many examples of Reports API calls in the [Curl code snippet repository](https://github.com/Nexmo/nexmo-curl-code-snippets). These examples show some additional calls in addition to the ones shown in the [code snippet section](/reports/code-snippets/before-you-begin) here, and also demonstrate the use of product-specific parameters.

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

## File ID

The `file_id` is required to retrieve an asynchronously created report file. You can obtain the `file_id` from the details of a [get report status](/reports/code-snippets/get-report-status) or [list reports](/reports/code-snippets/list-reports) call, or from the completion callback body. The response will contain JSON similar to:

```json
    ...
    "download_report": {
    "href": "https://api.nexmo.com/v3/media/84a14d67-1234-5678-9012-ac042b16092a"
    }
```

In this case `84a14d67-1234-5678-9012-ac042b16092a` is the `FILE_ID`.

## See also

* [API Reference](/api/reports)
