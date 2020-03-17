---
title: Create a secret
navigation_weight: 1
---

# Create a secret

To create a new API secret, you must send a `POST` request to the secret management API.

New API secrets must meet the following rules:

* Minimum 8 characters
* Maximum 25 characters
* Minimum 1 lower case character
* Minimum 1 upper case character
* Minimum 1 digit

Key | Description
 -- | --
`NEXMO_API_KEY` | The API key of the account.
`NEW_SECRET` | The new API secret for the API key.

```code_snippets
source: _examples/account/secret-management/create-a-secret
```
