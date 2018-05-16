---
title: Overview
---

# Workflows Overview [Developer Preview]

The Workflows API enables the developer to specify a multiple message workflow. The first one we are adding is the failover template. The failover template instructs the [Messages API](messages-and-workflows-apis/messages/overview) to first send a message to the specified channel. If that message fails immediately or if the condition_status is not reached within the given time period the next message is sent. 

```
curl -X POST https://api.nexmo.com/beta/workflows \
  -H 'Authorization: Basic base64(API_KEY:API_SECRET)'\
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

* **Send** SMS, Facebook Messenger and Viber Service Messages with Workflows built on-top of the the [Messages API](/messages-and-workflows-apis/messages/overview).
* **Failover** to the next message if the success condition is not met within the time period or if the message immediately fails.

The success condition is the status that the message returns. With Facebook Messenger and Viber Service Messages, you can use `delivered` and `read` statuses as the success condition. With SMS you can only use `delivered`.

There may be bugs and quirks so we'd welcome your feedback - any suggestions you make help us shape the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Workflows API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

## Contents

* [Concepts](#concepts)
* [Building Blocks](#building-blocks)
* [Guides](#guides)
* [Reference](#reference)

## Concepts

To use Workflows API, you may need to familiarise yourself with:

* **[Authentication](/concepts/guides/authentication)** - The Workflows API is authenticated with either [Header-based API Key & Secret Authentication](/concepts/guides/authentication#header-based-api-key-secret-authentication) or [JSON Web Tokens (JWT)](/concepts/guides/authentication#json-web-tokens-jwt).
* **[Messages](/messages-and-workflows-apis/messages/overview)** - The Messages API is used for sending messages to a single channel.

## Building Blocks

* [Send a message with failover](/messages-and-workflows-apis/workflows/building-blocks/send-a-message-with-failover): the core details of how to use the Workflows API for sending messages with failover

## Guides

* [Failover](/messages-and-workflows-apis/workflows/guides/failover): how to set up your account and environment to send a message using Viber with fallback to SMS

## Reference

* [Messages API Reference](/api/messages-and-workflows-apis/messages)
* [Workflows API Reference](/api/messages-and-workflows-apis/workflows)
