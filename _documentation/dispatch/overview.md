---
title: Overview
meta_title: Failover automatically from WhatsApp to SMS with Dispatch
---

# Dispatch API Overview

The Dispatch API enables the developer to send messages to users using a multiple channel strategy.

An example workflow might specify a message to be sent a message via Facebook Messenger, and if that message is not read then the user can be sent a message via Viber. If that message is also not read, a user could then be sent a message via SMS.

The Dispatch API provides the mechanism by which to order messages and specify their _success conditions_. The Dispatch API uses the Messages API to actually send the messages.

The following diagram illustrates the relationship between the Dispatch API and the Messages API:

![Messages and Dispatch Overview](/assets/images/messages-dispatch-overview.png)

## Contents

* [Beta](#beta)
* [Supported features](#supported-features)
* [External Accounts API](#external-accounts-api)
* [Getting started](#getting-started)
* [Concepts](#concepts)
* [Code Snippets](#code-snippets)
* [Tutorials](#tutorials)
* [Reference](#reference)

## Beta

This API is currently in Beta.

In this release Nexmo provides a failover template. The failover template instructs the [Messages API](/messages/overview) to send a message to the specified channel. If that message fails immediately or if the `condition_status` is not reached within the specified time period the next message is sent.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Workflow API in the subject line. Please note that during the Beta period, support times are limited to Monday to Friday.

## Supported features

In this release you can:

* **Send** SMS, Facebook Messenger, WhatsApp, and Viber Service Messages with Dispatch built on-top of the [Messages API](/messages/overview).
* **Failover** to the next message if the condition status is not met within the time period or if the message immediately fails.

The condition status is the status that the message returns. With Facebook Messenger and Viber Service Messages, you can use `delivered` and `read` statuses as the condition status. With SMS you can only use `delivered`.

## External Accounts API

The [External Accounts API](/api/external-accounts) is used to manage your accounts for Viber Service Messages, Facebook Messenger and WhatsApp when using those channels with the Messages and Dispatch APIs.

## Getting started

In this example you will need to replace the following variables with actual values using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | Nexmo API key which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | Nexmo API secret which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FROM_NUMBER` | A phone number you own or some text to identify the sender.
`TO_NUMBER` | The number of the phone to which the message will be sent.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

The following code shows how to create a workflow that attempts to send a message via Facebook messenger and if not read within the time limit a message will be sent via SMS:

```code_snippets
source: '_examples/dispatch/send-message-with-failover-basic-auth'
```

## Concepts

```concept_list
product: dispatch
```

## Code Snippets

```code_snippet_list
product: dispatch
```

## Tutorials

```tutorials
product: dispatch
```

## Reference

* [Dispatch API Reference](/api/dispatch)
* [External Accounts API Reference](/api/external-accounts)
