---
title: Workflows and Events
description: The stages and timings of the verification processes
navigation_weight: 1
---

# Workflows and Events

Verify API gives the best chance of reaching your users by combining SMS and TTS (Text-To-Speech) calls in sequence. The basic model is that when you [create a Verify request](/verify/code-snippets/send-verify-request), it is assigned a `request_id` and Nexmo will begin the sequence of actions to reach the user with a PIN code. When the user sends you the code, you send the code along with the `request_id` through to Nexmo to [check the code is correct](/verify/code-snippets/check-verify-request). 

When you send the code and `request_id`, Nexmo will confirm if the code is as expected (or not). For a successful verification, the sequence will stop and no further calls or messages will be sent to the user. If the verification is unsuccessful, the sequence will continue and remain active until either the PIN has expired or three incorrect codes have been sent.

The Verify API allows you to select the best workflow for your use case. This might depend on the type of verification taking place, your users' preference or their geographical location. You can specify which workflow to use for each Verify API request by setting the `workflow_id` field to an integer value 1-5. The details of each of these five preset workflows are detailed below.

You can further customize the experience by [setting the timings](/verify/guides/changing-default-timings) when creating a Verify request, and can [trigger the next verification attempt](/verify/code-snippets/trigger-next-verification-process) programmatically if you wish.

## Workflow 1 (Default Workflow): SMS -> TTS -> TTS

Send a PIN code by text message, follow up with two subsequent voice calls if the request wasn't already verified.

1. Send **SMS** to user with PIN code
2. Wait for `next_event_wait` seconds *(default wait: 125 seconds)*
3. Call user and give **TTS** PIN code
4. Wait for `next_event_wait` seconds *(default wait: 180 seconds)*
5. (With default timings, PIN will expire and a new one will be generated, control this by setting the `pin_expiry` field)
6. Call user and give **TTS** PIN code
7. Wait for `next_event_wait` seconds *(default wait: 300 seconds)*
8. Request expires


## Workflow 2: SMS -> SMS -> TTS

Send a PIN code by text message, follow up with a second text message and finally a voice call if the request has not been verified.

1. Send **SMS** to user with PIN code
2. Wait for `next_event_wait` seconds *(default wait: 125 seconds)*
3. Send **SMS** to user with PIN code
4. Wait for `next_event_wait` seconds *(default wait: 180 seconds)*
5. (With default timings, PIN will expire and a new one will be generated, control this by setting the `pin_expiry` field)
6. Call user and give **TTS** PIN code
7. Wait for `next_event_wait` seconds *(default wait: 300 seconds)*
8. Request expires


## Workflow 3: TTS -> TTS

Call the user and speak a PIN code, follow up with a second call if the request wasn't already verified.

1. Call user and give **TTS** PIN code
2. Wait for `next_event_wait` seconds *(default wait: 150 seconds)*
3. Call user and give **TTS** PIN code
4. Wait for `next_event_wait` seconds *(default wait: 150 seconds)*
5. Request expires


## Workflow 4: SMS -> SMS

Send a PIN code by text message, follow up with a second text message if the code hasn't been verified.

1. Send **SMS** to user with PIN code
2. Wait for `next_event_wait` seconds *(default wait: 120 seconds)*
3. Send **SMS** to user with PIN code
4. Wait for `next_event_wait` seconds *(default wait: 180 seconds)*
5. Request expires


## Workflow 5: SMS -> TTS

Send a PIN code by text message, follow up with a voice call if the code hasn't been verified.

1. Send **SMS** to user with PIN code
2. Wait for `next_event_wait` seconds *(default wait: 125 seconds)*
3. Call user and give **TTS** PIN code
4. Wait for `next_event_wait` seconds *(default wait: 300 seconds)*
5. Request expires


## Workflow 6: SMS

Send a PIN code by text message only.

1. Send **SMS** to user with PIN code
2. Wait for `next_event_wait` seconds *(default wait: 300 seconds)*
3. Request expires


## Workflow 7: TTS

Call the user and speak a PIN code only.

1. Call user and give **TTS** PIN code
2. Wait for `next_event_wait` seconds *(default wait: 300 seconds)*
3. Request expires

