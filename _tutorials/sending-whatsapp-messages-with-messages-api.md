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

1. [Contact Nexmo](mailto:sales@nexmo.com) - You will need to obtain a WhatsApp number.
2. [Configure your webhook URLs](#configure-your-webhook-urls) - This step only required for support of inbound message support and delivery receipts.
3. [Create a Nexmo Application](#create-a-nexmo-application) - The resultant Application ID is used to generate a JWT that you need to make API calls. If you already have an Application ID you can use you don't need to do this step.
4. [Generate a JWT](#generate-a-jwt) - This step is only required if you are not using the client library.
5. [Send a WhatsApp message](#send-a-whatsapp-message) - This step uses the Nexmo Messages API to send a WhatsApp message.

```partial
source: _partials/reusable/configure-webhook-urls.md
```

```partial
source: _partials/reusable/create-a-nexmo-application.md
```

```partial
source: _partials/reusable/generate-a-jwt.md
```

## Send a WhatsApp message

Please note that free form text messages can only be sent when a customer sends a message to the business first. The business has up to 24 hours from the last moment the customer messages to send a free form message back. After that period a MTM needs to be used.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`WHATSAPP_NUMBER` | Your WhatsApp number.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```building_blocks
source: '_examples/messages/send-whatsapp-message'
```

## Further reading

* [Messages documentation](/messages/overview)
