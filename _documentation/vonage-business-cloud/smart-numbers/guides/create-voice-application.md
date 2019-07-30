---
title: Create a Nexmo Voice application
description: The application stores security and configuration information for your interaction with the Voice API.
navigation_weight: 2
---

# Create a Nexmo Application

Every Smart Numbers application that you build must be associated with a Nexmo Voice Application.

> **Note**: To avoid confusion, `Application` here refers to the Nexmo Application. The application you are building will be referred to as "application".

A Nexmo Application stores configuration information such as details of the programmable numbers and webhook callback URLs that your application uses. To make your VBC Smart Number calls zero-rated in Nexmo, you must create an Application with the `vbc` and `voice` capabilities, using the [Nexmo Application API](https://developer.nexmo.com/api/application.v2).

## Using the Application API

To create a Nexmo Application for working with Smart Numbers, issue the `curl` command shown below, replacing `NEXMO_API_KEY` and `NEXMO_API_SECRET` with your Nexmo API key and secret respectively. You can find this information in the [Nexmo Developer dashboard](https://dashboard.nexmo.com/getting-started-guide).

The two URLs you provide refer to the webhook endpoints that your application will expose to Nexmo's servers:

* The first is the webhook that Nexmo's APIs will make a request to when a call is received on your Smart Number.
* The second is where Nexmo's APIs will post details about events that your application might be interested in - such as a call being answered or terminated.


```sh
curl -X POST \
  https://api.nexmo.com/v2/applications \
  -H 'Authorization: Basic Base64($NEXMO_API_KEY:$NEXMO_API_SECRET)' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "My Nexmo VBC Application",
    "capabilities": {
      "vbc": {},
      "voice": {
        "webhooks": {
          "answer_url": {
            "address": "https://example.com/webhooks/answer",
            "http_method": "POST"
          },
          "event_url": {
            "address": "https://example.com/webhooks/event",
            "http_method": "POST"
          }
        }
      }
	  }
  }'
```

The response is a JSON object containing the Nexmo Application `id` that you will use to interact with the Nexmo Voice API.

```json
{
  "id": "27aa0583-7246-4822-aabb-17b03c25d52e",
  "name": "My Nexmo VBC Application",
  "keys": {
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkq...
    -----END PRIVATE KEY-----\n",
    "public_key": "-----BEGIN PUBLIC_KEY-----\nMIIBIjANBgkqh...
    -----END PUBLIC KEY-----\n"
  },
  "capabilities": {
    "voice": {
      "webhooks": {
        "event_url": {
            "address": "https://example.com/webhooks/event",
            "http_method": "POST"
        },
        "answer_url": {
            "address": "https://example.com/webhooks/answer",
            "http_method": "POST"
        }
      }
    },
    "vbc": {}
  },
  "_links": {
    "self": {
      "href": "/v2/applications/27aa0583-7246-4822-aabb-17b03c25d52e"
    }
  }
}
```

> The next step is to [provision Smart Numbers](/vonage-business-cloud/smart-numbers/guides/provision-smart-numbers) using the Nexmo Application `id`.
