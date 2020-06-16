---
title: Signed webhooks
description: Verify the source of incoming requests via the Messages API.
navigation_weight: 4
---

# Signed webhooks

Signed webhooks are supported by both the Messages and Dispatch APIs and are enabled by default. They provide a method for your application to verify a request is coming from Vonage and its payload has not been tampered with during transit. When receiving a request, the incoming webhook will include a JWT token in the authorization header which is signed with your signature secret.

Validating signed webhooks provides a number of security benefits, including:

* Ability to verify a request originates from Vonage
* Ensures that the message has not been tampered with while in transit
* Defends against interception and later replay

## Validating signed webhooks

There are two parts to validating signed webhooks:

1. Verify the request
2. Verify the payload (optional)

### Verify the request

Webhooks for both inbound messages and message status will include a JWT in the authorization header. Use the API key included in the JWT claims to identify which of your signature secrets has been used to sign the request. The secret used to sign the request corresponds to the signature secret associated with the `api_key` included in the JWT claims. You can identify your signature secret on the [Dashboard](https://dashboard.nexmo.com/settings). It's recommended that signature secrets be no less than 32 bits to ensure their security.

> Note: The `signature method` drop down does not affect the method used for signing Messages API webhooks, SHA-256 is always used.

### Verify the payload has not been tampered with in transit

Once you have verified the authenticity of the request, you may optionally verify the request payload has not been tampered with by comparing a SHA-256 hash of the payload to the `payload_hash` field found in the JWT claims. If they do not match, then the payload has been tampered with during transit. You only need to verify the payload if you are using HTTP rather than HTTPS, as Transport Layer Security (TLS) prevents [MITM attacks](https://en.wikipedia.org/wiki/Man-in-the-middle_attack).

> **NOTE:** In the rare case of an internal error, it is possible that the callback service will send an unsigned callback. By returning an HTTP 5xx response, a retry will be triggered giving the system time to resolve the error and sign future callbacks.

The code example below shows how to verify a webhook signature. It is recommended you use HTTPS protocol as it ensures that the request and response are encrypted on both the client and server ends.

```code_snippets
source: '_examples/messages/signed-webhooks'
```

## Sample Signed JWT

```json
// header
{
  "alg": "HS256",
  "typ": "JWT",
}
// payload
{
  "iat": 1587494962,
  "jti": "c5ba8f24-1a14-4c10-bfdf-3fbe8ce511b5",
  "iss": "Vonage",
  "payload_hash" : "d6c0e74b5857df20e3b7e51b30c0c2a40ec73a77879b6f074ddc7a2317dd031b",
  "api_key": "a1b2c3d",
  "application_id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
}
```

### Signed JWT Header

The contents of the signed JWT header are described in the following table:

Header | Value
-- | --
`alg` | HS256
`typ` | JWT

### Signed JWT Payload

The contents of the signed JWT payload are described in the following table, using the values included in the sample signed JWT shown previously:

Field | Example Value | Description
--- | --- | ---
`iat` |  `1587494962` | The time at which the JWT was issued. Unix timestamp in SECONDS.
`jti` | `c5ba8f24-1a14-4c10-bfdf-3fbe8ce511b5` | A unique ID for the JWT.
`iss` | `Vonage` | The issuer of the JWT. This will always be 'Vonage'.
`payload_hash` | `d6c0e74b5857df20e3b7e51b30c0c2a40ec73a77879b6f074ddc7a2317dd031b` | A SHA-256 hash of the request payload. Can be compared to the request payload to ensure it has not been tampered with during transit.
`api_key` | `a1b2c3d` | The API key associated with the account that made the original request.
`application_id` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | (Optional) The id of the application that made the original request if an application was used.
