---
title: Generate JWTs
description: In this step you learn how to generate valid JWTs for each User in your Conversation
---

# Generate JWTs

The JWT is used to authenticate the user. Execute the following commands in the terminal to generate a JWT for the users `Alice` and `Bob`.

## Generate Alice JWT
In the following command replace the `APPLICATION_ID` with id of your application:

``` shell
nexmo jwt:generate sub=Alice exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

Make a note of the JWT you generated for Alice.

```screenshot
image: public/screenshots/tutorials/client-sdk/generated-jwt-key.png
```

## Generate Bob JWT

In the following command replace the `APPLICATION_ID` with id of your application:

``` shell
nexmo jwt:generate sub=Bob exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

Make a note of the JWT you generated for Bob.

> **NOTE** The above commands set the expiry of the JWT to one day from now, which is the maximum.

> **NOTE**: In a production environment, your application should expose an endpoint that generates a JWT for each client request.

> **NOTE** Check [JWT guide](/concepts/guides/authentication#json-web-tokens-jwt)
