---
title: Alerts - Sending API Reference
description: Reference guide for Event Based Alerts.
api: Alerts API - Sending
---

# Alerts - Sending API Reference

This defines Event Based Alerts API:

* [Request](#request) - send an Event Based Alert to you user.  If you have multiple templates, remember to set the *template* number in your request.
* [Response](#response) - Check the `status` field to ensure that you sent the request to Nexmo correctly.
* [Delivery receipt](#delivery-receipt) - verify that the Event Based Alert was delivered.

## Request

Before calling this API, you need to configure your message in Nexmo [Dashboard](https://dashboard.nexmo.com). A message template normally contains custom parameters that you supply in your request.

A basic Short Code Event Based Alert *request* looks like:

```
https://rest.nexmo.com/sc/us/alert/json?api_key=xxxxxxxx&api_secret=xxxxxxxx&to=xxxxxxxxxxxx
```

If you have a template in the form:

```
Your ${server} is down, for more details check ${link}
```

Your request will be:

```
https://rest.nexmo.com/sc/us/alert/json?api_key=xxxxxxxx&api_secret=xxxxxxxx&to=xxxxxxxxxxxx&server=host3&link=https://example.com/host3/mon
```

This request contains:

* A [Base URL](#base-url)
* [Parameters](#parameters)
* Authentication information
* [Security](#security)
* [Encoding](#encoding)

### Base URL

All requests to the Short Code Event Based Alert API must contain:

* `https://rest.nexmo.com/sc/us/alert`
* A response object: *json* or *xml*

Your base URL becomes either:

JSON | `XML`
-- | --
`https://rest.nexmo.com/sc/us/alert/json` | `https://rest.nexmo.com/sc/us/alert/xml`


### Parameters

The following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`to`  | The single phone number to send *pin* to.  Mobile number in **US format** and one recipient per request. For example, to=16365553226. | ✅
`status-report-req` | Set to `1` to receive a [delivery receipt](#delivery-receipt). To receive the delivery receipt, you have to configure a webhook endpoint in Dashboard. | ❎
`client-ref` | A 40 character reference string for your internal reporting. | ❎
`template` | If you have multiple templates, this is the index of the template to call. The default template starts is 0, each Event Based Alert campaign can have up to 6 templates. §§ If you have one template only it is the default. That is, *template=0*. If you create a request with *template=1* the API call will default, *template=0*  instead. After you add a valid campaign alert for 2FA, the request will call template 1 instead of template 0. | ❎
`type` | Default value is *text*. Possible values are: `text` for plain text SMS or `unicode` only use this when your SMS must contain special characters.| ❎
`custom` | Any custom parameters you need for *template*. | ❎

## Security

To ensure privacy, you must use HTTPS for all Nexmo API requests.

## Encoding

You submit all requests with a POST or GET call using UTF-8 encoding and URL encoded values. The expected Content-Type for POST is application/x-www-form-urlencoded. For calls to a JSON endpoint, we also support:

- `application/json`
- `application/jsonrequest`
- `application/x-javascript`
- `text/json`
- `text/javascript`
- `text/x-javascript`
- `text/x-json` when posting parameters as a JSON object.

## Response

Each request you make using the SMS API returns a:

* Response - the status and price of your request to Nexmo in JSON or XML format.
* Delivery receipt - the status and cost of the SMS sent by Nexmo to your user.

> Note: you are only charged for correctly submitted outbound SMS. If status is not 0, you are not charged.

The response is send in the api.txt file when you make a request from the browser.

Each response comes:

* In a specific Format
* With Keys and values

### Format

You set the response type using the Base URL. The following table shows example responses in JSON or XML:

```tabbed_examples
source: '_examples/api/us-short-codes/alerts/response-format'
```

### Keys and Values

The response contains the following keys and values.

```tabbed_content
source: '/_examples/api/sms/sending/keys-and-values/'
````

## Delivery Receipt

Each request you make using the Nexmo API returns a:

* Response - the status and cost of your request to Nexmo in JSON or XML format.
* Delivery Receipt - if you have set a webhook endpoint, Nexmo forwards this delivery receipt to it. Carriers return a Delivery Receipt (DLR) to Nexmo to explain the delivery status of your message. If the message is not received, the delivery receipt explains why your message failed to arrive.

The Delivery Receipt is sent using a [GET] HTTP request to your webhook endpoint. When you receive the DLR, you must send a 200 OK response. If you do not send the `200 OK`, Nexmo resends the delivery receipt for the next 72 hours. Please ensure that you have configured [a webhook endpoint](https://dashboard.nexmo.com/settings) in the Nexmo dashboard.

When you implement your response, ensure that your logic is not case-sensitive for the response codes.

A Delivery Receipt has a:

* Format
* Keys and Values

### Format

The following code shows an example of a Delivery Receipt:

```tabbed_content
source: '_examples/api/us-short-codes/alerts/delivery-receipt-format'
```

### Keys and Values

The Nexmo Delivery Receipt includes:

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
