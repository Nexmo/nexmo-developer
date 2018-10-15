---
title: Before you begin
navigation_weight: 1
---

# Before you Begin

## What are building blocks?

Building blocks are short pieces of code you can reuse in your own applications.
The building blocks use code from the [Nexmo Quickstart](https://github.com/nexmo-community) repositories.

Please read this information carefully before attempting to use the building blocks.  

## Prerequisites

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account)
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers)
3. [Install the Nexmo Library for your programming language](/tools)
4. [Set up Ngrok](https://ngrok.com)

## Other resources:

The following resources will help you use the [Number Insight Advanced Async](number-insight-advanced-async) building block:

- [Webhooks](https://developer.nexmo.com/concepts/guides/webhooks)
- [Using Ngrok for local development](https://developer.nexmo.com/concepts/guides/webhooks#using-ngrok-for-local-development)

## Replaceable variables

Replace the following values in the building blocks with your own details:

Key |	Description
-- | --
`NEXMO_API_KEY` | API key.
`NEXMO_API_SECRET` | API secret.
`INSIGHT_NUMBER` | The number you want to retrieve insight information for.

## Webhooks

The Basic and Standard levels of the Number Insight API are synchronous and do not require webhooks.

The Advanced level of the Number Insight API enables you to optionally deliver an asynchronous `POST` response to a webhook when the data becomes available.

In the building blocks, the webhook is located at `/webhooks/insight`. If you are using Ngrok, the webhook you need to configure in your client is of the form `https://demo.ngrok.io/webhooks/insight`. Replace `demo` with the subdomain provided by Ngrok.
