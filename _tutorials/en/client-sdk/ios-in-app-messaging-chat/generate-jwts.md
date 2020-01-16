---
title: Generate JWTs
description: In this step you learn how to generate valid JWTs for each User in your Conversation
---

# Generate JWTs

You need to generate a JWT for each user. The JWT is used to authenticate the user.

In the following code remember to replace the `MY_APP_ID` variable with your own value:

``` shell
nexmo jwt:generate sub=Jane exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID

nexmo jwt:generate sub=Joe exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
```

The above commands set the expiry of the JWT to one day from now, which is the maximum.

Make a note of the JWT you generated for each user.

> **NOTE**: In a production environment, your application should expose an endpoint that generates a JWT for each client request.

## Further information

* [JWT guide](/concepts/guides/authentication#json-web-tokens-jwt)