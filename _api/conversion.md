---
title: Conversion API Reference
description: The structure and parameters for a Conversion API request.
api: Conversion API
---

# Conversion API Reference

This defines the Conversion API:

* [Request](#request) - tell Nexmo if your message or call was successful
* [Response](#response) - ensure that your request to the Conversion API was successful

For more details, see [Conversion API Overview](/messaging/conversion-api/overview).

## Request

A Conversion API *request* looks like:

```
https://api.nexmo.com/conversions/voice?api_key=xxxxxx&api_secret=xxxxxxx&message-id=xxxxxxxxxxxxxx&timestamp=xxxxxxxxx&delivered=true
```

This request contains:

* A [Base URL](#base)
* [Parameters](#parameters )
* [Authentication information](#authentic )
* [Security](#security )
* [Encoding](#encode)

## Base URL

Conversion API only accepts POST requests. The reply is not in JSON or XML format.
Your base URL becomes either:

**SMS API**

```
https://api.nexmo.com/conversions/sms
```

**Text-To-Speech APIs**

```
https://api.nexmo.com/conversions/voice
```


## Parameters

Your request must contains all the parameters in the following table, otherwise it returns with a 422 or 423 errors:

Parameter | Description | Required
-- | -- | --
`message-id` | The ID you receive in the response to a request. @[Possible Values](/_modals/api/conversion/parameters/message-id.md) | Yes
`delivered` | Set to *true* if your user replied to the message you sent. Otherwise, set to *false*. <br>**Note**: for curl, use 0 and 1.  | Yes
`timestamp` | When the user completed your call-to-action (e.g. visited your website, installed your app) in [UTC±00:00](https://en.wikipedia.org/wiki/UTC%C2%B100:00) format: *yyyy-MM-dd HH:mm:ss*. | Yes

#### Authentication information

If you are not using applications, you use the following parameters for calls to Nexmo API:

Parameter | Description
-- | --
api_key | Your Key. For example: `api_key=NEXMO_API_KEY`
api_secret | Your Secret. For example: `api_secret=NEXMO_API_SECRET`

> Note: You find your Key and Secret in Dashboard.

If you are using signatures to verify your requests use:

Parameter | Description
-- | --
`api_key` | Your Key. For example: `api_key=NEXMO_API_KEY`
`sig` | The hash of the request parameters in alphabetical order, a timestamp and the signature secret. For example: `sig=SIGNATURE`

#### Security

To ensure privacy, you must use HTTPS for all Nexmo API requests.

#### Encoding

You submit all requests with a [POST] or [GET] call using `UTF-8` encoding and URL encoded values. The expected Content-Type for [POST] is `application/x-www-form-urlencoded`. For calls to a JSON endpoint, we also support:

* `application/json`
* `application/jsonrequest`
* `application/x-javascript`
* `text/json`
* `text/javascript`
* `text/x-javascript`
* `text/x-json` when posting parameters as a JSON object.

If you are using `GET`, you must set [`Content-Length`](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Request_fields) in the request header.

## Response

The response to each *request* you make to the Conversion API returns the status of your request to Nexmo.

It contains following keys and values: <a name="response"></a>

Key |	Value
-- | --
`200` |	OK |
`401` |	Wrong credentials
`402` | Conversion has not been enabled for your account |
`420` or `423` |	Invalid parameters |
