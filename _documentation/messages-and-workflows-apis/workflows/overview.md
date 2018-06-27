---
title: Overview
---

# Workflows API Overview

The Workflows API enables the developer to send messages to users using a multiple channel strategy. 

An example workflow might specify a message to be sent a message via Facebook Messenger, and if that message is not read then the user can be sent a message via Viber. If that message is also not read a user could then be sent a message via SMS.

The Workflows API provides the mechanism by which to order messages and specify their _success conditions_. The Workflows API uses the Messages API to actually send the messages.

In this release you can:

* **Send** SMS, Facebook Messenger and Viber Service Messages with Workflows built on-top of the the [Messages API](/messages-and-workflows-apis/messages/overview).
* **Failover** to the next message if the condition status is not met within the time period or if the message immediately fails.

The condition status is the status that the message returns. With Facebook Messenger and Viber Service Messages, you can use `delivered` and `read` statuses as the condition status. With SMS you can only use `delivered`.

The following diagram illustrates the relationship between the Workflows API and the Messages API:

![Messages and Workflows Overview](/assets/images/messages-workflows-overview.png)

## Developer Preview

This API is currently in Developer Preview and you will need to [request access](https://www.nexmo.com/products/messages) to use it.

In this release Nexmo provides a failover template. The failover template instructs the [Messages API](messages-and-workflows-apis/messages/overview) to send a message to the specified channel. If that message fails immediately or if the `condition_status` is not reached within the specified time period the next message is sent.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Workflow API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

## Getting started

The following code shows how to create a workflow that attempts to send a message via Facebook messenger and if not read within the time limit a message will be sent via SMS:

```
curl -X POST https://api.nexmo.com/beta/workflows \
  -u 'NEXMO_API_KEY:NEXMO_API_SECRET' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "template":"failover",
    "workflow": [
      {
        "from": { "type": "messenger", "id": "SENDER_ID" },
        "to": { "type": "messenger", "id": "RECIPIENT_ID" },
        "message": {
          "content": {
            "type": "text",
            "text": "This is a Facebook Messenger Message sent from the Workflows API"
          }
        },
        "failover":{
          "expiry_time": 600,
          "condition_status": "read"
        }
      },
      {
        "from": {"type": "sms", "number": "FROM_NUMBER"},
        "to": { "type": "sms", "number": "TO_NUMBER"},
        "message": {
          "content": {
            "type": "text",
            "text": "This is an SMS sent from the Workflows API"
          }
        }
      }
    ]
  }'
```

In the above example code you will need to replace the following variables with actual values:

Key | Description
-- | --
`NEXMO_API_KEY` | Nexmo API key which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | Nexmo API secret which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`SENDER_ID` | Your Page ID. The `SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`RECIPIENT_ID` | The PSID of the user you want to reply to. The `RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FROM_NUMBER` | A phone number you own or some text to identify the sender.
`TO_NUMBER` | The number of the phone to which the message will be sent.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

### Run the code

The example code will send a message via Facebook Messenger and if not read within the expiry time an SMS will be sent.

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
