---
title: Generate JWT
description: In this step you learn how to generate valid JWTs for each User in your Conversation
---

# Generate JWT

The JWT is used to authenticate the user. Execute the following command in the terminal to generate a JWT for the user `Alice`.

In the following command replace the `APPLICATION_ID` with id of your application:

``` shell
nexmo jwt:generate sub=Alice exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

The above command set the expiry of the JWT to one day from now, which is the maximum.

Make a note of the JWT you generated for the user.

```screenshot
image: public/screenshots/tutorials/client-sdk/generated-jwt-key.png
```

> **NOTE**: In a production environment, your application should expose an endpoint that generates a JWT for each client request.

## Further information

* [JWT guide](/concepts/guides/authentication#json-web-tokens-jwt)