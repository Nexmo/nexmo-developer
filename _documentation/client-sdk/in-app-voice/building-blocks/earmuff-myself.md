---
title: Earmuff myself in a Call
---

# Earmuff a Call

In this building block you will see how to earmuff yourself in a Call.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`actionStatus` | ActionStatus.ON for earmuff or ActionStatus.OFF to un-earmuff
`listener` | listener for the success or failure changing the earmuff status

```building_blocks
source: '_examples/client-sdk/in-app-voice/earmuff-myself'
application:
  type: rtc
  name: 'Earmuff myself'
```

## Try it out

When you run the code you are earmuffed in the call.
