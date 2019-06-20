---
title: Send a Facebook message with failover
description: In this Task you see how to send a Facebook message with automatic failover to SMS using the Dispatch API. This Task demonstrates a simple workflow where if the `messenger` message is not read after 600 seconds, automatic failover occurs, and an SMS is then sent. 
---

# Send a Facebook message with failover

Sending a Facebook message with failover to another channel is achieved by making a single request to the Dispatch API endpoint.

In this example you will implement the following workflow:

1. Send a Facebook Messenger message to the user using the Messages API.
2. If the failover condition is met proceed to the next step. In this example the failover condition is the message not being read.
3. Send an SMS to the user using the Messages API.

Key | Description
-- | --
`FROM_NUMBER` | The phone number you are sending the message from. **Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.**
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

## Example

```code_snippets
source: '_examples/dispatch/send-facebook-message-with-failover'
```
