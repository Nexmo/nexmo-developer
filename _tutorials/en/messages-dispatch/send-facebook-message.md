---
title: Send a Facebook message 
description: In this step you learn how to send a Facebook message ... 
---

# Send a Facebook message 

Sending a Facebook message ....TBD.

Key | Description
-- | --
`FROM_NUMBER` | The phone number you are sending the message from. **Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.**
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

## Example

```code_snippets
source: '_examples/messages/messenger/send-text'
```
