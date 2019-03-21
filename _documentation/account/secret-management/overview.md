---
title: Overview
meta_title: Rotate your Nexmo API keys
---

# Secret Management Overview

Nexmo's Secret Management API allows you to manage your API secret(s) programmatically.

Each Nexmo account can have up to two API secrets at any time. This allows you to create a second API secret, test your application and deploy the new configuration to production without interrupting your customer's service. Once that's done, you can revoke the existing API secret until you need to rotate your credentials again.

You can manage your API secrets via the [secret rotation API](/api/account/secret-management) or the `settings` section in the [Nexmo Dashboard](https://dashboard.nexmo.com/settings).

## Secondary Account Secret Management

In addition to managing your own API secrets, primary accounts can manage API secrets for any secondary account that it owns. To do this, authenticate with the Nexmo API using your primary account's API key and secret and specify the secondary account's API key as the `account_id` to manage in your [API call](/api/account/secret-management).

## Code Snippets

Code snippets are examples showing how to use the API to perform various tasks.

```code_snippet_list
product: account/secret-management
```

