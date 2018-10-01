---
title: Overview
---

# Workflows API Overview

The Workflows API enables the developer to send messages to users using a multiple channel strategy.

An example workflow might specify a message to be sent a message via Facebook Messenger, and if that message is not read then the user can be sent a message via Viber. If that message is also not read a user could then be sent a message via SMS.

The Workflows API provides the mechanism by which to order messages and specify their _success conditions_. The Workflows API uses the Messages API to actually send the messages.

The following diagram illustrates the relationship between the Workflows API and the Messages API:

![Messages and Workflows Overview](/assets/images/messages-workflows-overview.png)

## Contents

* [Developer Preview](#developer-preview)
* [Supported features](#supported-features)
* [Getting started](#getting-started)
* [Concepts](#concepts)
* [Building Blocks](#building-blocks)
* [Tutorials](#tutorials)
* [Reference](#reference)

## Developer Preview

This API is currently in Developer Preview.

In this release Nexmo provides a failover template. The failover template instructs the [Messages API](/messages-and-workflows-apis/messages/overview) to send a message to the specified channel. If that message fails immediately or if the `condition_status` is not reached within the specified time period the next message is sent.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Workflow API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

## Supported features

In this release you can:

* **Send** SMS, Facebook Messenger, WhatsApp, and Viber Service Messages with Workflows built on-top of the [Messages API](/messages-and-workflows-apis/messages/overview).
* **Failover** to the next message if the condition status is not met within the time period or if the message immediately fails.

The condition status is the status that the message returns. With Facebook Messenger and Viber Service Messages, you can use `delivered` and `read` statuses as the condition status. With SMS you can only use `delivered`.

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

```building_blocks
source: '_examples/olympus/send-message-with-failover-basic-auth'
```

## Concepts

```concept_list
product: messages-and-workflows-apis/workflows
```

## Building Blocks

```building_block_list
product: messages-and-workflows-apis/workflows
```

## Tutorials

```tutorials
product: messages-and-workflows-apis/workflows
```

## Reference

* [Workflows API Reference](/api/messages-and-workflows-apis/workflows)
