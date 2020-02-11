---
title: Voice API
menu_weight: 3
---

For Voice API requests, webhooks can be set at an application level, when creating a call, or in the actions in an NCCO.

### Application-level webhooks

Nexmo numbers that are linked to Nexmo applications will use the `answer_url` to retrieve an NCCO, and the `event_url` to send call status information to you. The `fallback_answer_url` can optionally be configured. This is used when `fallback_answer_url` is offline or returning an HTTP error code. It is also used when an event is expected to deliver an NCCO on `event_url`, but `event_url` is offline or returning an HTTP Status code.

You can set these using the [Application API](/api/application), in the [Nexmo Dashboard](https://dashboard.nexmo.com) or using the [Nexmo CLI](https://github.com/nexmo/nexmo-cli) tool.

### Number-level webhooks

You can set a status webhook for each number you purchase. This will be used to send events to you regarding each number.

These can be set up in the Numbers section of the [Dashboard](https://dashboard.nexmo.com), via the [Nexmo CLI](https://github.com/nexmo/nexmo-cli) or via the [Update a Number](/api/developer/numbers#update-a-number) API call (specifically, the `voiceStatusCallback` property).

### On creating an outbound call

When [making a new outbound call](/voice/voice-api/code-snippets/make-an-outbound-call), you need to set the `answer_url` in the call to a URL containing an NCCO. Nexmo's servers will retrieve the NCCO from this endpoint and follow its instructions in handling the outbound call.

### Answer URL payload

The payload for the `answer_url` is:

Parameter | Description
----|----
`to` | The number being called
`from` | The number making the call
`conversation_uuid` | The UUID of the [conversation](/voice/voice-api/guides/legs-conversations)
`uuid` | The UUID of the [leg](/voice/voice-api/guides/legs-conversations)

Example URL:

```
/webhooks/answer?to=447700900000&from=447700900001&conversation_uuid=CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab&uuid=aaaaaaaa-bbbb-cccc-dddd-0123456789cd
```

### Inside an NCCO

Inside an NCCO, the following action types take a webhook URL for use when that action is executed:

* [record.eventUrl](/voice/guides/ncco-reference#record) - set the webhook endpoint that receives information about the recording for a Call or Conversation
* [conversation.eventUrl](/voice/guides/ncco-reference#conversation) - set the URL to the webhook endpoint Nexmo calls asynchronously when a conversation changes state for this conversation action
* [connect.eventUrl](/voice/guides/ncco-reference#connect) - set the URL to the webhook endpoint Nexmo calls asynchronously when a conversation changes state for this connect action
* [input.eventUrl](/voice/guides/ncco-reference#input) - set the URL to the webhook endpoint Nexmo sends the digits pressed by the callee
* [stream.streamUrl](/voice/guides/ncco-reference#stream) - set an array of URLs pointing to the webhook endpoints hosting the audio file to stream to the Call or Conversation
