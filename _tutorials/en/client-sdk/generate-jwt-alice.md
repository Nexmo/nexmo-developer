---
title: Generate a JWT
description: In this step you learn how to generate a valid JWT for your Client SDK Application.
---

# Generate a JWT

The Client SDK uses [JWTs](/concepts/guides/authentication#json-web-tokens-jwt) for authentication. The JWT identifies the user name, the associated application ID and the permissions granted to the user. It is signed using your private key to prove that it is a valid token.

> **NOTE**: We'll be creating a one-time use JWT on this page for testing. In production apps, your server should expose an endpoint that generates a JWT for each client request.

## Using the CLI

You can generate a JWT using the Nexmo CLI by running the following command but remember to replace the `APP_ID` variable with your own value:

``` shell
nexmo jwt:generate ./private.key exp=$(($(date +%s)+21600)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' sub=Alice application_id=APP_ID
```

The generated JWT will be valid for the next 6 hours.

## Alternative: using the web interface

Alternatively, you can use our <a href="/jwt" target="_blank">online JWT generator</a> with the `Alice` as the **Sub** parameters, and your application id for **Application ID** to generate a JWT.

## Further information

* [JWT guide](/concepts/guides/authentication#json-web-tokens-jwt)
