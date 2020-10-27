---
title: Before you Begin
navigation_weight: 0
---

# Before you Begin

This topic provides some background information on using the code snippets.

## What are Code Snippets?

Code snippets are short pieces of code you can reuse in your own applications.

The code snippets utilize code from the [Vonage Node Code Snippets](https://github.com/Nexmo/nexmo-node-code-snippets) and [Vonage Curl Code Snippets](https://github.com/Nexmo/nexmo-curl-code-snippets) repositories.

Please read this information carefully, so you can best use the code snippets.

```partial
source: _partials/reusable/prereqs.md
```

## Replaceable variables

### Generic replaceable

The following replaceable information depends on the library and specific call:

Key | Description
-- | --
`VONAGE_API_KEY` | API key.
`VONAGE_API_SECRET` | API secret.
`VONAGE_APPLICATION_PRIVATE_KEY_PATH` |  Private key path.
`VONAGE_APPLICATION_PRIVATE_KEY` | Private key.
`VONAGE_APPLICATION_ID` | The Vonage Application ID.

### Numbers

All phone numbers are in E.164 format.

Key | Description
-- | --
`VONAGE_NUMBER` | Replace with your Vonage Number. E.g. 447700900000
`FROM_NUMBER` | Replace with number you are sending from. E.g. 447700900002
`TO_NUMBER` | Replace with the number you are sending to. E.g. 447700900001

### Specific replaceable/variables

Some code snippets have more specialized variables, such as Facebook Page IDs, that will need to be replaced by actual values. Where required, these are specified on a per-code snippet basis.

## Webhooks

The main ones you will meet here are:

* `/webhooks/inbound-message` - You will receive a callback here when Vonage receives a message.
* `/webhooks/message-status` - You will receive a callback here when Vonage receives a message status update.

If you are testing locally using [Ngrok](https://ngrok.com) you will set your webhook URLs in the Vonage Application object using a format similar to the following examples:

* `https://demo.ngrok.io/webhooks/inbound-message`
* `https://demo.ngrok.io/webhooks/message-status`

Change `demo` in the above with whatever Ngrok generates for you, unless you have paid for a reusable URL.

> **NOTE:** Make sure your webhook URLs are configured and your webhooks server is running before testing your application.

```partial
source: _partials/reusable/generate-a-jwt.md
```
