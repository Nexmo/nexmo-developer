## Parameters

The parameters specified in API calls may vary with product. The following table shows use of a parameter for different products:

Parameter | SMS | VOICE-CALL | VERIFY-API | NUMBER-INSIGHT | MESSAGES | CONVERSATIONS | Description
----|----|----|----|----|----|----|----
`direction` | **required** | optional | invalid | invalid | optional | invalid | Direction of messages or call. Can be `inbound` or `outbound`.
`type` | invalid | invalid | invalid | invalid | invalid | **required** | For `CONVERSATIONS` only. Can be `ip-voice` or `cs-custom-event`.
`status` | optional | optional | invalid | invalid | optional  | optional | Checks for records with specified status. For example `delivered` (for messages) or `answered` (for a voice call). For report status checking it may be `SUCCESS` or one of the other supported values.
`include_message` | optional | invalid | invalid | invalid | optional | invalid | If `true`, the body of the message will be included in the response.

> `status` is invalid if ID is specified in request.

Other parameters such as ID and data ranges may be required depending on the API call. **Note, you can specify a date range or an ID for some calls, but not both.**

Parameter | Load records sync | Generate report async | List reports | Get report status | Cancel report | Get report | Notes
----|----|----|----|----|----|----|----|----
`product` | **required** | **required** | not used | not used | not used | not used | Required to load records or generate reports
`id` | optional | optional | not used | not used | not used | not used | Invalid if date range specified
`date_start`, `date_end` | optional | optional | optional | not used | not used | not used | Invalid if ID is specified
