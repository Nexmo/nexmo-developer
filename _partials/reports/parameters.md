## Parameters

This section describes the main parameters and when to use them.

### Product

The API calls Load Records Synchronously and Generate Report Asynchronously require you to specify a product. The `product` parameter specifies the Vonage API product for which reports and records are obtained. `product` can be one of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.

### ID

This is the UUID of the message or call you require a record for.

### Date ranges

For many of the calls you can specify either a message or call ID or a date range, but not both. The date ranges are from oldest to newest and are in ISO-8601 format.

The dates can use either of the following formats: `yyyy-mm-ddThh:mm:ss[.sss]±hh:mm` or `yyyy-mm-ddThh:mm:ss[.sss]Z`.

This example shows fetching a list of records using a date range:

```sh
curl -u "$NEXMO_API_KEY:$NEXMO_API_SECRET" \
     "https://api.nexmo.com/v2/reports/records?account_id=abcd1234&product=MESSAGES&direction=outbound&date_start=2020-06-04T00:01:00Z&date_end=2020-06-04T00:02:00Z"
```

### Usage

The following table shows which API call use `product` and either `id` or a date range:

Parameter | Load records sync | Generate report async | List reports | Get report status | Cancel report | Get report | Notes
----|----|----|----|----|----|----|----|----
`product` | **required** | **required** | not used | not used | not used | not used | Required to load records or generate reports
`id` | optional | optional | not used | not used | not used | not used | Invalid if date range specified
`date_start`, `date_end` | optional | optional | optional | not used | not used | not used | Invalid if ID is specified
`include_subaccounts` | invalid | optional | not used | not used | not used | not used | Include subaccounts in report generation

Further, the parameters specified in API calls may vary depending on the `product` specified. The following table shows use of a parameter for different products:

Parameter | SMS | VOICE-CALL | VERIFY-API | NUMBER-INSIGHT | MESSAGES | CONVERSATIONS | Description
----|----|----|----|----|----|----|----
`direction` | **required** | optional | invalid | invalid | **required** | invalid | Direction of messages or call. Can be `inbound` or `outbound`.
`type` | invalid | invalid | invalid | invalid | invalid | **required** | For `CONVERSATIONS` only. Can be `ip-voice` or `cs-custom-event`.
`status` | optional | optional | invalid | invalid | optional  | optional | Checks for records with specified status. For example `delivered` (for messages) or `answered` (for a voice call). For report status checking it may be `SUCCESS` or one of the other supported values. `status` is invalid if ID is specified in request.
`include_message` | optional | invalid | invalid | invalid | optional | invalid | If `true`, the body of the message will be included in the response.

> These parameter tables do not include all available parameters. See the [API Reference](/api/reports) for all parameters.

### Examples

You can find many examples of Reports API calls in the [Curl code snippet repository](https://github.com/Nexmo/nexmo-curl-code-snippets). These examples show some additional calls in addition to the ones shown in the [code snippet section](/reports/code-snippets/before-you-begin) here, and also demonstrate the use of product-specific parameters.
