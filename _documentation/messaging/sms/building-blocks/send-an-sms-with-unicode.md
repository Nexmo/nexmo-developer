---
title: Send an SMS with Unicode
description: How to send an SMS with Unicode
navigation_weight: 2
---

# Sending a Unicode message via SMS

Nexmo's SMS API supports Unicode if you specify the type of message as Unicode when sending.  This allows sending of characters from beyond the Latin/ASCII character sets, as we'll see in the example below.

Key | Description
-- | --
`NEXMO_API_KEY` | You can find this in your Nexmo Dashboard.
`NEXMO_API_SECRET` | You can find this in your Nexmo Dashboard.
`TO_NUMBER` | The number you are sending the SMS to.
`FROM` | Used to identify sender.

```building_blocks
source: '_examples/messaging/sms/send-an-sms-with-unicode'
```
