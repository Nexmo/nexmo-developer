---
title: Sending SMS messages with the Messages API
products: messages
description: The Messages API provides a unified facility for sending messages over multiple channel types. This tutorial looks at sending messages over the SMS channel using the Messages API.
languages:
    - Curl
    - Node
---

# Sending SMS messages with the Messages API

In this tutorial you will see how to send an SMS using the Messages API.

The same steps taken here can be easily modified to send a message across Viber Service Messages, Facebook Messenger, WhatsApp.

```partial
source: _partials/reusable/prereqs.md
```

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Configure your webhook URLs](#configure-your-webhook-urls) - This step only required for support of inbound message support and delivery receipts.
2. [Create a Nexmo Application](#create-a-nexmo-application) - The resultant Application ID is used to generate a JWT that you need to make API calls. If you already have an Application ID you can use you don't need to do this step.
3. [Generate a JWT](#generate-a-jwt) - This step is only required if you are not using the client library.
4. [Send an SMS message](#send-an-sms-message) - This step uses the Nexmo Messages API to send an SMS message.

```partial
source: _partials/reusable/configure-webhook-urls.md
```

```partial
source: _partials/reusable/create-a-nexmo-application.md
```

```partial
source: _partials/reusable/generate-a-jwt.md
```

## Send an SMS message

Sending an SMS message with the Messages API can be done with one API call, authenticated using the JWT you just created.

In the example code below you will need to replace the following variables with actual values:

Key | Description
-- | --
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```building_blocks
source: '_examples/messages/send-sms'
```

This will send an SMS message to the destination number you specified.

## Further reading

* [Messages documentation](/messages/overview)
