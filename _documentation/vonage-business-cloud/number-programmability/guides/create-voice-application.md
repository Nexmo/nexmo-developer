---
title: Create a Nexmo Voice application
description: The application stores security and configuration information for your interaction with the Voice API.
navigation_weight: 2
---

# Create a Nexmo Application

Every Number Programmability service application that you build must be associated with a Nexmo Voice Application.

> **Note**: To avoid confusion, `Application` here refers to the Nexmo Application. The application you are building will be referred to as "application".

A Nexmo Application stores configuration information such as details of the programmable numbers and webhook callback URLs that your application uses. To make your VBC programmability service calls zero-rated in Nexmo, you must create an Application with the `vbc` capability.

## Creating a Nexmo Voice Application with the Application API

> **Note**: The `vbc` capability is only available in [version 2 of the Nexmo Application API](https://developer.nexmo.com/api/application.v2). The [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) utility and [Developer Dashboard](https://dashboard.nexmo.com/voice/create-application) use version 1, therefore you cannot use them for this purpose.

To create a Nexmo Application with the `vbc` capability, issue the following `curl` command, replacing `NEXMO_API_KEY` and `NEXMO_API_SECRET` with your Nexmo API key and secret respectively. You can find this information in the [Nexmo Developer dashboard](https://dashboard.nexmo.com/getting-started-guide).

```
curl -X POST \
  https://api.nexmo.com/v2/applications \
  -H 'Authorization: Basic base64($NEXMO_API_KEY:$NEXMO_API_SECRET' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "My Nexmo VBC Application",
    "capabilities": {"vbc": {} }
  }'
```

The response is a JSON object containing the Nexmo Application `id` that you will use to interact with the Nexmo Voice API.

```
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
        "vbc": {}
    },
    "_links": {
        "self": {
            "href": "/v2/applications/27aa0583-7246-4822-aabb-17b03c25d52e"
        }
    }
}
```

> The next step is to [provision the Number Programmability service](/vonage-business-cloud/number-programmability/guides/provision-nps) using the Nexmo Application `id`.
