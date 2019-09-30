---
title: Generate JWTs
description: In this step you learn how to generate valid JWTs for each User in your Conversation
---

# Generate JWTs

You need to generate a JWT for each user. The JWT is used to authenticate the user.

In the following code remember to replace the `MY_APP_ID`, `MY_USER1_NAME` and `MY_USER2_NAME` variables with your own values:

``` shell
nexmo jwt:generate ./private.key sub=MY_USER1_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID

nexmo jwt:generate ./private.key sub=MY_USER2_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
```

The above command sets the expiry of the JWT to one day from now, which is the maximum.

Make a note of the JWT you generated for each user.

> **NOTE**: In a production environment, your application should expose an endpoint that generates a JWT for each client request.

## Using the web interface

Alternatively, you can use our <a href="/jwt" target="_blank">online JWT generator</a> with the following parameters to generate a JWT.

**Application ID:** `MY_APP_ID`<br />
**Sub:** `MY_USER1_NAME` / `MY_USER2_NAME`<br />
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