---
title: Sending Viber Service messages with the Messages API
products: messages
description: The Messages API provides a unified facility for sending messages over multiple channel types. This tutorial looks at sending messages via the Viber Service channel using the Messages API.
languages:
    - Curl
    - Node
---

# Sending Viber Service messages with the Messages API

You can use the Messages API to send outbound Viber Service Messages to Viber Users.

Before continuing with this tutorial you should review the information on [Understanding Viber messaging](/messages/concepts/viber).

```partial
source: _partials/reusable/prereqs.md
```

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Configure your webhook URLs](#configure-your-webhook-urls) - This step only required for support of inbound message support and delivery receipts.
2. [Create a Nexmo Application](#create-a-nexmo-application) - The resultant Application ID is used to generate a JWT that you need to make API calls. If you already have an Application ID you can use you don't need to do this step.
3. [Generate a JWT](#generate-a-jwt) - This step is only required if you are not using the client library.
4. [Send a Viber Service message](#send-a-viber-service-message) - This step uses the Nexmo Messages API to send a Viber Service message.

```partial
source: _partials/reusable/configure-webhook-urls.md
```

```partial
source: _partials/reusable/create-a-nexmo-application.md
```

```partial
source: _partials/reusable/generate-a-jwt.md
```

## Send a Viber Service message

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`VIBER_SERVICE_MESSAGE_ID` | Your Viber Service Message ID.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```building_blocks
source: '_examples/messages/send-viber-message'
```

## Further reading

* [Messages documentation](/messages/overview)
