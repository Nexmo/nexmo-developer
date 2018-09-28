---
title: Sending Viber Service messages with Messages API
products: messages-and-workflows-apis/messages
description: The Messages API provides a unified facility for sending messages over multiple channel types. This tutorial looks at sending messages via the Viber Service channel using the Messages API.
languages:
    - Curl
    - Node
---

# Sending Viber Service messages with Messages API

You can use the Messages API to send outbound Viber Service Messages to Viber Users.

Viber Service Messages can only be sent by businesses that have been approved by Viber. This business profile will also have a green check to indicate that it is a legitimate business.

The advantage of Viber Service Messages is that the identifier of users on the platform is their mobile phone number. The business accounts are limited to only outbound messages to the customer. This means there is no way for a customer to respond and means that you don't need to worry about dealing with inbound messages.

In order to get started with Viber Service Messages you will need to email [sales@nexmo.com](mailto:sales@nexmo.com). Nexmo is an official partner and will handle the application and creation of your Viber Service Messages account for you.

If successful, your account manager will provide you with a Viber Service Messages ID. This ID can only be used on Nexmo.

```partial
source: _partials/olympus/prereqs.md
```

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Configure your webhook URLs](#configure-your-webhook-urls) - This step only required for support of inbound message support and delivery receipts.
2. [Create a Nexmo Application](#create-a-nexmo-application) - The resultant Application ID is used to generate a JWT that you need to make API calls. If you already have an Application ID you can use you don't need to do this step.
3. [Generate a JWT](#generate-a-jwt) - This step is only required if you are not using the client library.
4. **Send a Viber Service message** - This step uses the Nexmo Messages API to send a Viber Service message.

```partial
source: _partials/olympus/configure-webhook-urls.md
```

```partial
source: _partials/olympus/create-a-nexmo-application.md
```

```partial
source: _partials/olympus/generate-a-jwt.md
```

## Send a message

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`VIBER_SERVICE_MESSAGE_ID` | Your Viber Service Message ID.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```building_blocks
source: '_examples/olympus/send-viber-message'
```

## Further reading

* [Messages documentation](/messages-and-workflows-apis/messages/overview)
