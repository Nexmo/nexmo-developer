---
title: Generate JWTs
description: In this step you learn how to generate valid JWTs for each User in your Conversation
---

# Generate JWTs

JWTs are used to authenticate users. Execute the following commands in the terminal to generate JWTs for the users `Alice` and `Bob`.

## Generate a JWT for Alice
In the following command replace the `APPLICATION_ID` with the ID of your application:

``` shell
nexmo jwt:generate sub=Alice exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

Make a note of the JWT you generated for Alice.

```screenshot
image: public/screenshots/tutorials/client-sdk/generated-jwt-key.png
```

## Generate a JWT for Bob

In the following command replace the `APPLICATION_ID` with the ID of your application:

``` shell
nexmo jwt:generate sub=Bob exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

Make a note of the JWT you generated for Bob.

> **NOTE** The `nexmo jwt:generate` commands shown above set the expiry of the JWT to one day from now, which is the maximum.

> **NOTE**: In a production environment, your application should expose an endpoint that generates a JWT for each client request.

## Further information

* [Find out more about JWTs](/concepts/guides/authentication#jwts)
