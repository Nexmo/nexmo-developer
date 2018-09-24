---
title: Overview
navigation_weight: 1
---

# Messages API Overview

The Messages API provides integration with the following communications channels:

* SMS
* Facebook Messenger
* Viber
* WhatsApp

Further channels may be supported in the future.

The following diagram illustrates the relationship between the Messages API and the Workflows API:

![Messages and Workflows Overview](/assets/images/messages-workflows-overview.png)

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

The following code shows how to send an SMS message using the Messages API:

```building_blocks
source: '_examples/olympus/send-sms-basic-auth'
```

In the above example you will need to replace the following variable with actual values:

Key | Description
-- | --
`NEXMO_API_KEY` | Nexmo API key which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | Nexmo API secret which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`FROM_NUMBER` | A phone number you own or some text to identify the sender.
`TO_NUMBER` | The number of the phone to which the message will be sent.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

### Run the code

The example code will send an SMS to the number specified and return the message ID.

## Nexmo Node library support

In addition to using the Messages and Workflows API via HTTP, the Nexmo Node client library also provides support. 

During the Developer Preview the Node client library with support for the Messages and Workflows API can be installed using:

```
$ npm install nexmo@beta
```

If you decide to use the client library you will need the following information:

Key | Description
-- | --
`NEXMO_API_KEY` | The Nexmo API key which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | The Nexmo API secret which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_ID` | The Nexmo Application ID for your Nexmo Application which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | The path to the `private.key` file that was generated when you created your Nexmo Application.

These variables can then be replaced with actual values in the client library example code.
