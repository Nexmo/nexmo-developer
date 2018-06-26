---
title: Overview
navigation_weight: 1
---

# Messages API Overview

The Messages API provides integration with the following communications channels:

* SMS
* Facebook Messenger
* Viber

Further channels may be supported in the future.

In this release the following features are supported:

* Outbound text messages on SMS, Viber Service Messages and Facebook Messenger.
* Outbound image message on Viber Service Messages.
* Outbound image, audio, video and file messages on Facebook Messenger.
* Inbound text, image, audio, video, file and location messages on Facebook Messenger.

The following diagram illustrates the relationship between the Messages API and the Workflows API:

![Messages and Workflows Overview](/assets/images/messages-workflows-overview.png)

## Developer Preview

This API is currently in Developer Preview and you will need to [request access](https://www.nexmo.com/products/messages) to use it.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Messages API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

During Developer Preview Nexmo will expand the capabilities of the API.

## Getting started

The following code shows how to send an SMS message using the Messages API:

```
curl -X POST https://api.nexmo.com/beta/messages \
     -u 'NEXMO_API_KEY:NEXMO_API_SECRET' \
     -H 'Content-Type: application/json' \
     -H 'Accept: application/json' \
     -d $'{
	      "from": { "type": "sms", "number": "FROM_NUMBER" },
	      "to": { "type": "sms", "number": "TO_NUMBER" },
	      "message": {
	        "content": {
		      "type": "text",
		      "text": "This is an SMS sent from the Messages API"
	    }
   }
}'
```

In the above example you will need to replace the following variable with actual values:

Key | Description
-- | --
`NEXMO_API_KEY` | Nexmo API key which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | Nexmo API secret which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`FROM_NUMBER` | A phone number you own or some text to identify the sender.
`TO_NUMBER` | The number of the phone to which the message will be sent.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

### Run the code

The example code will send an SMS to the number specified and return the message ID.

## Nexmo Node library support

In addition to using the Messages and Workflows API via HTTP, the Nexmo Node client library also provides support. 

During the Developer Preview the Node client library with support for the Messages and Workflows API can be installed using:

```
$ npm install nexmo@beta
```

If you decide to use the client library you will need the following information:

Key | Description
-- | --
`NEXMO_API_KEY` | The Nexmo API key which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | The Nexmo API secret which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_ID` | The Nexmo Application ID for your Nexmo Application which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | The path to the `private.key` file that was generated when you created your Nexmo Application.

These variables can then be replaced with actual values in the client library example code.
