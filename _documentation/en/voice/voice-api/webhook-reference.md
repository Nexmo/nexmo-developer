---
title: Webhook Reference
description: Details of the webhooks that Nexmo sends relating to voice calls.
api: "Voice API: Webhooks"
---

# Voice API Webhooks Reference

Nexmo uses webhooks alongside its Voice API to enable your application to interact with the call. There are two webhook endpoints:

* [Answer webhook](#answer-webhook) is sent when a call is answered. This is for both incoming and outgoing calls.
* [Event webhook](#event-webhook) is sent for all the events that occur during a call. Your application can log, react to or ignore each event type.
* [Errors](#errors) are also delivered to the event webhook endpoint if they occur.

For more general information, check out our [webhooks guide](/concepts/guides/webhooks).

## Answer Webhook

When an incoming call is answered, an HTTP request is sent to the `answer_url` you specified when setting up the application. For outgoing calls, specify the `answer_url` when you make the call.

By default, the answer webhook will be a `GET` request but this can be overridden to `POST` by setting the `answer_method` field. For incoming calls, you configure these values when you create the application. For outgoing calls, you specify these values when making a call.

### Answer webhook data fields

Field | Example | Description 
 -- | -- | --
`to` | `442079460000` | The number the call came from (this could be your Nexmo number if the call is started programmatically)
`from` | `447700900000` | The call the number is to (this could be a Nexmo number or another phone number)
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | A unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | A unique identifier for this conversation

#### Transmitting additional data with SIP headers

In addition to the above fields, you can specify any additional headers you need when using SIP Connect. Any headers provided must start with `X-` and will be sent to your `answer_url` with a prefix of `SipHeader_`. For example, if you add a header of `X-UserId` with a value of `1938ND9`, Nexmo will add `SipHeader_X-UserId=1938ND9` to the request made to your `answer_url`.

> **Warning:** Headers that start with `X-Nexmo` will not be sent to your `answer_url`

### Answer webhook data field examples

For a `GET` request, the variables will be in the URL, like this:

```
/answer.php?to=442079460000&from=447700900000&conversation_uuid=CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab&uuid=aaaaaaaa-bbbb-cccc-dddd-0123456789ab&SipHeader_X-UserId=1938ND9
```

If you set the `answer_method` to `POST` then you will receive the request with JSON format data in the body:

```
{
  "from": "442079460000",
  "to": "447700900000",
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "conversation_uuid": "CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "SipHeader_X-UserId": "1938ND9"
}
```

### Responding to the answer webhook

Nexmo expect you to return an [NCCO](/voice/voice-api/ncco-reference) in JSON format containing the actions to perform.

## Event webhook

HTTP requests will arrive at the event webhook endpoint when there is any status change for a call. The URL will be the `event_url` you specified when creating your application unless you override it by setting a specific `event_url` when starting a call.

By default the incoming requests are `POST` requests with a JSON body. You can override the method to `GET` by configuring the `event_method` in addition to the `event_url`.

The format of the data included depends on which event has occurred:

* [`started`](#started)
* [`ringing`](#ringing)
* [`answered`](#answered)
* [`busy`](#busy)
* [`cancelled`](#cancelled)
* [`unanswered`](#unanswered)
* [`rejected`](#rejected)
* [`failed`](#failed)
* [`human/machine`](#human-machine)
* [`timeout`](#timeout)
* [`completed`](#completed)
* [`record`](#record)
* [`input`](#input)
* [`transfer`](#transfer)

### Started

Indicates that the call has been created.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `started` | Call status
`direction` | `outbound` | Call direction, can be either `inbound` or `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Ringing

The destination is reachable and ringing.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `ringing` | Call status
`direction` | `outbound` | Call direction, can be either `inbound` or `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Answered

The call was answered.

Field | Example | Description
 -- | -- | --
`start_time` | - | *empty*
`rate` | - | *empty*
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `answered` | Call status
`direction` | `inbound` | Call direction, can be either `inbound` or `outbound`
`network` | - | *empty*
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Busy

The destination is on the line with another caller.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `busy` | Call status
`direction` | `outbound` | Call direction, this will be `outbound` in this context
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Cancelled

An outgoing call is cancelled by the originator before being answered.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `cancelled` | Call status
`direction` | `outbound` | Call direction, this will be `outbound` in this context
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Unanswered

Either the recipient is unreachable or the recipient declined the call.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `unanswered` | Call status
`direction` | `outbound` | Call direction, this will be `outbound` in this context
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Rejected

The call was rejected by Nexmo before it was connected.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `rejected` | Call status
`direction` | `outbound` | Call direction, this will be `outbound` in this context
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Failed

The outgoing call could not be connected.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `failed` | Call status
`direction` | `outbound` | Call direction, this will be `outbound` in this context
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Human / Machine

For an outbound call made programmatically, if the `machine_detection` option is set then an event with a status of `human` or `machine` will be sent depending whether a person answered the call or not.

Field | Example | Description
 -- | -- | --
`call_uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call (**Note** `call_uuid`, not `uuid` as in some other endpoints)
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`status` | `human` | Call status, can be either `human` if a person answered or `machine` if the call was answered by voicemail or another automated service
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Timeout

If the duration of the ringing phase exceeds the specified `ringing_timeout` duration, this event will be sent.

Field | Example | Description
 -- | -- | --
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `timeout` | Call status
`direction` | `outbound` | Call direction, this will be `outbound` in this context
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Completed

The call is over, this event also includes summary data about the call.

Field | Example | Description
 -- | -- | --
`end_time` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`network` | `GB-FIXED` | The type of network that was used in the call
`duration` | `2` | Call length (in seconds)
`start_time` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)
`rate` | `0.00450000` | Cost per minute of the call (EUR)
`price` | `0.00015000` | Total cost of the call (EUR)
`from` | `442079460000` | The number the call came from
`to` | `447700900000` | The number the call was made to 
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`status` | `completed` | Call status
`direction` | inbound | Call direction, can be either `inbound` or `outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Record

This webhook arrives when an NCCO with a "record" action has finished. When creating a record action, you can set a different `eventUrl` for this event to be sent to. This can be useful if you want to use separate code to handle this event type.

Field | Example | Description
 -- | -- | --
`start_time` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)
`recording_url` | `https://api.nexmo.com/v1/files/bbbbbbbb-aaaa-cccc-dddd-0123456789ab` | Where to download the recording
`size` | 12222 | The size of the recording file (in bytes)
`recording_uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | A unique identifier for this recording
`end_time` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Input 

This webhook is sent by Nexmo when an NCCO with an action of "input" has finished.

Field | Example | Description
 -- | -- | --
`dtmf` | `42` | The buttons pressed by the user
`timed_out` | `true` | Whether the input action timed out: `true` if it did, `false` if not
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

### Transfer

This webhook is sent by Nexmo when a leg has been transferred from one conversation to another. This can be done using an NCCO or the [`transfer` action](/api/voice#updateCall)

Field | Example | Description
 -- | -- | --
`conversation_uuid_from` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The conversation ID that the leg was originally in
`conversation_uuid_to` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The conversation ID that the leg was transferred to
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this call
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

[Back to event webhooks list](#event-webhook)

## Errors

The event endpoint will also receive webhooks in the event of an error. This can be useful when debugging your application.

Field | Example | Description
 -- | -- | --
`reason` | `Syntax error in NCCO. Invalid value type or action.` | Information about the nature of the error
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | The unique identifier for this conversation
`timestamp` | `2020-01-01T12:00:00.000Z` | Timestamp (ISO 8601 format)

