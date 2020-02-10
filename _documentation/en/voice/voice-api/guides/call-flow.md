---
title: Call Flow
description: The various stages of a call and how they interact.
navigation_weight: 1
---

# Call Flow

## Overview

The Nexmo Voice API handles two types of phone call: **inbound** and **outbound**.

**Inbound** calls are calls made to a Nexmo number from another regular phone anywhere in the world.

**Outbound** calls are calls made from the Nexmo platform to a regular phone number. Outbound calls are usually initiated in response to a request made via the REST API to create a new call. Outbound calls may also be made from within the call flow of an existing call (either inbound or outbound) using the `connect` action within the NCCO (Nexmo Call Control Object). This scenario is generally used for forwarding calls.

Both inbound and outbound calls follow the same call flow once answered. This call flow is controlled by an NCCO. An NCCO is a script of actions to be run within the context of the call. Actions are executed in the order they appear in the script, with the next action starting when the previous action has finished executing. For more information about NCCOs, see the [NCCO reference](/voice/voice-api/ncco-reference).

When a call is answered, Nexmo makes a call to the `answer_url` provided. For inbound calls the `answer_url` is fetched from the configuration of the application that the number is linked to. For outbound calls, an `answer_url` is provided in the API request made to create the call.

You may choose to provide your NCCO as part of the request you send to create a call instead of providing an `answer_url`. This is done by providing an NCCO in the `ncco` key of [your request](/api/voice#createCall)

## Call states

Each call goes through a sequence of states in its lifecycle:

1. `started`
2. `ringing`
3. `answered`
4. `completed`

## Event objects

As the call progresses through the various [call states](#call-states), the Nexmo platform
will send event objects to your `event_url`. Like the `answer_url` the
`event_url` is associated with the application for inbound calls, or is
supplied as an `event_url` parameter when the call is created.

The following table shows possible values for the `status` field of an event object:

|Event Name | Description |
| --------- | ----------- |
| `started`    | The call is created on the Nexmo platform |
| `ringing`    | The destination has confirmed that the call is ringing |
| `answered`   | The destination has answered the call |
| `completed`    | The call flow has been terminated. This event is always received at the end of a call unless the call was `rejected`. |
| `machine`    | When machine detection has been requested and the call is answered by a machine|
| `human`      | When machine detection has been requested and the call is answered by a human|
| `input`  | User input has been collected via an `input` action |
| `busy`  | The destination is on the line with another caller |
| `cancelled`  | The call was cancelled by the originator before it was answered |
| `failed`     | The call attempt failed in the phone network |
| `recording`  | A `record` stage has completed. This event contains the recording URL |
| `rejected`   | The call attempt was rejected by the Nexmo platform |
| `timeout`    | The call timed out before it was answered|
| `transfer`    | The call has been transferred to a new conversation
| `unanswered` | The recipient handset was unreachable, or the recipient declined the call | 
| `notify` | An event to signify we have reached the `notify` action in the NCCO | 

An example event object is shown here:

```
{
    'conversation_uuid': 'CON-4bf66420-d6cb-46e0-9ba9-f7eede9a7301',
    'direction': 'inbound',
    'from': '447700900000',
    'status': 'started',
    'timestamp': '2018-08-14T11:07:01.284Z',
    'to': '447700900001',
    'uuid': '688fd94bd0e1f59c36a4cbd36312fc28'
}
```

In addition, certain errors are sent to the `event_url` such as when your `answer_url` returns an invalid NCCO. You can find more detail in the [Webhooks Reference](/voice/voice-api/webhook-reference#event-webhook).

## Answer URL payload

When a call is answered a payload is delivered to your `answer_url` [webhook](/concepts/guides/webhooks).

The payload delivered to the `answer_url` is in the form of query parameters and these are shown in the following table:

Query Parameter | Description
----|----
`to` | The number being called
`from` | The number making the call
`conversation_uuid` | The UUID of the [conversation](/voice/voice-api/guides/legs-conversations)
`uuid` | The UUID of the [leg](/voice/voice-api/guides/legs-conversations)

To illustrate this, an example GET request to the `answer_url` is given here:

```
/webhooks/answer?to=447700900000&from=447700900001&conversation_uuid=CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab&uuid=aaaaaaaa-bbbb-cccc-dddd-0123456789cd
```

In general, useful information such as the calling number and destination number is extracted from the query string and processed by your application. For more information, refer to the [Webhooks Reference](/voice/voice-api/webhook-reference).

## Synchronous vs Asynchronous Actions

Each *action* within an NCCO has certain conditions on which it will be considered "complete" and the call progresses to the next action. For some actions this `completed` state depends on how they are configured.

> Ultimately, all calls end up as `completed` unless the call was `rejected`.

### Record

A `record` action will complete when either the `endOnSilence` timer has been reached, or the `endOnKey` key is sent. At this point the recording ends and a `recording` event is sent before the next action is executed.

If neither value is set then the record will work in an asynchronous manner and will instantly continue on to the next action while still recording the call. The recording will only then end and send the relevant event when either the `timeout` value is reached or the call is ended.

### Conversation

The `conversation` action always acts in a synchronous manner where the call is merged into the named conversation (or conference). The action only ends when the call is ended, and therefore all actions in an NCCO after a `conversation` action will be ignored.

### Connect

A `connect` action will progress to the next action in the NCCO when the call is answered. If you have multiple connect actions in an NCCO it will call each one in turn and when answered create a conference between each leg of the call.


### Talk
A `talk` action will complete when the requested text has been read the requested number of times. However, if `bargeIn` is set to `true` _and the following action is an input_, then the call will progress to accepting input as soon as the text starts to be played.

### Stream

A `stream` action will complete when the requested audio file has been played the requested number of times. However, if `bargeIn` is set to `true` _and the following action is an input_, then the call will progress to accepting input as soon as the text starts to be played.

### Input

An input event will complete when one of the following conditions has been met:

1. The `timeOut` is reached
2. The `maxDigits` number of digits are entered
3. A `#` is sent and `submitOnHash` is set

The input action will then send a webhook to the `event_url` containing the submitted digits. 

Input is unique in that when the webhook is sent with the entered digits, the remote application can then return a new NCCO to be executed. If no NCCO is returned, then the call will continue to the next item in the NCCO.

## Transferring to a new NCCO

You can replace the currently executing NCCO with a new one by making an HTTP `PUT` request to the REST API with the call UUID in it. This will replace whatever actions are being executed or queued in the current NCCO. One such use case for this is to transfer a call that is on hold (looping an audio file) to an agent by putting a new NCCO with a `connect` action. However, you can also use this approach to simply modify any aspect of an in progress call.

## Machine Detection

Machine detection can be configured on either a `connect` action within an NCCO or on a REST API request to create an outbound call.  This can be set to one of two values, `hangup` or `continue`. If either of these values is set when the call is answered, Nexmo will attempt to determine if the call was answered by a human, or a machine such as voicemail. This normally takes a few seconds to be determined. At this point Nexmo will send an event to your `event_url` with either `Human` or `Machine` included.

If machine detection was set to `hangup` and Nexmo determined that a machine answered the call, then the call will be ended.

If set to `continue` then the call will remain connected. You can then modify the call. For example, you could transfer the call to a new destination with the `PUT` feature described above in the section [Transferring to a new NCCO](#transferring-to-a-new-ncco).
