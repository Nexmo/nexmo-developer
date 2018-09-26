---
title: Overview
navigation_weight: 1
---

# Messages API Overview

The Messages API allows you to send and in some cases receive messages over the following communications channels:

* SMS
* Facebook Messenger
* Viber
* WhatsApp

Further channels may be supported in the future.

The following diagram illustrates the relationship between the Messages API and the Workflows API:

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

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Messages API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

During Developer Preview Nexmo will expand the capabilities of the API.

## Supported features

In this release the following features are supported:

Channel | Outbound Text | Outbound Image | Outbound Audio | Outbound Video | Outbound File | Outbound Template
-- | -- | -- | -- | -- | -- | --
SMS | ✅ | n/a | n/a | n/a | n/a | n/a
Viber Service Messages | ✅ | ✅ | n/a | n/a | n/a | ✅
Facebook Messenger | ✅ | ✅ | ✅ | ✅ | ✅ | ✅
WhatsApp | ✅ | ❎ | ❎ | ❎ | ❎ | ✅

Channel | Inbound Text | Inbound Image | Inbound Audio | Inbound Video | Inbound File | Inbound Location
-- | -- | -- | -- | -- | -- | --
Facebook Messenger | ✅ | ✅ | ✅ | ✅ | ✅ | ✅
WhatsApp | ✅ | ❎ | ❎ | ❎ | ❎ | ❎

**Key:** 

* ✅ = Supported. 
* ❎ = Supported by the channel, but not by Nexmo. 
* n/a = Not supported by the channel.

## Getting started

In this example you will need to replace the following variables with actual values using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | Nexmo API key which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | Nexmo API secret which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`FROM_NUMBER` | A phone number you own or some text to identify the sender.
`TO_NUMBER` | The number of the phone to which the message will be sent.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

The following code shows how to send an SMS message using the Messages API:

```building_blocks
source: '_examples/olympus/send-sms-basic-auth'
```

## Concepts

```concept_list
product: messages-and-workflows-apis/messages
```

## Building Blocks

```building_block_list
product: messages-and-workflows-apis/messages
```

## Tutorials

```tutorials
product: messages-and-workflows-apis/messages
```

## Reference

* [Messages API Reference](/api/messages-and-workflows-apis/messages)
