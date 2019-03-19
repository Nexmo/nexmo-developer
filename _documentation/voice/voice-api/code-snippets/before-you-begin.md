---
title: Before you begin
navigation_weight: 1
---

# Before you begin

## What are Code Snippets?

Code Snippets are short pieces of code you can reuse in your own applications.
The Code Snippets utilise code from the [Nexmo Quickstart](https://github.com/nexmo-community) repositories.

Please read this information carefully, so you can best use the Code Snippets.  

## Prerequisites

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account)
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers)
3. [Install the Nexmo Command Line tools](/tools)
4. [Create a Nexmo Application using the command line tools or Dashboard](/concepts/guides/applications#getting-started-with-applications)
5. [Install the Nexmo Library for your programming language](/tools)
6. [Set up Ngrok](https://ngrok.com)

Other resources:

- [Nexmo's blog post on how to use Ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).

## Replaceable variables

### Generic replaceable

The following replaceable information depends on the library and specific call:

Key |	Description
-- | --
`NEXMO_API_KEY` | API key.
`NEXMO_API_SECRET` | API secret.
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` |  Private key path.
`NEXMO_APPLICATION_PRIVATE_KEY` | Private key.
`NEXMO_APPLICATION_ID` | The Nexmo Application ID.

### Numbers

All phone numbers are in E.164 format.

Key |	Description
-- | --
`NEXMO_NUMBER` | Replace with your Nexmo Number. E.g. 447700900000
`TO_NUMBER` | Replace with the number you are calling. E.g. 447700900001
`SECOND_NUMBER` | Replace with number you are forwarding to. E.g. 447700900002

### UUIDs

UUIDs are typically used in the Code Snippets to identify a specific call.

Key |	Description
-- | --
`UUID` | Replace with the UUID of the call to modify. For example code use: `aaaaaaaa-bbbb-cccc-dddd-0123456789ab`.

### Specific replaceable/variables

Some Code Snippets have more specialised variables that will need to be
replaced by actual values. These may be specified on a per-Code Snippet basis.

## Webhooks

The main ones you will meet here are:

* `/webhooks/answer` - Nexmo callback GETs from here. You supply an NCCO.
* `/webhooks/event` - Nexmo callback POSTs to here. You receive JSON event.
* `/webhooks/recordings` - Nexmo callback POSTs to here. You receive JSON object with recording details.
* `/webhooks/dtmf` - Nexmo POSTs user DTMF input here in a JSON object.

If you are using Ngrok you will set your webhook URLs in the Nexmo Application object to
something like:

* `https://demo.ngrok.io/webhooks/answer`
* `https://demo.ngrok.io/webhooks/event`
* `https://demo.ngrok.io/webhooks/recordings`
* `https://demo.ngrok.io/webhooks/dtmf`

Change `demo` in the above with whatever applies in your case.
