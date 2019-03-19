---
title: Sending a Facebook message with failover
products: dispatch
description: The Dispatch API provides the ability to create message workflows with failover to secondary channels. This tutorial looks at using the Dispatch API to send a Facebook message with failover to the SMS channel.
languages:
    - Curl
    - Node
---

# Sending a Facebook message with failover

This tutorial shows you how to use the failover functionality of the Dispatch API.

The example Workflow given here will attempt to send a Facebook message using the Messages API, and if this fails it then attempts to send an SMS message to the user using the Messages API.

```partial
source: _partials/reusable/prereqs.md
```

> **NOTE:** This tutorial assumes you have already created a Facebook Profile and a Facebook Page.

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Link your Facebook Page to Nexmo](#link-your-facebook-page-to-your-nexmo-account)
2. [Create a Nexmo Application](#create-a-nexmo-application)
3. [Send a Facebook message with failover](#send-a-message-with-failover)

```partial
source: _partials/reusable/link-facebook-to-nexmo.md
```

```partial
source: _partials/reusable/create-a-nexmo-application.md
```

## Send a message with failover

Sending an message with failover to another channel is achieved by making a single request to the Dispatch API endpoint.

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

> **TIP:** If testing using Curl you will need a JWT. You can see how to create one in the documentation on [creating a JWT](/messages/code-snippets/before-you-begin#generate-a-jwt).

## Further reading

* [Dispatch documentation](/dispatch/overview)
