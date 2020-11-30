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

```snippet_variables
- VONAGE_API_KEY
- VONAGE_API_SECRET
- VONAGE_APPLICATION_PRIVATE_KEY_PATH
- VONAGE_APPLICATION_PRIVATE_KEY
- VONAGE_APPLICATION_ID
```

### Numbers

All phone numbers are in E.164 format.

```snippet_variables
- VONAGE_NUMBER
- FROM_NUMBER.MESSAGES
- TO_NUMBER.MESSAGES
```

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
