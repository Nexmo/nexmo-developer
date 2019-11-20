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

1. [Create a Nexmo account](/account/guides/dashboard-management#create-and-configure-a-nexmo-account) - so that you can access your API key and secret to authenticate requests.
2. [Rent a Nexmo Number](/numbers/guides/number-management#rent-a-virtual-number) - if you want to receive inbound SMS.
3. [Install a REST Client library](/tools) - for your chosen programming language.

## Webhooks

If you want to receive incoming SMS or delivery receipts, you will need to create a [webhook](/concepts/guides/webhooks). Nexmo needs to be able to access your webhook via the public internet.

During development you can use [Ngrok](https://ngrok.com) to expose the webhooks you create on your local machine to Nexmo's APIs. See [Using Ngrok for local development](/concepts/guides/testing-with-ngrok) for details of how to set up and use Ngrok.
