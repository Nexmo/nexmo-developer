---
title: How to generate JWTs
description: This topic explains how to generate JWTs for use in your app. JSON Web Tokens (JWTs) and Access Control Lists (ACLs) are a key concept to understand in order to authenticate your apps and users.
navigation_weight: 11
---

# How to generate JWTs

## JWTs

### Overview

The Nexmo Client SDKs use [JWTs](https://jwt.io/) for authentication when a user logs in. These JWTs are generated using the application ID and private key that is provided [when a new application is created.](/tutorials/client-sdk-generate-test-credentials#create-a-nexmo-application)

### Claims

Using that `private.key` and the application ID, we can mint a new JWT. In order to log a user into a Nexmo client, the JWT will need the following claims:

|Claim | Description |
| --------- | ----------- |
| `sub`| The "subject". The subject, in this case, will be the name of the user created and associated with your Nexmo Application |
| `acl`| Access control list. The Nexmo Client SDK uses this as a permission system for users. Read more about it in the [ACL overview](#acls) |
| `application_id`| This is the ID of the Nexmo Application you created. |
| `iat`| "Issued at time" This is the time the JWT was issued, in unix epoch time. |
| `jti`| "JWT ID". This is a unique identifier for this JWT. |
| `exp`| "Expiration time" This is the time in the future that the JWT will expire, in unix epoch time.  |

> *The `exp` claim is optional.* If the claim is not provided, then the JWT will expire by default in 15 minutes. The max expiration time for a JWT is 24 hours. JWTs should be typically short living, as it is trivial to create a new JWT and some JWTs can have multiple far-reaching permissions.

### Sample JWT Payload

Once all the claims have been provided, the resulting claims should appear like so:

```json
{
  "iat": 1532093588,
  "jti": "705b6f50-8c21-11e8-9bcb-595326422d60",
  "sub": "jamie",
  "exp": "1532179987",
  "acl": {
    "paths": {
      "/v1/users/**": {},
      "/v1/conversations/**": {},
      "/v1/sessions/**": {},
      "/v1/devices/**": {},
      "/v1/image/**": {},
      "/v3/media/**": {},
      "/v1/applications/**": {},
      "/v1/push/**": {},
      "/v1/knocking/**": {}
    }
  },
  "application_id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
}
```

## ACLs

### Overview

In the previous section, you can see that the `acl` claim has `paths` object containing multiple endpoints. These endpoints correspond with certain permissions a user can have when utilizing Nexmo Client SDK features.

### Paths

|Endpoint | Description |
| --------- | ----------- |
| `/v1/sessions/**`| Log in as a User.|
| `/v1/users/**`| Create and manage Users.|
| `/v1/conversations/**`| Create and manage Conversations & send/receive messages.|
| `/v1/image/**`| Send and receive images.|
| `/v3/media/**`| Send and receive audio.|
| `/v1/knocking/**`| Start Calls.|
| `/v1/push/**`| Receive push notifications|
| `/v1/devices/**`| Send push notifications.|
| `/v1/applications/**`| Upload push notification certificate.|

It is not necessary to provide users with the permissions to access all of these paths. For instance, if a user was not going to upload or receive push notifications, you could create a JWT without including the `/v1/applications/**`or `/v1/push/**` paths.

## Nexmo Client Libraries

### CLI

Currently, you can use the beta version of the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli/tree/beta) to create a JWT [including the appropriate claims](https://github.com/Nexmo/nexmo-cli/tree/beta#jwt)

```sh
nexmo jwt:generate ./private.key sub=jamie exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=YOUR_APP_ID
> JWT: [...JWT String...]
```

### Node

The beta version of the [Nexmo Node](https://github.com/Nexmo/nexmo-node/tree/beta#jwt) library can also create a JWT [including the appropriate claims](https://github.com/Nexmo/nexmo-node/tree/beta#jwt)

```js
const aclPaths = {
  "paths": {
    "/v1/users/**": {},
    "/v1/conversations/**": {},
    "/v1/sessions/**": {},
    "/v1/devices/**": {},
    "/v1/image/**": {},
    "/v3/media/**": {},
    "/v1/applications/**": {},
    "/v1/push/**": {},
    "/v1/knocking/**": {}
  }
}

Nexmo.generateJwt(PRIVATE_KEY, {
            application_id: "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
            sub: "jamie",
            //expire in 24 hours
            exp: Math.round(new Date().getTime()/1000)+86400,
            acl: aclPaths
          })
```

### PHP

The current version of the [Nexmo PHP](https://github.com/Nexmo/nexmo-php) library can also create a JWT including the appropriate claims.

```php
Nexmo::generateJwt([
        'application_id': "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
        'exp' => time() + 86400,
        'sub' => "jamie",
        'acl' => ["paths" => ["/v1/sessions/**" => (object)[], "/v1/users/**" => (object)[], "/v1/conversations/**" => (object)[], "/v1/devices/**" => (object)[], "/v1/image/**" => (object)[], "/v3/media/**" => (object)[], "/v1/applications/**" => (object)[], "/v1/push/**" => (object)[], "/v1/knocking/**" => (object)[]]],
    ])
```

### Other languages

Creating a JWT with the appropriate claims for authenticating a Nexmo user is not currently provided in any of the other Nexmo Client Libraries. Instead, you are encourage you to use your JWT library of choice to create a new JWT with the [Sample JWT Payload](#sample-jwt-payload). [JWT.io](https://jwt.io/#libraries-io) has a selection of libraries for generating JWTs in multiple languages.
