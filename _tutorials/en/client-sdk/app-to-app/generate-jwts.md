---
title: Generate JWTs
description: In this step you learn how to generate valid JWTs for each User in your In-App Voice Call.
---

# Generate JWTs

You need to generate a JWT for each user. The JWT is used to authenticate the user. Run the following commands, remember to replace the `APPLICATION_ID` variable with id of your application.

``` shell
nexmo jwt:generate ./private.key exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' sub=Alice application_id=APPLICATION_ID

nexmo jwt:generate ./private.key exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' sub=Bob application_id=APPLICATION_ID
```

The above commands set the expiry of the JWT to one day from now, which is the maximum.

Make a note of the JWT you generated for each user.

> **NOTE**: In a production environment, your application should expose an endpoint that generates a JWT for each client request.

## Further information

* [JWT guide](/concepts/guides/authentication#json-web-tokens-jwt)
