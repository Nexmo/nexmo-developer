---
language: curl
---

##### Generate a JWT

We'll use this `$JWT` variable in our cURL commands.

```sh
JWT="$(
  nexmo jwt:generate ./private.key \
  application_id=APPLICATION_ID
)"
```
