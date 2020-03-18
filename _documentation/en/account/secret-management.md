---
title: Secret Management
description: Rotate your Nexmo API keys
---

# Secret Management

Nexmo's Account API allows you to manage your API secret(s) programmatically.

Each Nexmo account can have up to two API secrets at any time. This allows you to create a second API secret, test your application and deploy the new configuration to production without interrupting your customer's service. Once that's done, you can revoke the existing API secret until you need to rotate your credentials again.

```sequence_diagram
Note left of SecretA: API secret in use
SecretA->SecretB: Create new secret
Note right of SecretB: Update all apps\nto use new secret
SecretB->SecretA: Delete old secret
Note right of SecretB: API secret in use

```

You can manage your API secrets via the [account API](/api/account) or the `settings` section in the [Nexmo Dashboard](https://dashboard.nexmo.com/settings).

## Subaccount Secret Management

In addition to managing your own API secrets, primary accounts can manage API secrets for any subaccount that it owns. To do this, authenticate with the Nexmo API using your primary account's API key and secret and specify the subaccount's API key as the `account_id` to manage in your [API call](/api/account/secret-management).
