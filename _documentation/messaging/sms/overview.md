---
title: Overview
meta_title: Send and receive SMS with the SMS API
---

# SMS API

Nexmo's SMS API enables you to send and receive text messages to and from users worldwide, using simple REST APIs.

* Programmatically send and receive high volumes of SMS globally.
* Send SMS with low latency and high delivery rates.
* Receive SMS using local numbers.
* Scale your applications with familiar web technologies.
* Pay only for what you use, nothing more.

## Getting Started

### Send an SMS

This example shows you how to send an SMS to your chosen number.

First, [sign up for a Nexmo account](https://dashboard.nexmo.com/sign-up) if you don't already have one, and make a note of your API key and secret on the [dashboard getting started page](https://dashboard.nexmo.com/getting-started-guide).

Replace the following placeholder values in the sample code:

Key | Description
-- | --
`NEXMO_API_KEY` | Your Nexmo API key.
`NEXMO_API_SECRET` | Your Nexmo API secret.

```code_snippets
source: '_examples/messaging/sms/send-an-sms'
```

## Contents

The rest of this document contains the following information:

* [Nexmo SMS API Concepts](#concepts) - what you need to know
* [Guides](#guides) - learn how to use the SMS API
* [Code Snippets](#code-snippets) - code snippets to help with specific tasks
* [Use Cases](#use-cases) - detailed use cases with code examples
* [Reference](#reference) - complete API documentation

## Concepts

Before using the Nexmo SMS API, familiarize yourself with the following:

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
