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

1. [Create a Nexmo Application](#create-a-nexmo-application)
2. [Send a Viber Service message](#send-a-viber-service-message)

```partial
source: _partials/reusable/create-a-nexmo-application.md
```

## Send a Viber Service message

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`VIBER_SERVICE_MESSAGE_ID` | Your Viber Service Message ID.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```code_snippets
source: '_examples/messages/viber/send-text'
```

> **TIP:** If testing using Curl you will need a JWT. You can see how to create one in the documentation on [creating a JWT](/messages/code-snippets/before-you-begin#generate-a-jwt).

## Further reading

* [Messages documentation](/messages/overview)
