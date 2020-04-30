---
title: Send a WhatsApp message
description: In this step you learn how to send a WhatsApp message.
---
# Send a WhatsApp message

Please note that free form text messages can only be sent when a customer sends a message to the business first. The business has up to 24 hours from the last moment the customer messages to send a free form message back. After that period a WhatsApp Template (MTM) needs to be used.

If you have not received a message from the customer you will need to send a WhatsApp Template (MTM) before sending a message. You can learn more about this in [Understanding WhatsApp Messaging](/messages/concepts/whatsapp).

If you want to see the code for sending a WhatsApp Template you can view the [Sending a WhatsApp Template](/messages/code-snippets/send-whatsapp-template) code snippet.

Key | Description
-- | --
`WHATSAPP_NUMBER` | Your WhatsApp number.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```code_snippets
source: '_examples/messages/whatsapp/send-text'
```

> **TIP:** If testing using Curl you will need a JWT. You can see how to create one in the documentation on [creating a JWT](/messages/code-snippets/before-you-begin#generate-a-jwt).
