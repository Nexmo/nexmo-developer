---
title: Revoke a secret
navigation_weight: 2
---

# Revoke a secret

To create a new API secret, you must send a `DELETE` request to the secret management API.

You must have at least one API secret at all times.

Key | Description
 -- | --
`NEXMO_API_KEY` | The API key of the account.
`NEXMO_SECRET_ID` | The ID of the secret to delete.

```code_snippets
source: _examples/account/secret-management/revoke-a-secret
```
