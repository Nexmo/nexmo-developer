---
title: Developer - Messages API Reference
description: Reference guide for the Messages API.
api: Developer API
---

# Developer - Messages API Reference

> <strong>Please note that the Messages API is rate limited to one request per second.</strong>

> This API is intended for use during development and is not intended as a replacement for handling callbacks using a webhook

## Messages

The Messages API lets you retrieve messages you have sent via the SMS API by ID, as well as retrieve details of messages that were rejected.

The default response is JSON, but you can specify XML by providing an `Accept` HTTP header with a value of `application/xml`.


### Search

Retrieve information about a single message that you sent using SMS API or that was received on your number.

#### Request

```
[GET] https://rest.nexmo.com/search/message
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`api_key` | You can find your API key in the [developer dashboard](https://dashboard.nexmo.com)| Yes
`api_secret` | You can find your API secret in the [developer dashboard](https://dashboard.nexmo.com)| Yes

#### Response

The following shows example Responses in JSON or XML:

**Outbound Message (MT)**

```tabbed_examples
source: /_examples/api/developer/message/search/outbound
```

**Inbound Message (MO)**

```tabbed_examples
source: /_examples/api/developer/message/search/inbound
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`type` | The message type. `MT` (mobile terminated or outbound) or `MO` (mobile originated or inbound)
`message-id` | The id of the message you sent.
`account-id` | Your API Key.
`network` | The [MCCMNC](https://en.wikipedia.org/wiki/Mobile_Network_Code) for the carrier who delivered the message.
`from` | The sender ID the message was sent from. Could be a phone number or name.
`to` | The phone number the message was sent to.
`body` | The body of the message
`date-received` | The date and time at UTC+0 when Platform received your request in the following format: `YYYY-MM-DD HH:MM:SS`.

**Fields for MT messages only**

Key | Value
-- | --
`price` | Price in Euros for a MT message
`date-closed` | The date and time at UTC+0 when Platform received the delivery receipt from the carrier who delivered the MT message. This parameter is in the following format YYYY-MM-DD HH:MM:SS
`latency` | The overall latency between `date-received` and `date-closed` in milliseconds.
`client-ref` | The [internal reference](/api/sms#send-an-sms) you set in the request.
`final-status` | The status of `message-id` at `date-closed`. @[Possible values](/_modals/api/developer/message/search/response/final-status.md).
`error-code-label` | A text label to explain `error-code`
`status` | A code that explains where the message is in the delivery process. If status is not `delivered` check `error-code` for more information. If status is `accepted` ignore the value of `error-code`. @[Possible values](/_modals/api/developer/message/search/response/status.md).
`error-code` | If the `status` is not `accepted` this key will have one of these @[possible values](/_modals/api/developer/message/search/response/error-code.md).

### Retrieve multiple messages

Retrieve multiple messages that you sent using SMS API or were received on your number.

#### Request

```
[GET] https://rest.nexmo.com/search/messages
```

##### Parameters

The following shows the parameters you use in the request:

**Search by message ID**

Parameter | Description | Required
-- | -- | --
`ids` | The list of up to 10 message IDs to search for. For example: `ids=00A0B0C0&ids=00A0B0C1&ids=00A0B0C2` | Yes
`api_key` | You can find your API key in the [developer dashboard](https://dashboard.nexmo.com)| Yes
`api_secret` | You can find your API secret in the [developer dashboard](https://dashboard.nexmo.com)| Yes

*or* **Search by recipient and date**

Parameter | Description | Required
-- | -- | --
`date` | The date the request to SMS API was submitted in the following format: `YYYY-MM-DD` | Yes
`to` | The phone number the message was sent to. | Yes
`api_key` | You can find your API key in the [developer dashboard](https://dashboard.nexmo.com)| Yes
`api_secret` | You can find your API secret in the [developer dashboard](https://dashboard.nexmo.com)| Yes

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
source: _examples/api/developer/message/retrieve-multiple-messages
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`type` | The message type. `MT` (mobile terminated or outbound) or `MO` (mobile originated or inbound)
`message-id` | The id of the message you sent.
`account-id` | Your API Key.
`network` | The [MCCMNC](https://en.wikipedia.org/wiki/Mobile_Network_Code) for the carrier who delivered the message.
`from` | The sender ID the message was sent from. Could be a phone number or name.
`to` | The phone number the message was sent to
`body` | The body of the message
`date-received` | The date and time at UTC+0 when Platform received your request in the following format: `YYYY-MM-DD HH:MM:SS`.

**Fields for MT messages only**

Key | Value
-- | --
`price` | Price in Euros for a MT message
`date-closed` | The date and time at UTC+0 when Platform received the delivery receipt from the carrier who delivered the MT message. This parameter is in the following format YYYY-MM-DD HH:MM:SS
`latency` | The overall latency between `date-received` and `date-closed` in milliseconds.
`client-ref` | The [internal reference](/api/sms#send-an-sms) you set in the request.
`final-status` | The status of `message-id` at `date-closed`. @[Possible values](/_modals/api/developer/message/search/response/final-status.md).
`error-code-label` | A text label to explain `error-code`
`status` | A code that explains where the message is in the delivery process. If status is not `delivered` check `error-code` for more information. If status is `accepted` ignore the value of `error-code`. @[Possible values](/_modals/api/developer/message/search/response/status.md).
`error-code` | If the `status` is not `accepted` this key will have one of these @[possible values](/_modals/api/developer/message/search/response/error-code.md).

### Retrieve rejected messages

Search for messages that have been rejected by Nexmo. Messages rejected by carrier do not appear.

#### Request

```
[GET] https://rest.nexmo.com/search/rejections
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`date` | The date the request to SMS API was submitted in the following format: `YYYY-MM-DD` | Yes
`to` | The phone number the message was sent to. | Yes
`api_key` | You can find your API key in the [developer dashboard](https://dashboard.nexmo.com)| Yes
`api_secret` | You can find your API secret in the [developer dashboard](https://dashboard.nexmo.com)| Yes

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
source: _examples/api/developer/message/retrieve-rejected-messages
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`account-id` | Your API Key
`from` | Sender number
`to` | Recipient number
`date-received` | Date when we have received the message YYYY-MM-DD HH:MM:SS expressed in UTC time.
`error-code` | Delivery receipt error code.
`error-code-label` | Delivery receipt error code label.
