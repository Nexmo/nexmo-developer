---
title: Change the event timings
description: How to change the timings for each verification event.
navigation_weight: 2
---

# Change the Event Timings

You can change the [default timings](/verify/guides/verification-events#timing-of-each-event) by supplying custom values for `pin_expiry` and/or `next_event_wait` in the initial request:

* `pin_expiry`:
    * The time after which the code expires
    * Must be an integer value between 60 and 3600 seconds
    * The default is 300 seconds
* `next_event_wait`:
    * The time after which Nexmo triggers the next verification attempt
    * The default is 300 seconds

If you specify values for both `pin_expiry` and `next_event_wait`, the value of `pin_expiry` must be an exact multiple of `next_event_wait`.

## Examples

The table below shows some example values and the effects when used with the default workflow (SMS -> TTS -> TTS):

|`pin_expiry`|`next_event_wait`|Effect
|--|--|--|
|360 seconds|120 seconds|All three attempts use the same verification code
|240 seconds|120 seconds|The first and second attempts use the same code and the Verify API generates a new code for the third attempt
|120 seconds (or 90 or 200 seconds)|120 seconds|The Verify API generates a new code for each attempt

