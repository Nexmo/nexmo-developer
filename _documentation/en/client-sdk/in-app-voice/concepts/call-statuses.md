---
title: Call Statuses
description: Information about call statuses such as `ringing`, `answered` and so on.
navigation_weight: 5
---

# Call Statuses

This topic describes call statuses such as `started`, `ringing`, `answered`, and `failed`.

## Lifecycle

Each call goes through a sequence of statuses in its lifecycle. A call may pass from `started` to `ringing` to `answered` to `complete` but there are many different sequences for statuses in a call's lifecycle. Below is a diagram outlining all possible paths:

![Visual diagram of Call statuses. A description of the text is given in the next section.](/assets/images/client-sdk/call-statuses-rtc-diagram.png)

## Statuses

The following table lists call statuses:

Status | Description
----|----
`started` | The call is created on the Nexmo platform
`cancelled` | The call was cancelled by the originator before it was answered
`ringing` | The destination has confirmed that the call is ringing
`answered` | The destination has answered the call
`rejected` | The call attempt was rejected by the destination
`busy` | The destination is on the line with another caller
`timeout` | The call timed out before it was answered
`failed` | The call failed before reaching the destination
`completed` | The call is completed successfully

These statuses are valid for all one-to-one call combinations such as IP to IP, IP to PSTN, PSTN to IP.

## Disclaimer

While Nexmo, the Vonage API Platform, strives to provide the most accurate call status, we have little to no control over statuses like busy, rejected, and failed, most of which depend on status provided by the carriers. More specifically, a call might not be completed because the callee was on another line (`busy`) but it is relayed as `rejected` by the carrier.
