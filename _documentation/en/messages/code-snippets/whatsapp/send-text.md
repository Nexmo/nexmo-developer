---
title: Send a Text Message
meta_title: Send an text message on WhatsApp using the Messages API
---

# Send a Text Message

In this code snippet you learn how to send a WhatsApp message using the Messages API. For WhatsApp the maximum text size is 4096 characters, including Unicode.

For a step-by-step guide to this topic, you can read our tutorial [Sending WhatsApp messages with the Messages API](/tutorials/sending-whatsapp-messages-with-messages-api).

> **IMPORTANT:** If a customer has not messaged you first, then the first time you send a message to a user, WhatsApp requires that the message contains a template. This is explained in more detail in the [Understanding WhatsApp topic](/messages/concepts/whatsapp).

It is possible to format selected text inside the message using [formatting characters](https://faq.whatsapp.com/en/android/26000002/). The `\n` character can also be used to insert new lines. The formatting options are summarized in the following table:

Formatting | Example
---|---
*Italicize* | Italicize `_this_` text.
**Bold** | Bold `*this*` text.
~~Strikethrough~~ | Strikethrough `~this~` text.
`Monospace` | Monospace <code>\`\`\`this\`\`\`</code> text.
New line | Use `\n` to insert a new line.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-text'
application:
  type: messages
  name: 'Send a WhatsApp message'
```

## Try it out

When you run the code a WhatsApp message is sent to the destination number.
