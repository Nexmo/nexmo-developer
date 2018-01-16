---
title: Handle call status
description: Handle changes to the Call.
---

# Handle call status

Each time the status of Call or Conversation changes Nexmo sends a JSON object with information about the Call to the **event webhook endpoint** for your application.

The event webhook is defined in the following:

* Application configuration - [`POST /applications`](/api/application#create) - the default event webhook endpoint for all Calls and Conversations that use this application
* A Call request - [`POST /calls`](/api/voice#payload) - the event webhook endpoint used for a particular Call
* A [connect](/voice/guides/ncco-reference#connect) NCCO action - when you use the `connect` NCCO action to connect a voice call to an endpoint

A call can be initiated via a request to [`POST /calls`](/api/voice#payload). The response from this request contains initial information about the call.

```json
{
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "status": "started",
  "direction": "outbound",
  "conversation_uuid": "CON-bbbbbbbb-cccc-dddd-eeee-0123456789ab"
}
```

Further status changes for the Call are sent to your `event_url` webhook endpoint. Each leg of a Call has a different `uuid`. The `uuid` is used in all [`/calls`](/api/voice#payload) requests that alter or retrieve information about a Call.

If you [record](/voice/guides/record-calls-and-conversations) your Calls and Conversations, the download URL for the mp3 recording is sent to your event webhook endpoint when `status` is `complete`.

The objects returned for the different Call status look like:

```tabbed_content
source: '_examples/voice/guides/handle-call-status/ncco'
```

To inspect and debug state changes without writing your own server, use an online endpoint service such as [requestb.in](http://requestb.in/) or [hookbin.com](https://hookbin.com/).

Possible values are:

Key | Value
-- | --
`conversation_uuid` | The unique identifier for the conversation this call leg is part of. This parameter is created when your request is accepted and the status sent to event_url is ringing.
`to` | The single or mixed collection of endpoint types you connected to. @[Possible values](/_modals/voice/guides/handle-call-status/to.md).
`from` | The endpoint you called from. Possible values are the same as to.
`direction` | Possible values are outbound or inbound.
`recording_url` | The URL to download a Call or Conversation recording from.
`rate` | The price per minute for this call.
`start_time` | The time the call started in the following format: YYYY-MM-DD HH:MM:SS. For example, 2020-01-01 12:00:00.
`network` | The Mobile Country Code Mobile Network Code (MCCMNC) for the carrier network used to make this call.
`status` | The status of the call. @[Possible values](/_modals/voice/guides/handle-call-status/status.md).
`price` | The total price charged for this Call.
`duration` | The time elapsed for the Call to take place in seconds.
`end_time` | The time the Call ended in the following format: YYYY-MM-DD HH:MM:SS. For example, 2020-01-01 12:00:00.
