---
title: Signed Webhooks
description: A method for your application to verify a request is coming from Vonage.
navigation_weight: 8
---

# Signed Webhooks [Beta]

Signed webhooks provide a method for your application to verify a request is coming from Vonage, and its payload has not been tampered with during transit. 

## Activation

Voice API Signed webhooks are currently offered as [Beta](/product-lifecycle/beta), activation can be done through Applications API request only. Follow these steps to activate signed callbacks for your application.

### Get Application

Retrieve your application data with a [Get an application](/api/application.v2#getApplication) HTTP request using [Postman](/tools/postman) or another HTTP client of your choice:

```http
GET https://api.nexmo.com/v2/applications/YOUR_APPLICATION_ID
```

Copy the response body:

```json
{
    "id": "YOUR_APPLICATION_ID",
    "name": "My app",
    "keys": {
        "public_key": "YOUR_PUBLIC_KEY"
    },
    "capabilities": {
        "voice": {
            "webhooks": {
                "event_url": {
                    "address": "https://example.com",
                    "http_method": "POST"
                },
                "fallback_answer_url": {
                    "address": "",
                    "http_method": "GET"
                },
                "answer_url": {
                    "address": "https://example.com",
                    "http_method": "GET"
                }
            }
        }
    },
    "_links": {
        "self": {
            "href": "/v2/applications/YOUR_APPLICATION_ID"
        }
    }
}
```

> Unlike Voice API, the Applications API uses [header-based API Key and Secret Authentication] (https://developer.nexmo.com/concepts/guides/authentication#header-based-api-key-and-secret-authentication), which means you should use a [Base64](https://tools.ietf.org/html/rfc4648#section-4) encoded API key and secret joined by a colon in the `Authorization` header of the HTTP request.

### Update Application

Update your application with a [Update an application](https://developer.nexmo.com/api/application.v2#updateApplication) HTTP request:

```http
PUT https://api.nexmo.com/v2/applications/YOUR_APPLICATION_ID
```

Use the response JSON from the previous step as the request body with the addition of the `signed_callbacks` parameter:

```json
{
    "id": "YOUR_APPLICATION_ID",
    "name": "My app",
    "keys": {
        "public_key": "YOUR_PUBLIC_KEY"
    },
    "capabilities": {
        "voice": {
            "webhooks": {
                "event_url": {
                    "address": "https://example.com",
                    "http_method": "POST"
                },
                "fallback_answer_url": {
                    "address": "",
                    "http_method": "GET"
                },
                "answer_url": {
                    "address": "https://example.com",
                    "http_method": "GET"
                }
            },
            "signed_callbacks": true
        }
    },
    "_links": {
        "self": {
            "href": "/v2/applications/YOUR_APPLICATION_ID"
        }
    }
}
```

You can make a `GET` request from step one again to ensure the parameter is applied (it should be returned in the response).

> Beta limitation: if you change any parameter of your application via [Dashboard](https://dashboard.nexmo.com), the `signed_callbacks` parameter will be dropped, and the feature will be inactivated, so you have to go through the activation steps again to turn it back on.

## Validating Signed Webhooks

See [Signed webhooks](https://developer.nexmo.com/messages/concepts/signed-webhooks#validating-signed-webhooks) in the Messages API Concepts section. Voice signed callbacks have the same [JWT](https://jwt.io/) in the `Authorization` header, which your application is supposed to validate.