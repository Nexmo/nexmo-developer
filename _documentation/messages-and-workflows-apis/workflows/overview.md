---
title: Overview
---

# Workflows Overview

The Workflows API enables the developer to specify a multiple message workflow.

## Developer Preview

In this release Nexmo provides a failover template. The failover template instructs the [Messages API](messages-and-workflows-apis/messages/overview) to send a message to the specified channel. If that message fails immediately or if the `condition_status` is not reached within the specified time period the next message is sent.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Workflow API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

## Contents

* [Concepts](#concepts)
* [Quickstart](#quickstart)
* [Guides](#guides)
* [Building Blocks](#building-blocks)
* [Reference](#reference)

## Concepts

To use Workflows API, you may need to familiarise yourself with:

* **[Authentication](/concepts/guides/authentication)** - The Workflows API is authenticated with either [Header-based API Key and Secret Authentication](/concepts/guides/authentication#header-based-api-key-secret-authentication) or [JSON Web Tokens (JWT)](/concepts/guides/authentication#json-web-tokens-jwt).
* **[Messages](/messages-and-workflows-apis/messages/overview)** - The Messages API is used for sending messages to a single channel.

## Quickstart

In this release you can:

* **Send** SMS, Facebook Messenger and Viber Service Messages with Workflows built on-top of the the [Messages API](/messages-and-workflows-apis/messages/overview).
* **Failover** to the next message if the condition status is not met within the time period or if the message immediately fails.

The condition status is the status that the message returns. With Facebook Messenger and Viber Service Messages, you can use `delivered` and `read` statuses as the condition status. With SMS you can only use `delivered`.

An example is shown here:

```
curl -X POST https://api.nexmo.com/beta/workflows \
  -u 'API_KEY:API_SECRET' \
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

In this example the workflow attempts to send a Facebook Messenger message, and if this fails (the success condition in this example is `read`), then an SMS is sent.

## Guides

* [Failover](/messages-and-workflows-apis/workflows/guides/failover): how to set up your account and environment to send a message using Facebook Messenger with fallback to SMS.

## Building Blocks

* [Send a message with failover](/messages-and-workflows-apis/workflows/building-blocks/send-a-message-with-failover): the core details of how to use the Workflows API for sending messages with failover.

## Reference

* [Messages API Reference](/api/messages-and-workflows-apis/messages)
* [Workflows API Reference](/api/messages-and-workflows-apis/workflows)
