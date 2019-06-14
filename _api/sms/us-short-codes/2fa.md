---
title: 2FA API Reference
description: Reference guide for Two-factor Authentication API.
api: 2FA
---

# Two-factor Authentication API Reference

This describes the US Short Code Two-factor Authentication API in the following steps:

* [Request](#request) - send a PIN to your user
* [Response](#response) - check the [response](#keys-and-values) and ensure that you sent the request to Nexmo correctly.
* [Delivery receipt](#delivery-receipt) - see the status and cost of your request.

## Request

A 2FA *request* looks like:

```tabbed_content
source: '_examples/api/us-short-codes/2fa/request/base-url'
```

This request contains:

* [A Base URL](#base-url)
* [Parameters](#parameters)
* [Authentication information](#authentication-information)
* [Security](#security)
* [Encoding](#encoding)

### Base URL

All requests to the Short Code 2FA API must contain:

* `https://rest.nexmo.com/sc/us/2fa`
* A response object: *json* or *xml*

Your base URL becomes either:

JSON | XML
-- | --
`https://rest.nexmo.com/sc/us/2fa/json`| `https://rest.nexmo.com/sc/us/2fa/xml`


### Parameters

The following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`to`  | The single phone number to send *pin* to. This is a mobile number in <strong>US format</strong> with one recipient per request. For example, `to=16365553226` | Yes
`pin` | A numeric password to authenticate your user. | Yes
`client-ref` | A 40 character reference string for your internal reporting. | No

### Authentication information

To authenticate your request, you must provide the following parameters:

Parameter | Description
-- | --
`api_key` | Your Key. For example: `api_key=NEXMO_API_KEY`
`api_secret` | Your Secret. For example: `api_secret=NEXMO_API_SECRET`

You can find your Key and Secret in the [Dashboard](https://dashboard.nexmo.com/).

If you are using signatures to verify your requests use:

Parameter | Description
-- | --
`api_key` | Your Key. For example: api_key=NEXMO_API_KEY
`sig` | The hash of the request parameters in alphabetical order, a timestamp and the signature secret. For example: sig=SIGNATURE

### Security

To ensure privacy, you must use HTTPS for all Nexmo API requests.

### Encoding

You submit all requests with a [POST] or [GET] call using UTF-8 encoding and URL encoded values. The expected Content-Type for [POST] is `application/x-www-form-urlencoded`. For calls to a JSON endpoint, we also support:

* `application/json`
* `application/jsonrequest`
* `application/x-javascript`
* `text/json`
* `text/javascript`
* `text/x-javascript`
* `text/x-json` when posting parameters as a JSON object.

## Response

Each [request](#request) you make using the US Short Codes API returns a:

* [Response](#keys-and-values) - the status and cost of your request to Nexmo in [JSON or XML](#base-url) format.
* [Delivery receipt](#delivery-receipt) - the status and cost of the SMS sent by Nexmo to your user.

> *Note*: you are only charged for correctly submitted outbound SMS. If status is not *0*, you are not charged.

The response is send in the *api.txt* file when you make a request from the browser.

Each response comes:

* In a specific [Format](#format)
* With [Keys and values](#keys-and-values)


### Format

You set the response type using the [Base URL](#base-url). The following table shows example responses in JSON or XML:

```tabbed_examples
source: '_examples/api/us-short-codes/alerts/response-format'
```

### Keys and Values

The response contains the following keys and values:

### Payload

Key |	Description |	Response type
-- | -- | --
`message-count` | The number of parts the message was split into. | JSON
`messages` | Contains each message part. For an XML response, the `count` attribute contains the value of `message-count` JSON key. | BOTH
`message` | A single message part. | XML
`status` | Shows how the SMS send is processing. | BOTH
`message-id` | The ID of the SMS that was submitted (8 to 16 characters). | JSON
`messageId` | The ID of the SMS that was submitted (8 to 16 characters). | XML
`to` | The phone number your request was sent to. | BOTH
`client-ref` | The client-ref you set in your request. | JSON
`clientRef` | The client-ref you set in your request. | XML
`remaining-balance` | The remaining balance in your account. The value is in EUR. | JSON
`remainingBalance` | The remaining balance in your account. The value is in EUR. | XML
`message-price` | The price charged for your request. The value is in EUR. | JSON
`messagePrice` | The price charged for your request. The value is in EUR. | XML
`network` | The Mobile Country Code Mobile Network Code (MCCMNC) for the carrier that to is registered with. | BOTH
`error-text` | If an error occurred, this explains what happened. | JSON
`errorText` | If an error occurred, this explains what happened. | XML

## Delivery receipt

Each [request](#request) you make using the Short Codes API returns a:

* [response](#keys-and-values) - the status and cost of your request to Nexmo in [JSON or XML](#base-url) format.
* Delivery receipt - if you have set a [webhook endpoint](/concepts/guides/webhooks), Nexmo forwards this delivery receipt to it. Carriers return a delivery receipt (DLR) to Nexmo to explain the delivery status of your message. If the message is not received, the delivery receipt explains why your message failed to arrive.

The delivery receipt is sent using a [GET] HTTP request to your [webhook endpoint](/concepts/guides/webhooks). When you receive the DLR, you must send a `200 OK` response. If you do not send the `200 OK`, Nexmo resends the delivery receipt for the next 72 hours.

A delivery receipt has a:

* [Format](#format)
* [Keys and Values](#keys-and-values)

### Format

The following code shows an example of a delivery receipt:

```
?msisdn=66837000111&to=12150000025
&network-code=52099&messageId=000000FFFB0356D2
&price=0.02000000&status=delivered
&scts=1208121359&err-code=0&message-timestamp=\2020-01-01\+12%3A00%3A00
```

### Keys and Values

The Nexmo delivery receipt includes:

Key | Value
-- | --
`to` | The SenderID you set in from in your request.
`network-code` | The Mobile Country Code Mobile Network Code (MCCMNC) of the carrier this phone number is registered with.
`messageId` | The Nexmo ID for this message.
`msisdn` | The phone number this message was sent to.
`status` | A code that explains where the message is in the delivery process., If status is not delivered check err-code for more information. If status is accepted ignore the value of err-code. @[Possible values](_examples/api/us-short-codes/alerts/delivery-receipt/status.md)
`err-code` | If the status is not accepted, this key will have one of the these @[possible values](_examples/api/us-short-codes/alerts/delivery-receipt/err-code.md)
`price` | How much it cost to send this message.
`scts` | The Coordinated Universal Time (UTC) when the DLR was received from the carrier. The scts is in the following format: YYMMDDHHMM. For example, 1101181426 is 2011 Jan 18th 14:26.
`message-timestamp` | The time at UTC±00:00 when Nexmo started to push this Delivery Receipt to your webhook endpoint. The message-timestamp is in the following format YYYY-MM-DD HH:MM:SS. For example, 2020-01-01 12:00:00.
`client-ref` | The client-ref you set in the request.
