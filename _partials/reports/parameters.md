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

### Product

The following table shows which API call use `product`:

Parameter | Load records sync | Generate report async | List reports | Get report status | Cancel report | Get report | Notes
----|----|----|----|----|----|----|----|----
`product` | **required** | **required** | not used | not used | not used | not used | Required to load records or generate reports. One of `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT`, `MESSAGES` or `CONVERSATIONS`.

### Load records synchronously

The parameters specified in API calls may vary depending on the `product` specified. The following table shows use of a parameter for different products:

Parameter | SMS | Voice | Verify | Number Insight | Messages | Conversations | Description |
----------|-----|-------|--------|----------------|----------|---------------|-------------|
`product` | required | required | required | required | required | required |
`account_id` | required | required | required | required | required | required | Account to obtain records for.
`direction` | required | optional | n/a | n/a | required | n/a | Direction of messages or call. Can be `inbound` or `outbound`. |
`id` | optional | optional | optional | optional | optional | optional | Invalid if date range specified. |
`date_start` | optional | optional | optional | optional | optional | optional | Invalid if `id` specified. |
`date_end` | optional | optional | optional | optional | optional | optional | Invalid if `id` specified. |
`include_message` | optional | n/a | n/a | n/a | optional | n/a | If `true` include the body of the text message.
`type` | n/a | n/a | n/a | n/a | n/a | required | For `CONVERSATIONS` only. Can be `ip-voice` or `cs-custom-event`. |
`status` | optional | optional | n/a | n/a | optional | n/a | Checks for records with specified status. For example `delivered` (for messages) or `answered` (for a voice call). For report status checking it may be `SUCCESS` or one of the other supported values. |

### Create asynchronous report parameters

The parameters specified in API calls may vary depending on the `product` specified. The following table shows use of a parameter for different products:

Parameter | SMS | Voice | Verify | Number Insight | Messages | Conversations | Description |
----------|-----|-------|--------|----------------|----------|---------------|-------------|
`product` | required | required | required | required | required | required | Required to load records or generate reports. |
`account_id` | required | required | required | required | required | required |
`direction` | required | optional | n/a | n/a | required | n/a | Direction of messages or call. Can be `inbound` or `outbound`. |
`date_start` | optional | optional | optional | optional | optional | optional |
`date_end` | optional | optional | optional | optional | optional | optional |
`include_subaccounts` | optional | optional | optional | optional | optional | optional |
`callback_url` | optional | optional | optional | optional | optional | optional |
`status` | optional | optional | n/a | n/a | optional | optional | Checks for records with specified status. For example `delivered` (for messages) or `answered` (for a voice call). For report status checking it may be `SUCCESS` or one of the other supported values. |
`client_ref` | optional | n/a | n/a | n/a | n/a | n/a |
`account_ref` | optional | n/a | n/a | n/a | n/a | n/a |
`include_message` | optional | n/a | n/a | n/a | optional | n/a | If `true`, the body of the message will be included in the response. |
`network` | optional | optional | optional | optional | n/a | n/a |
`from` | optional | optional | n/a | n/a | optional | n/a |
`to` | optional | optional | optional | n/a | optional | n/a |
`number` | n/a | n/a | n/a | optional | n/a | n/a |
`id` | n/a | n/a | n/a | n/a | optional | n/a |
`type` | n/a | n/a | n/a | n/a | n/a | required | For `CONVERSATIONS` only. Can be `ip-voice` or `cs-custom-event`.

> These parameter tables do not include all available parameters. See the [API Reference](/api/reports) for all parameters.

### Examples

You can find many examples of Reports API calls in the [Curl code snippet repository](https://github.com/Nexmo/nexmo-curl-code-snippets). These examples show some additional calls in addition to the ones shown in the [code snippet section](/reports/code-snippets/before-you-begin) here, and also demonstrate the use of product-specific parameters.
