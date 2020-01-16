---
title: Send and Receive DTMF
description: How to send and receive DTMF in your app.
navigation_weight: 4
---

# Send and Receive DTMF

## Overview

Dual Tone Multi Frequency (DTMF), is a form of signalling used by phone systems to transmit the digits `0`-`9` and the `*` and `#` characters. Typically a caller presses these buttons on their telephone keypad and the phone then generates a tone made up of two frequencies played simultaneously (hence Dual Tone).

DTMF is used both for dialing a destination on a landline telephone and also for signalling to the remote end once a call is answered. Typically this is used to implement an Interactive Voice Response (IVR) system, or to enter information like a PIN number or conference call pin.

With Nexmo Client SDKs you can both collect a DTMF input from your app user, and listen to DTMF input that was sent from another member.

Before you begin, make sure you [added the SDK to your app](/client-sdk/setup/add-sdk-to-your-app) and you are able to [make](/client-sdk/in-app-voice/guides/make-call) or [receive](/client-sdk/in-app-voice/guides/receive-call) calls.

## Send DTMF

In order to send DTMF tones from your application to the backend, use this method:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/dtmf/send'
frameless: false
```

During an ongoing call, where your backend implemented an [NCCO with an Input action](/voice/voice-api/ncco-reference#input), sending a DTMF will trigger the defined `"eventUrl"`.

## Receive DTMF

Whenever a member in a `Conversation` or a `Call` sends a DTMF, all of the other members are notified about that event.


```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/dtmf/receive'
frameless: false
```
