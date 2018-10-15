---
title: Before you begin
navigation_weight: 0
---

# Before you begin

## What are building blocks?

Building blocks are short pieces of code you can reuse in your own applications.
The building blocks utilise code from the [Nexmo Node Quickstart](https://github.com/nexmo-community/nexmo-node-quickstart) and [Curl Building Block](https://github.com/Nexmo/curl-building-blocks) repositories.

Please read this information carefully, so you can best use the building blocks.  

## Prerequisites

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account)
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers)
3. [Install the Nexmo Command Line tools](/tools)
4. [Create a Nexmo Application in the Dashboard](https://dashboard.nexmo.com/messages/create-application)
5. [Install the Nexmo Node Client Library](/messages/concepts/client-library) - if writing applications using Node.
6. [Set up Ngrok](https://ngrok.com) - if testing locally.

Other resources:

- [Nexmo's blog post on how to use Ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).

## Replaceable variables

### Generic replaceable

The following replaceable information depends on the library and specific call:

Key | Description
-- | --
`NEXMO_API_KEY` | API key.
`NEXMO_API_SECRET` | API secret.
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` |  Private key path.
`NEXMO_APPLICATION_PRIVATE_KEY` | Private key.
`NEXMO_APPLICATION_ID` | The Nexmo Application ID.

### Numbers

All phone numbers are in E.164 format.

Key | Description
-- | --
`NEXMO_NUMBER` | Replace with your Nexmo Number. E.g. 447700900000
`FROM_NUMBER` | Replace with number you are sending from. E.g. 447700900002
`TO_NUMBER` | Replace with the number you are sending to. E.g. 447700900001

### Specific replaceable/variables

Some building blocks have more specialised variables, such as Facebook Page IDs, that will need to be replaced by actual values. Where required, these are specified on a per-building block basis.

## Webhooks

The main ones you will meet here are:

* `/webhooks/inbound-message` - You will receive a callback here when Nexmo receives a message.
* `/webhooks/message-status` - You will receive a callback here when Nexmo receives a message status update.

If you are testing locally using [Ngrok](https://ngrok.com) you will set your webhook URLs in the Nexmo Application object using a format similar to the following examples:

* `https://demo.ngrok.io/webhooks/inbound-message`
* `https://demo.ngrok.io/webhooks/message-status`

Change `demo` in the above with whatever Ngrok generates for you, unless you have paid for a reusable URL.
