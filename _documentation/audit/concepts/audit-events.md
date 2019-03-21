---
title: Audit Events
navigation_weight: 1
description: Audit events concepts, including types and structure of audit events.
---

# Audit Events

Audit Events are generated automatically by Nexmo as the user interacts with either the Nexmo API or the Nexmo Dashboard. Each Audit Event object has a type and associated metadata.

## Audit Event types

The following table lists currently supported Audit Event types:

| Audit Event Type | Description |
|----|----|
| ACCOUNT_UPDATE_SETTINGS | Account Settings updated |
| ACCOUNT_UPDATE_SETTINGS_API | Account Settings updated via API |
| ACCOUNT_SECRET_CREATE | Secret Rotation operation |
| ACCOUNT_SECRET_DELETE | Secret Rotation operation |
| APP_CREATE | App created |
| APP_DELETE | App deleted |
| APP_DISABLE | App disabled |
| APP_ENABLE | App enabled |
| APP_UPDATE | App updated |
| AUTORELOAD_DISABLE | Autoreload disabled |
| AUTORELOAD_ENABLE | Autoreload enabled |
| AUTORELOAD_UPDATE | Autoreload settings updated |
| NUMBER_ASSIGN | Number assigned |
| NUMBER_USER_CANCELED | Number was canceled by the user |
| NUMBER_UPDATED | Number updated |
| NUMBER_LINKED | Number linked to Nexmo application |
| NUMBER_UNLINKED | Number unlinked from Nexmo application |
| USER_API_KEYS_UPDATE | Sub-accounts for user updated |
| USER_BILLING_UPDATE | User billing updated |
| USER_CREATE | User created |
| USER_LOGIN | User login **(Premium Support only)** |
| USER_LOGOUT | User logout **(Premium Support only)** |
| USER_PRODUCT_SEARCH | Relates to searching for [CDRs](/concepts/guides/glossary#cdr) or logs in Dashboard |
| USER_STATUS | User status updated |
| USER_UPDATE | User updated |
| IP_WHITELIST_CREATE | Whitelist IP added |
| IP_WHITELIST_CREATE | Whitelist IP deleted |

> **NOTE:** The list of supported event types does change from time to time. For this reason the `OPTIONS` method is provided to return event types. You can see how to return the definitive list of event types from the [Get event types code snippet](/audit/code-snippets/get-event-types)

## Audit event objects

When you retrieve Audit Events objects via the API they will each have an `event_type` field, where the `event_type` will be an entry from the table above. In addition the Audit Event object contains other metadata depending on the type.

For example, for a `NUMBER_UPDATED` event type the event object would resemble the following:

``` json
    {
        "_links": {
          "self": {
            "href": "http://api.nexmo.com/beta/audit/events/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
          }
        },
        "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
        "event_type": "NUMBER_UPDATED",
        "event_type_description": "Number updated",
        "created_at": "2018-05-16T16:34:22",
        "user_email": "yourname@example.com",
        "user_id": 1234567,
        "account_id": "NEXMO_API_KEY",
        "source": "CD",
        "source_ip": "1.2.3.4",
        "source_description": "Customer dashboard",
        "source_country": "GB",
        "context": {
          "country": "GB",
          "msisdn": "447700900000",
          "http": "http://example.com:9000/webhooks/inbound-sms",
          "voice-type": "app",
          "voice-value": "NEXMO_APP_ID"
        }
      }
```
