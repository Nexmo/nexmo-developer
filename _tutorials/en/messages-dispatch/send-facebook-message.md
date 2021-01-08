---
title: Send a Facebook message 
description: In this step you learn how to send a Facebook message 
---

# Send a Facebook message

You can then use the Messages API to respond to the inbound message received from the Facebook User.

Replace the following variables in the example below with actual values:

|Key | Description|
|-- | --|
|`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.|
|`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.|

## Example

```code_snippets
source: '_examples/messages/messenger/send-text'
```

> **TIP:** If testing using Curl you will need a JWT. You can see how to create one in the documentation on [creating a JWT](/messages/code-snippets/before-you-begin#generate-a-jwt).
