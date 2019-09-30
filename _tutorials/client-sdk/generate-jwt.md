---
title: Generate a JWT
description: In this step you learn how to generate a valid JWT for your Client SDK Application.
---

# Generate a JWT

Authentication in the Client SDK is controlled using JWTs, which contain the name of the user it identifies, the application ID it's valid for, and an access control list (ACL) to control that user's permissions. Then, it's signed using the `private.key` you saved earlier to prove that it's a valid token.

> **NOTE**: We'll be creating a one-time use JWT on this page for testing. In production apps, it is expected that your backend will expose an endpoint that generates a JWT for each client request.

Remember to replace the `MY_APP_ID` and `MY_USER_NAME` variables with your own values in the sections below. If you're testing with multiple users, generate multiple JWTs (changing the `sub` value each time).

## Using the CLI

You can generate a JWT using the Nexmo CLI by running the following command:

``` shell
nexmo jwt:generate ./private.key sub=MY_USER_NAME exp=$(($(date +%s)+21600)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
```

The generated JWT will be valid for the next 6 hours.

## Using the web interface

Alternatively, you can use our <a href="/jwt" target="_blank">online JWT generator</a> with the following parameters to generate a JWT.

**Application ID:** `MY_APP_ID`<br />
**Sub:** `MY_USER_NAME`<br />
**ACL:**

```json
{
  "paths": {
    "/*/users/**": {},
      "/*/conversations/**": {},
      "/*/sessions/**": {},
      "/*/devices/**": {},
      "/*/image/**": {},
      "/*/media/**": {},
      "/*/applications/**": {},
      "/*/push/**": {},
      "/*/knocking/**": {}
  }
}
```

## Further information

* [JWT guide](/concepts/guides/authentication#json-web-tokens-jwt)
