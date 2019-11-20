---
title: Authentication
navigation_weight: 2
---

# Authentication

Nexmo API provides various means of Authentication depending on what product you are using.

API | API Key and Secret (Query String) | API Key and Secret (Header) | JSON Web Token (JWT)
-- | -- | -- | -- | --
[SMS](/api/sms) | ✅ | ❌ | ❌
[Voice](/api/voice) | ❌ | ❌ | ✅
[Verify](/api/verify) | ✅ | ❌ | ❌ 
[Number Insight](/api/number-insight) | ✅ | ❌ | ❌
[Conversion](/api/conversion) | ✅ | ❌ | ❌
[Developer](/api/developer) | ✅ | ❌ | ❌ 
[Messages](/api/messages-olympus) | ❌ | ✅ | ✅ 
[Dispatch](/api/dispatch) | ❌ | ✅ | ✅ 
[Audit](/api/audit) | ❌ | ✅ | ❌ 
[Redact](/api/redact) | ❌ | ✅ | ❌ 
[Conversation](/api/conversation) | ❌ | ❌ | ✅ 

## Contents

In this document you can learn about authentication via the following means:

  - [API Key and Secret](#api-key-and-secret)
    - [Request Body](#request-body)
    - [Query String](#query-string)
    - [Header-based API Key and Secret Authentication](#header-based-api-key-and-secret-authentication)
    - [Secret Rotation](#secret-rotation)
  - [JSON Web Tokens (JWT)](#json-web-tokens-jwt)
  - [References](#references)

## API Key and Secret

When you create a Nexmo account, an API key and secret will be created for you. These are located in your [account settings](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard. You should always keep these secure and **never share these details**: be careful when adding it to your codebase to make sure they are not shared with anyone who may use it maliciously. If you use [message signatures](/concepts/guides/signing-messages), these are generated using the `SIGNATURE_SECRET` rather than the `API_SECRET`; both values can be found in your [account settings](https://dashboard.nexmo.com/settings).

> Note: The secret should always be kept secure and never shared. Be careful when adding it to your codebase to make sure it is not shared with anyone who may use it maliciously. Read more about the [Best Security Practices for your Nexmo Account](https://help.nexmo.com/hc/en-us/articles/115014939548).

Nexmo APIs may require your API Key and Secret in a number of different ways.

### Request Body

For `POST` requests to the SMS API, your API key and secret should be sent as part of the body of the request in the JSON object.

### Query String

Your API key and secret should be included in the query parameters of requests you make to the Conversion, Number Insight or Developer API. The parameters are called `api_key` and `api_secret` respectively.

An example of authentication query parameters would be as follows:

```
?api_key=NEXMO_API_KEY&api_secret=NEXMO_API_SECRET
```

The request may also need other query parameters and these can be added in any order.

### Header-based API Key and Secret Authentication

A number of newer Nexmo APIs require authentication to be done using an API key and secret sent Base64 encoded in the `Authorization` header.

For these APIs, you send your API key and secret in the following way:

```
Authorization: Basic base64(API_KEY:API_SECRET)
```

If your API key were `aaa012` and your API secret were `abc123456789`, you would concatenate the key and secret with a `:` (colon) symbol and then encode them using Base64 encoding to produce a value like this:

```
Authorization: Basic YWFhMDEyOmFiYzEyMzQ1Njc4OQ==
```

A website for generating Base64 encoded strings can be found here:

* General: [Base64 Encode and Decode](https://www.base64encode.org/)

Details on how to encode Base64 strings in a variety of programming languages can be found at the following websites:

* C#/.NET: [How do I encode and decode a Base64 string?](https://stackoverflow.com/questions/11743160/how-do-i-encode-and-decode-a-base64-string) from StackOverflow
* Go: [Base64 Encoding](https://gobyexample.com/base64-encoding) from Go By Example
* Java: [Base64](https://docs.oracle.com/javase/8/docs/api/java/util/Base64.html)
* JavaScript: [Base64 encoding and decoding](https://developer.mozilla.org/en-US/docs/Web/API/WindowBase64/Base64_encoding_and_decoding) from MDN web docs
* PHP: [base64_encode](https://secure.php.net/manual/en/function.base64-encode.php)
* Python: [Base64](https://docs.python.org/2/library/base64.html)
* Ruby: [Base64](https://ruby-doc.org/stdlib-2.5.0/libdoc/base64/rdoc/Base64.html)
* Swift: [Base64 Encode and Decode in Swift](http://iosdevelopertips.com/swift-code/base64-encode-decode-swift.html) from iOS Developer Tips

### Secret Rotation
It is possible to have two API secrets to be used against one API key at the same time. This way you can create a second API secret and test it before revoking the existing API secret in your production network. The API secret rotation procedure consists of the following steps:

1. Create a second API secret in your [account settings](https://dashboard.nexmo.com/settings) or by using  the [secret rotation API](/api/account/secret-management).
2. Update one or more of your servers to use the newly created API secret for making calls to Nexmo APIs
3. Test that there are no connectivity issues and roll out the API secret update across the remaining servers
4. Delete the replaced API secret

## JSON Web Tokens (JWT)

JSON Web Tokens (JWT) are a compact, URL-safe means of representing claims to be transferred between two parties.

JWTs are used by the Voice API to authenticate your requests. The [Nexmo libraries](/tools) and CLI handle JWT generation using a unique Nexmo Voice Application ID and a Private Key.

Values for the Header are:

Name | Description | Required
-- | -- | --
`alg` | The encryption algorithm used to generate the JWT. `RS256` is supported. | ✅
`typ` | The token structure. Set to `JWT`. | ✅

The values for the payload claim are:

Name | Description | Required
-- | -- | --
`application_id` | The unique ID allocated to your application by Nexmo. | ✅
`iat` | The UNIX timestamp at UTC + 0 indicating the moment the JWT was requested. | ✅
`jti` | The unique ID of the JWT. | ✅
`nbf` | The UNIX timestamp at UTC + 0 indicating the moment the JWT became valid. | ❌
`exp` | The UNIX timestamp at UTC + 0 indicating the moment the JWT is no longer valid. A minimum value of 30 seconds from the time the JWT is generated. A maximum value of 24 hours from the time the JWT is generated. A default value of 15 minutes from the time the JWT is generated. | ❌

If you are not using a Nexmo library you should refer to [RFC 7519](https://tools.ietf.org/html/rfc7519) to implement JWT.

### Using the Nexmo CLI to generate JWTs

The Nexmo CLI provides a command for generating a JWT. The general syntax is:

``` shell
nexmo jwt:generate [options] <private_key> [claim=value...]
```

An example of generating a JWT for a Voice API application is as follows:

``` shell
nexmo jwt:generate path/to/private.key application_id=asdasdas-asdd-2344-2344-asdasdasd345
```

An example of generating a JWT for a Client SDK application is as follows:

``` shell
nexmo jwt:generate ./private.key sub=MY_USER_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
```

More examples of generating JWTs with ACLs can be found in the [Nexmo documentation](/conversation/guides/jwt-acl).

Further information on the Nexmo CLI can be found in its [repository on GitHub](https://github.com/Nexmo/nexmo-cli).

## References

* [Voice API Reference](/api/voice)
* [SMS API Reference](/api/sms)
