---
title: Sending WhatsApp messages with the Messages API
products: messages
description: The Messages API provides a unified facility for sending messages over multiple channel types. This tutorial looks at sending messages via the WhatsApp channel using the Messages API.
languages:
    - Curl
    - Node
---

# Sending WhatsApp messages with the Messages API

You can use the Messages API to exchange messages with WhatsApp users.

Before continuing with this tutorial you should review the information on [Understanding WhatsApp messaging](/messages/concepts/whatsapp).

```partial
source: _partials/reusable/prereqs.md
```

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Contact Nexmo](mailto:sales@nexmo.com) - You will need to obtain a WhatsApp number. Nexmo cannot guarantee you will be assigned a WhatsApp number.
2. [Create a Nexmo Application](#create-a-nexmo-application)
3. [Send a WhatsApp message](#send-a-whatsapp-message)

```partial
source: _partials/reusable/create-a-nexmo-application.md
```

## Send a WhatsApp message

Please note that free form text messages can only be sent when a customer sends a message to the business first. The business has up to 24 hours from the last moment the customer messages to send a free form message back. After that period a WhatsApp Template (MTM) needs to be used.

If you have not received a message from the customer you will need to send a WhatsApp Template (MTM) before sending a message. You can learn more about this in [Understanding WhatsApp Messaging](/messages/concepts/whatsapp).

If you want to see the code for sending a WhatsApp Template you can view the [Sending a WhatsApp Template](/messages/code-snippets/send-whatsapp-template) code snippet.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`WHATSAPP_NUMBER` | Your WhatsApp number.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```code_snippets
source: '_examples/messages/whatsapp/send-text'
```

> **TIP:** If testing using Curl you will need a JWT. You can see how to create one in the documentation on [creating a JWT](/messages/code-snippets/before-you-begin#generate-a-jwt).

## Further reading

* [Messages documentation](/messages/overview)
* [Understanding WhatsApp Messaging](/messages/concepts/whatsapp)
