---
title: Before you begin
navigation_weight: 0
---

# Before you begin

## What are Code Snippets?

Code snippets are short pieces of code you can reuse in your own applications.
The code snippets use code from [example repositories](https://github.com/topics/nexmo-quickstart).

Please read this information carefully, so you can best use the code snippets.  

## Prerequisites

1. [Create a Vonage account](/account/guides/dashboard-management#create-and-configure-a-nexmo-account)
2. [Rent a Vonage Number](/numbers/guides/number-management#rent-a-virtual-number)
3. [Install the Vonage Command Line tools](/tools)
4. [Create a Vonage Application using the command line tools or Dashboard](/concepts/guides/applications#getting-started-with-applications)
5. [Install the Vonage Library for your programming language](/tools)
6. [Set up Ngrok](https://ngrok.com)

Other resources:

- [Our blog post on how to use Ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).

## Replaceable variables

### Generic replaceable

The following replaceable information depends on the library and specific call:

Key |	Description
-- | --
`VONAGE_API_KEY` | API key.
`VONAGE_API_SECRET` | API secret.
`VONAGE_APPLICATION_PRIVATE_KEY_PATH` |  Private key path.
`VONAGE_APPLICATION_PRIVATE_KEY` | Private key.
`VONAGE_APPLICATION_ID` | The Vonage Application ID.

### Numbers

All phone numbers are in E.164 format.

Key |	Description
-- | --
`VONAGE_NUMBER` | Replace with your Vonage Number. E.g. 447700900000
`TO_NUMBER` | Replace with the number you are calling. E.g. 447700900001
`SECOND_NUMBER` | Replace with number you are forwarding to. E.g. 447700900002

### UUIDs

UUIDs are typically used in the code snippets to identify a specific call.

Key |	Description
-- | --
`UUID` | Replace with the UUID of the call to modify. For example code use: `aaaaaaaa-bbbb-cccc-dddd-0123456789ab`.

### Specific replaceable/variables

Some code snippets have more specialized variables that will need to be
replaced by actual values. These may be specified on a per-code snippet basis.

## Authentication

Voice API requires authentication using JWTs. You can generate a JWT using the [Nexmo CLI](/concepts/authentication) or the [online tool](/jwt).

## Webhooks

The main ones you will meet here are:

* `/webhooks/answer` - Vonage makes a GET request here when you receive an inbound call. You respond with an NCCO.
* `/webhooks/event` - Vonage makes POST requests here when an event occurs. You receive a JSON event.
* `/webhooks/recordings` - Vonage makes a POST request here when the recording is available. You receive a JSON object with recording details.
* `/webhooks/dtmf` - Vonage POSTs user DTMF input here in a JSON object.

If you are using Ngrok you will set your webhook URLs in the Vonage Application object to
something like:

* `https://demo.ngrok.io/webhooks/answer`
* `https://demo.ngrok.io/webhooks/event`
* `https://demo.ngrok.io/webhooks/recordings`
* `https://demo.ngrok.io/webhooks/dtmf`

Change `demo` in the above with whatever applies in your case.
