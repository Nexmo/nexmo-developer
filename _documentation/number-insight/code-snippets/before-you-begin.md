---
title: Before you begin
navigation_weight: 1
---

# Before you Begin

## What are Code Snippets?

Code snippets are short pieces of code you can reuse in your own applications.
The code snippets use code from [example repositories](https://github.com/topics/nexmo-quickstart).

Please read this information carefully before attempting to use the code snippets.  

## Prerequisites

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account)
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers)
3. [Install the Nexmo Library for your programming language](/tools)
4. [Set up Ngrok](https://ngrok.com)

## Other resources:

The following resources will help you use the [Number Insight Advanced Async](number-insight-advanced-async) code snippet:

- [Webhooks](https://developer.nexmo.com/concepts/guides/webhooks)
- [Using Ngrok for local development](https://developer.nexmo.com/concepts/guides/webhooks#using-ngrok-for-local-development)

## Replaceable variables

Replace the following values in the code snippets with your own details:

Key |	Description
-- | --
`NEXMO_API_KEY` | API key.
`NEXMO_API_SECRET` | API secret.
`INSIGHT_NUMBER` | The number you want to retrieve insight information for.

## Webhooks

The Basic and Standard levels of the Number Insight API are synchronous and do not require webhooks.

The Advanced level of the Number Insight API enables you to optionally deliver an asynchronous `POST` response to a webhook when the data becomes available.

In the code snippets, the webhook is located at `/webhooks/insight`. If you are using Ngrok, the webhook you need to configure in your client is of the form `https://demo.ngrok.io/webhooks/insight`. Replace `demo` with the subdomain provided by Ngrok.
