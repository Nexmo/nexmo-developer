---
title: Verification events
description: The stages of the verification process and the default timings for each.
navigation_weight: 1
---

# Verification Events

To verify a user's phone number using the Verify API, you first make a [verify request](/verify/code-snippets/send-verify-request) and receive the `request_id`. 

> **Note** You are limited to a maximum of one verify request per second.

The Verify API then sends a verification code to the user by SMS. When they enter the code into your application, you [check the verification code](/verify/code-snippets/check-verify-request) by making a request to the Verify API using the `request_id` and the code the user provides.

If the user does not enter the code within the allowed time, the Verify API makes two further attempts to verify the user by making  Text-to-speech (TTS) voice calls.

## Timing of each event 

The following table shows the three events that are triggered and the amount of time the Verify API waits by default before triggering the next event. You can also [trigger the next verification attempt](/verify/code-snippets/trigger-next-verification-process) programmatically.

| Step | Verification event  | Wait time before next event |
|---|---|---|
|1.|Nexmo sends a verification code via SMS | 125 seconds |
|2.|Nexmo makes the first TTS call to read the code to the customer | 180 seconds |
|3.|Nexmo expires the first code and makes a second TTS call with a new code | 300 seconds |

If the user still has not responded after all three verification attempts, the verification process is unsuccessful.

> To customize wait times and the duration after which verification codes expire, see [changing the default event timings](/verify/guides/changing-default-timings).