---
title: Generate a JWT
description: In this step you see how to generate a valid JWT for your Client SDK Application.
---

# Generate a User JWT

Generate a JWT for the user. Remember to replace the `MY_APP_ID` and `MY_USER_NAME` values in the command:

```bash
nexmo jwt:generate ./private.key sub=MY_USER_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
```

The above command sets the expiry of the JWT to one day from now, which is the maximum amount of time. You may change the expiration to a shortened amount of time, or regenerate a JWT for the user after the current JWT has expired.

> **NOTE**: In production apps, it is expected that your backend will expose an endpoint that generates JWT per your client request.
