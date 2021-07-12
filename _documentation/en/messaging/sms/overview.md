---
title: Overview
description: This documentation provides information on using the Vonage SMS API for sending and receiving text messages.
meta_title: Send and receive SMS with the SMS API
---

# SMS API

Vonage's SMS API enables you to send and receive text messages to and from users worldwide, using our REST APIs.

* Programmatically send and receive high volumes of SMS globally.
* Send SMS with low latency and high delivery rates.
* Receive SMS using local numbers.
* Scale your applications with familiar web technologies.
* Pay only for what you use, nothing more.
* [Auto-redact](/messaging/sms/guides/message-privacy) feature to protect privacy.

## Contents

This topic contains the following information:

* [Getting Started](#getting-started) - Information on how to get started quickly
* [Troubleshooting](#troubleshooting) - Message object status field and error code information
* [Concepts](#concepts) - Introductory concepts
* [Guides](#guides) - Learn how to use the SMS API
* [Code Snippets](#code-snippets) - Code snippets to help with specific tasks
* [Use Cases](#use-cases) - Use cases with code examples
* [Reference](#reference) - REST API documentation

## Getting Started

### Important 10 DLC guidelines for US customers

10 DLC stands for 10 Digit Long Code. Major US carriers have announced their requirements for a new standard for application-to-person (A2P) messaging in the USA, which applies to all messaging over 10 digit geographic phone numbers, also know as 10 DLC. This new standard provides many benefits including supporting higher messaging speeds and better deliverability.

Customers using the Vonage SMS API to send traffic from a **+1 Country Code 10 Digit Long Code into US networks** will need to register a brand and campaign in order to get approval for sending messages. 

To learn more about 10 DLC including important dates and carrier-specific information, see the **[10DLC Registration API](/messaging/10dlc/overview)**.

### Send an SMS

This example shows you how to send an SMS to your chosen number.

First, [sign up for a Vonage account](https://dashboard.nexmo.com/sign-up) if you don't already have one, and make a note of your API key and secret on the [dashboard getting started page](https://dashboard.nexmo.com/getting-started-guide).

Replace the following placeholder values in the sample code:

Key | Description
-- | --
`VONAGE_API_KEY` | Your Vonage API key.
`VONAGE_API_SECRET` | Your Vonage API secret.

```code_snippets
source: '_examples/messaging/sms/send-an-sms'
```

## Troubleshooting

If you have problems when making API calls be sure to check the returned [status field](/messaging/sms/guides/troubleshooting-sms) for specific [error codes](/messaging/sms/guides/troubleshooting-sms#sms-api-error-codes).

## Concepts

Before using the Vonage SMS API, familiarize yourself with the following:

* **[Number format](/voice/voice-api/guides/numbers)** - The SMS API requires phone numbers in E.164 format.

* **[Authentication](/concepts/guides/authentication)** - The SMS API authenticates using your account API key and secret.

* **[Webhooks](/concepts/guides/webhooks)** - The SMS API makes HTTP requests to your application web server so that you can act upon them. For example: inbound SMS and delivery receipts.

## Guides

```concept_list
product: messaging/sms
```

## Code Snippets

```code_snippet_list
product: messaging/sms
```

## Use Cases

```use_cases
product: messaging/sms
```

## Reference

* [SMS API Reference](/api/sms)
* [Response object status field](/messaging/sms/guides/troubleshooting-sms)
* [Error codes](/messaging/sms/guides/troubleshooting-sms#sms-api-error-codes)
