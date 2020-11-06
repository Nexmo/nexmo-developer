---
title: Overview
meta_title: Send messages via SMS, MMS, WhatsApp, Viber and Facebook Messenger with a single API. 
description: The Messages API allows you to send and in some cases receive messages over SMS/MMS, Facebook Messenger, Viber, WhatsApp. 
navigation_weight: 1
---

# Messages API Overview

The Messages API allows you to send and in some cases receive messages over SMS, MMS, Facebook Messenger, Viber, and WhatsApp. Further channels may be supported in the future.

The following diagram illustrates how the Vonage Messages API enables you to easily send messages over multiple channels:

<img src="/images/messages-overview.png" alt="Messages and Dispatch Overview" style="width: 75%;">

## Contents

* [Beta](#beta)
* [Supported features](#supported-features)
* [External Accounts API](#external-accounts-api)
* [Getting started](#getting-started)
* [Concepts](#concepts)
* [Code Snippets](#code-snippets)
* [Tutorials](#tutorials)
* [Use Cases](#use-cases)
* [Reference](#reference)

## Beta

This API is currently in Beta.

Vonage always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include the Messages API in the subject line. Please note that during the Beta period, support times are limited to Monday to Friday.

During Beta Vonage will expand the capabilities of the API.

## Supported features

In this release the following features are supported:

Channel | Outbound Text | Outbound Image | Outbound Audio | Outbound Video | Outbound File | Outbound Template
:--- | :---: | :---: | :---: | :---: | :---: | :---:
SMS | ✅ | n/a | n/a | n/a | n/a | n/a
MMS | ✅ | ✅ | n/a | n/a | n/a | n/a
Viber Service Messages | ✅ | ✅ | n/a | n/a | n/a | ✅
Facebook Messenger | ✅ | ✅ | ✅ | ✅ | ✅ | ✅
WhatsApp | ✅ | ✅ | ✅ | ✅ | ✅ | ✅

Channel | Inbound Text | Inbound Image | Inbound Audio | Inbound Video | Inbound File | Inbound Location
:--- | :---: | :---: | :---: | :---: | :---: | :---:
MMS | ✅ | ✅ | n/a | n/a | n/a | n/a
Viber Service Messages | ✅ | n/a | n/a | n/a | n/a | n/a
Facebook Messenger | ✅ | ✅ | ✅ | ✅ | ✅ | ✅
WhatsApp | ✅ | ✅ | ✅ | ✅ | ✅ | ✅

Limited support is also provided for [custom objects](/messages/concepts/custom-objects):

Channel | Outbound Button | Outbound Location | Outbound Contact
:--- | :---: | :---: | :---:
SMS | n/a | n/a | n/a
MMS | n/a | n/a | n/a
Viber Service Messages | ✅ | n/a | n/a
Facebook Messenger | ✅ | n/a | n/a
WhatsApp | ✅ | ✅ | ✅

**Key:**

* ✅ = Supported.
* ❌ = Supported by the channel, but not by Vonage.
* n/a = Not supported by the channel.

## External Accounts API

The [External Accounts API](/api/external-accounts) is used to manage your accounts for Viber Service Messages, Facebook Messenger and WhatsApp when using those channels with the Messages and Dispatch APIs.

## Getting started

In this example you will need to replace the following variables with actual values using any convenient method:

Key | Description
-- | --
`VONAGE_API_KEY` | Vonage API key which can be obtained from your [Vonage API Dashboard](https://dashboard.nexmo.com).
`VONAGE_API_SECRET` | Vonage API secret which can be obtained from your [Vonage API Dashboard](https://dashboard.nexmo.com).
`FROM_NUMBER` | A phone number you own or some text to identify the sender.
`TO_NUMBER` | The number of the phone to which the message will be sent.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

The following code shows how to send an SMS message using the Messages API:

```code_snippets
source: '_examples/messages/sms/send-sms-basic-auth'
```

## Concepts

```concept_list
product: messages
```

## Code Snippets

```code_snippet_list
product: messages
```

## Tutorials

* [How to send an SMS message](/messages/tutorials/send-sms-with-messages/introduction)
* [How to send a Viber message](/messages/tutorials/send-viber-message/introduction)
* [How to send a WhatsApp message](/messages/tutorials/send-whatsapp-message/introduction)
* [How to send a Facebook Messenger message](/messages/tutorials/send-fbm-message/introduction)

## Use Cases

```use_cases
product: messages
```

## Reference

* [Messages API Reference](/api/messages-olympus)
* [External Accounts API Reference](/api/external-accounts)
