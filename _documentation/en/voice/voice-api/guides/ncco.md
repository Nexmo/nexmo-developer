---
title: Nexmo Call Control Objects
navigation_weight: 2
description: >-
  To tell Vonage how to handle a phone call, you must provide a Nexmo Call
  Control Objects (NCCO) when a call is placed or answered. There are various
  actions available, such as `talk`, `input` and `record`.
---

# Nexmo Call Control Objects

A Nexmo Call Control Object (NCCO) is a JSON array of actions that is used to control the flow of a Voice API Call.

This section describes:

- [About Nexmo Call Control Objects](#about-nexmo-call-control-objects)
- [Creating a custom Call or Conversation for each user](#creating-a-custom-call-or-conversation-for-each-user)
- [Connecting to endpoints that don't generate a ring back tone](#ringback-tone)
- [Executing an NCCO when a call is answered](#on-answer)

## About Nexmo Call Control Objects

The Call event model is asynchronous. A static or dynamically created NCCO script provides the business logic for your Call. When a Call is placed to your number, Vonage makes a synchronous request to the webhook endpoint you set as the `answer_url` for your number and retrieves the NCCO object that controls the Call.

The general schema of an NCCO is:

```json
[
  {
    "action": "<value>",
    "<option1>": "<value>",
    "<option2>": [
      {
        "type": "<value>",
        "<option1>": "<value>"
      },
      {
        "type": "<value>",
        "<option1>": "<value>",
        "<option2>": "<value>"
      }
    ]
  }
]
```

The elements of an NCCO instruction are:

- `action` - something to be done in the Call.
- `option` - how to customize an _action_.
- `type` - describes an _option_. For example, `type=phone` for an endpoint option.

The order of actions in the NCCO controls the flow of the call. This is called the stack. The order of instructions on the stack matters: the actions are executed in order. Unless explicitly halted NCCO are executed on a FIFO basis. When an action is completed, the next action in the stack is executed. Actions that have to complete before the next action can be executed are _synchronous_. Other actions are _asynchronous_. That is, they are supposed to continue over the following actions until a condition is met. For example, a `record` action terminates when the `endOnSilence` option is met. When all the actions in the NCCO are complete, the voice call ends.

Some actions and options are:

```tabbed_content
source: '_examples/voice/ncco/actions'
```

For your NCCO to execute correctly, the JSON syntax must be valid. It is better to generate JSON dynamically using a JSON library than to attempt to write it yourself programmatically.

The actions you can use in an NCCO are:

- [`record`](/voice/voice-api/ncco-reference#record) - all or part of a call
- [`conversation`](/voice/voice-api/ncco-reference#conversation) - create a standard or hosted conversation
- [`connect`](/voice/voice-api/ncco-reference#connect) - connect to a connectable endpoint such as a phone number or Vonage Business Cloud extension
- [`talk`](/voice/voice-api/ncco-reference#talk) - send synthesized speech to a conversation
- [`stream`](/voice/voice-api/ncco-reference#stream) - send audio files to a conversation
- [`input`](/voice/voice-api/ncco-reference#input) - collect digits from the person you are calling, then process them

## Creating a custom call or conversation for each user

When you make an outbound call or accept an inbound call, Vonage makes a request to your webhook endpoint at `answer_url` and retrieves your NCCO. This request contains the following parameters:

Name                | Description
------------------- | ------------------------------------
`to`                | The endpoint being called.
`from`              | The endpoint you are calling from.
`conversation_uuid` | The unique ID for this Conversation.
`uuid`              | The unique ID for this Call.

You can use these parameters to customize the NCCO you return to Vonage. The following code examples show how to provide the NCCO that controls your call or conversation:

```tabbed_examples
source: '_examples/voice/ncco/creating-a-custom-call-or-conversation-for-each-user'
```

⚓ ringback-tone

## Connecting to endpoints that don't generate a ring back tone

Sometimes you will connect to an endpoint that does not have a ring back tone provided by the carrier. If calling a phone endpoint, you will usually hear a ring back tone provided by the carrier, but if one is not provided for that endpoint the caller will experience silence and may be unsure if they are being connected or not. This may result in them hanging up the call. To get around this potential problem, you can use `ringbackTone` in your NCCO to provide a ring back tone. For example:

```json
[
    {
        "action": "talk",
        "text": "Now connecting you"
    },
    {
        "action": "connect",
        "from": "NEXMO_NUMBER",
        "ringbackTone": "https://example.com/tones/call.wav",
        "endpoint": [
            {
                "type": "app",
                "user": "alice"
            }
        ]
    }
]
```

⚓ on-answer

## Executing an NCCO when a call is answered

In some use cases you might want to execute an NCCO when a call is answered. For example, you might want to inform the callee that they are about to be connected into a conference call. To carry out NCCO operations when a call is answered the `onAnswer` parameter can be used. For example:

```json
[
    {
        "action": "talk",
        "text": "Now connecting you"
    },
    {
        "action": "connect",
        "from": "NEXMO_NUMBER",
        "endpoint": [
            {
                "type": "phone",
                "number": "TO_NUMBER",
                "onAnswer": {
                    "url": "https://example.com/ncco/on-answer.json"
                }
            }
        ]
    }
]
```

You can also use `onAnswer` in conjunction with `ringbackTone` so that the caller can hear a ring back tone between when the callee answers the call, and when the callee is fully connected into the call:

```json
[
    {
        "action": "talk",
        "text": "Now connecting you"
    },
    {
        "action": "connect",
        "from": "NEXMO_NUMBER",
        "endpoint": [
            {
                "type": "phone",
                "number": "TO_NUMBER",
                "onAnswer": {
                    "url": "https://example.com/ncco/on-answer.json",
                    "ringbackTone":"https://example.com/tones/connecting-callee.wav"
                }
            }
        ]
    }
]
```

In a very simple case `on-answer.json` might be:

```json
[
  {
    "action": "talk",
    "text": "You will now be connected into the conversation"
  }
]
```
