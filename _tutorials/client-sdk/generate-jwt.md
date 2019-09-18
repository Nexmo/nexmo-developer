---
title: Generate a JWT
description: In this step you learn how to generate a valid JWT for your Client SDK Application.
---

# Generate a JWT

A JWT containing username has to be generated in order to be able to authenticate the user.

In the following code remember to replace the `MY_APP_ID` and `MY_USER_NAME` variables with your own values:

``` shell
nexmo jwt:generate ./private.key sub=MY_USER_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
```

This command sets the expiry of the JWT to the maximum of 24 hours.

> **NOTE**: In production apps, it is expected that your backend will expose an endpoint that generates a JWT for each client request.

## Further information

* [JWT guide](/concepts/guides/authentication#json-web-tokens-jwt)
