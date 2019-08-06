---
title: Create a Subaccount
navigation_weight: 1
---

# Create a Subaccount

In this code snippet you will see how to create a subaccount.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | The API key of the parent account.
`NEXMO_API_SECRET` | The API secret of the parent account.
`NEW_SUBACCOUNT_NAME` | The name of the new subaccount.
`NEW_SUBACCOUNT_SECRET` | The API secret of the new subaccount.

```code_snippets
source: '_examples/subaccounts/create-subaccount'
```

## Try it out

When you run the code you create a new subaccount of the parent account.

> **NOTE:** This code snippet will create a subaccount that has a credit and balance facility shared with the parent account. If you want to create a subaccount that does not have a credit and balance shared with the parent then you need to set `use_primary_account_balance` to `false` when you create the subaccount.
