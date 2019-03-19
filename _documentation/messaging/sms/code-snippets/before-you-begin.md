---
title: Before you begin
navigation_weight: 1
---

# Before you Begin

## What are Code Snippets?

Code Snippets are short pieces of code you can reuse in your own applications.
The Code Snippets use code from the [Nexmo Quickstart](https://github.com/nexmo-community) repositories.

Please read this information carefully before attempting to use the Code Snippets.  

## Prerequisites

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account) - so that you can access your API key and secret to authenticate requests.
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers) - if you want to receive inbound SMS.
3. [Install a REST Client library](/tools) - for your chosen programming language.

## Webhooks

If you want to receive incoming SMS or delivery receipts, you will need to create a [webhook](https://developer.nexmo.com/concepts/guides/webhooks). Nexmo needs to be able to access your webhook via the public internet.

During development you can use [Ngrok](https://ngrok.com) to expose the webhooks you create on your local machine to Nexmo's APIs. See [Using Ngrok for local development](https://developer.nexmo.com/concepts/guides/webhooks#using-ngrok-for-local-development) for details of how to set up and use Ngrok.


