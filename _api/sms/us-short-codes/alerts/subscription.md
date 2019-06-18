---
title: Alerts - Subscribing API Reference
description: Reference guide for the Campaign Subscription Management.
api: Alerts API - Subscribing
---

# Alerts - Subscribing API Reference

This defines the API for Campaign Subscription Management:

* [Request](#request) - request the list of phone numbers opted out from your campaign, or remove a phone number from the list
* [Response](#response) - the list of opted out phone numbers or confirmation that the number has been removed.


## Request

You use the *opt-in* API to:

* Retrieve the list of phone numbers who have opted out from your campaign:

    ```
    https://rest.nexmo.com/sc/us/alert/opt-in/query/json?api_key=xxxxxxxx&api_secret=xxxxxxxx
    ```

* Remove a phone number from your opt-out list:

    ```
    https://rest.nexmo.com/sc/us/alert/opt-in/manage/json?api_key=xxxxxxxx&api_secret=xxxxxxxx&msisdn=xxxxxxxxxxxx
    ```


This request contains:

* [Base URL](#base-url)
* [Parameters](#parameters)
* [Authentication information](#authentication-information)
* [Security](#security)
* [Encoding](#encoding)

### Base URL

All requests to the Short Code Event Based Alert API must contain:

* Either:
  * `https://rest.nexmo.com/sc/us/alert/opt-in/query`
  * `https://rest.nexmo.com/sc/us/alert/opt-in/manage`

* A response object: *json* or *xml*

Your base URL becomes either:

```tabbed_content
source: '_examples/api/us-short-codes/alerts/subscription/base-url'
```

### Parameters

The following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`msisdn` | The phone number to resubscribe to your campaign and remove from the opt-out list. | If Your base URL contains `https://rest.nexmo.com/sc/us/alert/opt-in/manage`.
`page-size` | Return this amount of results in the response. The default value is 100. | No
`page` | Return `page-size` results from this zero-based index in the response. If your request returns 300 Calls, set `page` to 2 in order to return Calls 201 to 300. The default value is 0. | No

## Authentication information

If you are not using applications, you use the following parameters for calls to Nexmo API:

Parameter | Description
-- | --
`api_key` | Your Key. For example: api_key=NEXMO_API_KEY
`api_secret` | Your Secret. For example: api_secret=NEXMO_API_SECRET

> Note: You find your Key and Secret in Dashboard.

If you are using signatures to verify your requests use:

Parameter |	Description
-- | --
`api_key` | Your Key. For example: api_key=NEXMO_API_KEY
`sig` | The hash of the request parameters in alphabetical order, a timestamp and the signature secret. For example: `sig=SIGNATURE`

### Security

To ensure privacy, you must use HTTPS for all Nexmo API requests.

### Encoding

Encoding

You submit all requests with a [POST] or [GET] call using UTF-8 encoding and URL encoded values. The expected `Content-Type` for [POST] is `application/x-www-form-urlencoded`. For calls to a JSON endpoint, we also support:

* `application/json`
* `application/jsonrequest`
* `application/x-javascript`
* `text/json`
* `text/javascript`
* `text/x-javascript`
* `text/x-json` when posting parameters as a JSON object.

## Response

Each [request](#request) you make using this API returns a:

* [Response](#keys-and-values) - the status of your request to Nexmo in [JSON or XML format](#format).

The response is returned either:

* Directly to you. For example, if you are using the command line, you see the response on the command line.
* To a [webhook endpoint](/concepts/guides/webhooks) if you set it in Dashboard.

Each response comes:

* In a specific [Format](#format)
* With [Keys and values](#keys-and-values)


### Format

You set the response type using the (link:#request text: Base URL). The following table shows example responses in JSON or XML:

```tabbed_examples
source: '_examples/api/us-short-codes/alerts/subscription/response-format/1'
```

```tabbed_examples
source: '_examples/api/us-short-codes/alerts/subscription/response-format/2'
```

### Keys and Values

The response contains the following keys and values:

 Key| Value | Response type
-- | -- | --
`opt-in-count` | The number of parts the message was split into. | `JSON`
`opt-in-list` | Contains each opt-in part. For an XML response, the *count* attribute contains the value of *opt-in-count* JSON key. | `BOTH`
`opt-in` |  A single opt-in part. | `XML`
`msisdn` | The phone number that was unsubscribed or resubscribed to your campaign. | `BOTH`
`opt-in` | `true` if `msisdn` is subscribed to your campaign.| `BOTH`
`opt-in-date` | The date `msisdn` was subscribed to your campaign. | `BOTH`
`opt-out` | `true` if `msisdn` is *NOT* subscribed to your campaign.| `BOTH`
`opt-out-date` | The date `msisdn` was removed from your campaign. | `BOTH`
