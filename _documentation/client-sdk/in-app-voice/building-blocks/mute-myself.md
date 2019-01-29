---
title: Mute myself in a Call
navigation_weight: 7
---

# Mute myself in a Call

In this building block you will see how to mute a Call.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`actionStatus` | ActionStatus.ON for mute or ActionStatus.OFF to un-mute
`listener` | listener for the success or failure changing the mute status

```building_blocks
source: '_examples/client-sdk/in-app-voice/mute-myself'
application:
  type: rtc
  name: 'Mute Myself'
```

## Try it out

When you run the code you are muted in a Call.