---
title: Get audit event types
navigation_weight: 4
---

# Get audit event types

In this Code Snippet you see how to get a list of all supported event types.

## Example

You will need to ensure that the following replaceable values are set in the example code using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | Your Nexmo API key.
`NEXMO_API_SECRET` | Your Nexmo API secret.

> In the following example the _Create an application_ and _Initialize your dependencies_ procedures are optional.

```code_snippets
source: '_examples/audit/get-event-types'
application:
  name: 'Get Event Types'
```

## Try it out

Run the command in a shell. The call will retrieve a list of supported audit event types, similar to the following:

```
{
  "eventTypes": [
    {
      "type": "USER_STATUS",
      "description": "User status updated"
    },
    {
      "type": "USER_UPDATE",
      "description": "User updated"
    },
    {
      "type": "USER_BILLING_UPDATE",
      "description": "User billing updated"
    },
    {
      "type": "USER_CREATE",
      "description": "User created"
    },
    {
      "type": "USER_LOGIN",
      "description": "User login into Customer dashboard"
    },
    {
      "type": "USER_LOGOUT",
      "description": "User logout from Customer dashboard"
    },
    {
      "type": "USER_PRODUCT_SEARCH",
      "description": "User product search"
    },
    {
      "type": "USER_API_KEYS_UPDATE",
      "description": "Sub-accounts for user updated"
    },
    {
      "type": "ACCOUNT_SECRET_DELETE",
      "description": "Account secret deleted"
    },
    {
      "type": "ACCOUNT_SECRET_CREATE",
      "description": "Account secret created"
    },
    {
      "type": "ACCOUNT_UPDATE_SETTINGS_API",
      "description": "Account Settings updated via API"
    },
    {
      "type": "NUMBER_ASSIGN",
      "description": "Number assigned"
    },
    {
      "type": "NUMBER_UPDATED",
      "description": "Number updated"
    },
    {
      "type": "NUMBER_USER_CANCELED",
      "description": "Number canceled by user"
    },
    {
      "type": "NUMBER_LINKED",
      "description": "Number linked to application"
    },
    {
      "type": "NUMBER_UNLINKED",
      "description": "Number unlinked from application"
    },
    {
      "type": "APP_CREATE",
      "description": "Application created"
    },
    {
      "type": "APP_UPDATE",
      "description": "Application updated"
    },
    {
      "type": "APP_DELETE",
      "description": "Application deleted"
    },
    {
      "type": "APP_DISABLE",
      "description": "Application disabled"
    },
    {
      "type": "APP_ENABLE",
      "description": "Application enabled"
    },
    {
      "type": "IP_WHITELIST_CREATE",
      "description": "Whitelist IP added"
    },
    {
      "type": "IP_WHITELIST_DELETE",
      "description": "Whitelist IP deleted"
    },
    {
      "type": "AUTORELOAD_ENABLE",
      "description": "Autoreload enabled"
    },
    {
      "type": "AUTORELOAD_UPDATE",
      "description": "Autoreload settings updated"
    },
    {
      "type": "AUTORELOAD_DISABLE",
      "description": "Autoreload disabled"
    }
  ]
}
```