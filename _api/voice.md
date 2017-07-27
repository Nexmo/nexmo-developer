---
title: API reference
description: Voice API reference
api: Voice API
---
<!-- 
Note for editors:

If you add/move/rename sections (etc.), be sure to update the sidebar:
app/views/layouts/partials/api/_voice.html.erb
-->

# API reference

## Calls

You use the following requests to create, terminate, record and retrieve information about your calls:

###  Create an outbound call

[POST] `https://api.nexmo.com/v1/calls`

This request contains:

* A [Base URL](#ccbase)
* [Payload](#ccparameters)
* [JWT](#jwt_minting)

Information about the call is sent to you in the:

* [Response](#ccresponse) - parameters sent synchronously when the call starts.
* [Webhook](#ccwebhook) - parameters sent asynchronously when the status changes


#### Base URL

All requests to create a call must contain:

* `https://api.nexmo.com/v1/calls`

#### Payload

The payload to create a new call looks like:

```tabbed_content
source: '/_examples/api/voice/calls/post-response'
```


The following table shows the parameters you use to create a call:

Parameter | Description | Required
-- | -- | --
`to` | The single or mixed collection of endpoint types you connected to. @[Possible values](/_modals/voice/guides/ncco-reference/endpoint.md).
`from` | The endpoint you are calling from. Possible value are the same as *to*. | Yes
`answer_url` | The webhook endpoint where you provide the Nexmo Call Control Object that governs this call. As soon as your user answers a call, Platform requests this NCCO from `answer_url`. Use `answer_method` to manage the HTTP method. | yes
`answer_method` | A [GET] request. | no
`event_url` | Platform sends event information asynchronously to this endpoint when status changes. For more information about the values sent, see callback. | no
`event_method` | 	The HTTP method used to send event information to `event_url`. The default value is [POST]. | no
`machine_detection` | Configure the behavior when Nexmo detects that a destination is an answerphone. @[Possible values](/_modals/voice/api/calls/machine_detection.md). | no
`length_timer` | Set the number of seconds that elapse before Nexmo hangs up after the call state changes to *in_progress*. The default value is 7200, two hours. This is also the maximum value. | No that elapse before Nexmo hangs up after the call state changes to *‘ringing’*. The default value is 60, the maximum value is 120. | No
`ringing_timer` | Set the number of seconds that elapse before Nexmo hangs up after the call state changes to ‘ringing’. The default value is 60, the maximum value is 120. | no

#### Response

The JSON response looks like:

```json
{
  "uuid": "19d4df7c-d0dd-40c5-8460-1e88bd5d0d6b",
  "conversation_uuid": "63f61863-4a51-4f6b-86e1-46edebio0391",
  "status": "started",
  "direction": "outbound"
}
```

The 201 response contains the following keys and values:

Key | Value
-- | --
`uuid` | The unique identifier for this call leg. The uuid is created when your call request is accepted by Nexmo. You use uuid in all requests for individual live calls. @[Possible values](/_modals/voice/api/calls/uuid.md).
`conversation_uuid` | The unique identifier for the conversation this call leg is part of.
`direction` | Possible values are `outbound` or `inbound`.
`status` | The status of the call. [Possible values](#status-values).

#### Webhook

Nexmo sends the following parameters asynchronously to [event_url](#event_url) when [*status* changes](/voice/guides/handle-call-status):

```tabbed_content
source: '/_examples/api/voice/calls/webhook'
```

> **Note**: all return parameters are only sent when *status* is *completed*.

Possible values are:

Key | Value
-- | --
`uuid` | The unique identifier for this call leg. The UUID is created when your call request is accepted by Nexmo. You use the UUID in all requests for individual live calls. @[Possible values](/_modals/voice/api/calls/uuid.md).
`conversation_uuid` | The unique identifier for the conversation this call leg is part of.
`to` | The single or mixed collection of endpoint types you connected to. @[Possible values](/_modals/voice/guides/ncco-reference/endpoint.md).
`from` | The endpoint you called from. Possible values are the same as `to`.
`direction` | Possible values are `outbound` or `inbound`.
`recording_url` | The URL to download a call or conversation recording from.
`start_time` | The time the call started in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`.
`network` | The [Mobile Country Code Mobile Network Code (MCCMNC)](https://en.wikipedia.org/wiki/Mobile_country_code) for the carrier network used to make this call.
`status` | The status of the call. [Possible values](#status-values).
`rate` | The price per minute for this call. This is only sent if `status` is `completed`.
`price` | The total price charged for this call. This is only sent if `status` is `completed`.
`duration` | The time elapsed for the call to take place in seconds. This is only sent if `status` is `completed`.
`end_time` | The time the call ended in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`. This is only sent if `status` is `completed`.

### Retrieve information about all your calls

[GET] `https://api.nexmo.com/v1/calls`

You use a [GET] request to retrieve the details about all your calls.

This request contains:

* A [Base URL](#crabase)
* [Parameters](#craparameters)
* [JWT](#jwt_minting)

You receive the call details in the [response](#craresponse).

#### Base URL

All requests to retrieve details about all your calls must contain:

* `https://api.nexmo.com/v1/calls`

#### Parameters

The following table shows the parameters you use to filter the information you retrieve about your calls:

Parameter | Description | Required
-- | -- | --
`status` | Filter on the status of this call. [Possible values](#status-values) | No
`date_start` | Return the records that occurred after this point in time. Set this parameter in ISO_8601 format: `YYYY-MM-DDTHH:MM:SSZ`. For example, `2016-11-14T07:45:14Z`. | No
`date_end` | Return the records that occurred before this point in time. Set this parameter in ISO_8601 format. | No
`page_size` | Return this amount of records in the response. The default value is 10. | No
`record_index` | Return `page_size` calls from this index in the response. That is, if your request returns `300` calls, set `record_index` to 5 in order to return calls `50` to `59`. The default value is `0`. That is, the first `page_size` calls. | No
`order` | Either `asc` for ascending order (default) or `desc` for descending order. | No
`conversation_uuid` | Return all the records associated with a specific conversation. | No


#### Response

The JSON response looks like:

```json
{
  "count": 100,
  "page_size": 10,
  "record_index": 20,
  "_links": {
    "self": {
      "href": "/calls?page_size=10&record_index=20&order=asc"
    }
  },
  "_embedded": {
    "calls": [
      {
        "_links": {
          "self": {
            "href": "/calls/63f61863-4a51-4f6b-86e1-46edebcf9356"
          }
        },
        "uuid": "63f61863-4a51-4f6b-86e1-46edebcf9356",
        "conversation_uuid": "63f61863-4a51-4f6b-86e1-46edebio0123",
        "to": [{
          "type": "phone",
          "number": "447700900000"
        }],
        "from": {
          "type": "phone",
          "number": "447700900001"
        },
        "status": "completed",
        "direction": "outbound",
        "rate": "0.39",
        "price": "23.40",
        "duration": "60",
        "start_time": "2015-02-04T22:45:00Z",
        "end_time": "2015-02-04T23:45:00Z",
        "network": "65512"
      },
      ...
    ]
  }
}
```

The 200 response contains the following keys and values:

Key | Value
-- | --
`count` | The total number of records returned by your request.
`page_size` | The amount of records returned in this response.
`record_index` | Return `page_size` calls from this index in the response. That is, if your request returns `300` calls, set `record_index` to 5 in order to return calls `50` to `59`. The default value is `0`. That is, the first `page_size` calls.
`_links` | A series of links between resources in this API in the http://stateless.co/hal_specification.html. @[Possible links](/_modals/voice/api/calls/links.md).
`_embedded` | The collections of JSON objects returned in this response.
`calls` | The collection of `page_size` calls returned by your request. Each call in this response has the parameters listed below.
`uuid` | uuid	A unique identifier for this call.
`conversation_uuid` | The unique identifier for the conversation this call leg is part of.
`to` | The single or mixed collection of endpoint types you connected to. @[Possible values](/_modals/voice/guides/ncco-reference/endpoint.md).
`from` | The endpoint you are calling from. Possible value are the same as *to*.
`status` | Filter on the status of this call. [Possible values](#status-values).
`direction` | Possible values are `outbound` or `inbound`.
`rate` | The price per minute for this call.
`price` | The total price charged for this call.
`duration` | The time elapsed for the call to take place in seconds.
`start_time` | The time the call started in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`.
`end_time` | The time the call ended in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`.
`network` | The [Mobile Country Code Mobile Network Code (MCCMNC)](https://en.wikipedia.org/wiki/Mobile_country_code) for the carrier network used to make this call.

### Retrieve information about a single call

[GET] `https://api.nexmo.com/v1/calls/{uuid}`

You use a GET request to retrieve information about a single call.

This request contains:

* A [Base URL](#crsbase)
* (link: #crsparameterstext: Payload)
* [JWT](#jwt_minting)

You receive the call details in the [response](#crsresponse).

#### Base URL

All requests to retrieve information about a single call must contain:

* `https://api.nexmo.com/v1/calls/{uuid}`

#### Payload

There are no parameters for this request.

#### Response

The JSON responses looks like:

```tabbed_content
source: '/_examples/api/voice/calls/show-response'
```

The 200 response contains the following keys and values:

Key | Value
-- | --
`_links` | A series of links between resources in this API in the http://stateless.co/hal_specification.html. @[Possible links](/_modals/voice/api/calls/links.md).
`uuid` | uuid	A unique identifier for this call.
`conversation_uuid` | The unique identifier for the conversation this call leg is part of.
`to` | The single or mixed collection of endpoint types you connected to. @[Possible values](/_modals/voice/guides/ncco-reference/endpoint.md).
`from` | The endpoint you are calling from. Possible value are the same as *to*.
`status` | Filter on the status of this call. [Possible values](#status-values)
`direction` | Possible values are `outbound` or `inbound`.
`rate` | The price per minute for this call.
`price` | The total price charged for this call.
`duration` | The time elapsed for the call to take place in seconds.
`start_time` | The time the call started in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`.
`end_time` | The time the call ended in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`.
`network` | The [Mobile Country Code Mobile Network Code (MCCMNC)](https://en.wikipedia.org/wiki/Mobile_country_code) for the carrier network used to

### Modify an existing call

[PUT] `https://api.nexmo.com/v1/calls/{uuid}`

You can use a [PUT] request to modify an existing call. You can use this to terminate a call, mute or unmute a call, "earmuff" a call (which suspends audio to one call) or "unearmuff" it, and to transfer the call to a different NCCO.

These requests must be authenticated using a [JSON Web Token (JWT)](#jwt_minting).

#### Base URL

All requests to modify an existing call must contain:

* `https://api.nexmo.com/v1/calls/{uuid}`

#### Payload 

The request body is a JSON-encoded object. The request body's content depends on the `action` performed.

The following table shows the parameters you use to modify a call:

Parameter | Description | Required
-- | -- | --
`action` | Possible values are described below. | Yes
`destination` | A JSON object pointing to a replacement NCCO, when `action` is `transfer`. | No

Possible values for `action` are:

Action value | Description
-------------| -----------
`hangup`     | Terminates this call leg.
`mute`       | Mutes this call leg.
`unmute`     | Unmutes this call leg.
`earmuff`    | Prevents the recipient of this call leg from hearing other parts of the conversation.
`unearmuff`  | Removes the earmuff effect from this call leg.
`transfer`   | Transfers this call leg to another NCCO, as specified by the `destination` parameter.

For every action parameter except `transfer`, no further keys are required in the JSON document. For `transfer`, a `destination` key containing a JSON object must be provided. Examples for these are given below.

```tabbed_content
source: '_examples/api/voice/calls/put-request'
```


#### Response

The JSON response contains current details of the call. An example is provided below.

```json
{
  "_links": {
    "self": {
      "href": "/calls/63f61863-4a51-4f6b-86e1-46edebcf9356"
    }
  },
  "uuid": "63f61863-4a51-4f6b-86e1-46edebcf9356",
  "conversation_uuid": "63f61863-4a51-4f6b-86e1-46edebio0123",
  "to": [{
    "type": "phone",
    "number": "447700900000"
  }],
  "from": {
    "type": "phone",
    "number": "447700900001"
  },
  "status": "completed",
  "direction": "outbound",
  "rate": "0.39",
  "price": "23.40",
  "duration": "60",
  "start_time": "2015-02-04T22:45:00Z",
  "end_time": "2015-02-04T23:45:00Z",
  "network": "65512"
}
```
The 200 response contains the following keys and values:

Key | Value
-- | --
`_links` | A series of links between resources in this API in the http://stateless.co/hal_specification.html. @[Possible links](/_modals/voice/api/calls/links.md).
`uuid` | uuid	A unique identifier for this call.
`conversation_uuid` | The unique identifier for the conversation this call leg is part of.
`to` | The single or mixed collection of endpoint types you connected to. @[Possible values](/_modals/voice/guides/ncco-reference/endpoint.md).
`from` | The endpoint you are calling from. Possible value are the same as *to*.
`status` | Filter on the status of this call. [Possible values](#status-values)
`direction` | Possible values are `outbound` or `inbound`.
`rate` | The price per minute for this call.
`price` | The total price charged for this call.
`duration` | The time elapsed for the call to take place in seconds.
`start_time` | The time the call started in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`.
`end_time` | The time the call ended in the following format: `YYYY-MM-DD HH:MM:SS`. For example, `2020-01-01 12:00:00`.
`network` | The [Mobile Country Code Mobile Network Code (MCCMNC)](https://en.wikipedia.org/wiki/Mobile_country_code) for the carrier network used to make this call.


## Streams

You use the following requests to start and stop streaming audio to an active call.

### Stream an audio file to an active call

[PUT] `https://api.nexmo.com/v1/calls/{uuid}/stream`

You use a PUT request to stream an audio file to an active call.

This request contains:

* A [Base URL](#cspbase)
* [Payload](#cspparameters )
* [JWT](#jwt_minting)

Information about streaming is sent to you in the:

* [Response](#cspresponse) - parameters sent synchronously when streaming starts.

#### Base URL
All requests must contain:

* `https://api.nexmo.com/v1/calls/{uuid}/stream`

#### Payload

The following table shows the parameters you use to stream audio to a call:

Parameter | Description | Required
-- | -- | --
`stream_url` | An array containing a single URL to an mp3 or wav (16-bit) audio file to stream to the call or conversation. | Yes
`loop` | The number of times the audio file at *stream_url* is repeated before the stream ends. The default value is 1. Set to 0 to loop infinitely. | No

#### Response

The JSON response looks like:

```json
{
  "message": "Stream started",
  "uuid": "ssf61863-4a51-ef6b-11e1-w6edebcf93bb"
}
```

The 200 response contains the following keys and values:

Key | Value
-- | --
`message` | A string explaining the state of this request.
`uuid` | The unique id for this request.

### Stop streaming an audio file to an active call

[DELETE] `https://api.nexmo.com/v1/calls/{uuid}/stream`

You use a [DELETE] request to stop streaming audio to an active call.

This request contains:

* A [Base URL](#csdbase)
* [Payload](#csdparameters )
* [JWT](#jwt_minting)

Information about streaming is sent to you in the:

* [Response](#csdresponse) - parameters sent synchronously when the streaming stops.

#### Base URL
All requests must contain:

* `https://api.nexmo.com/v1/calls/{uuid}/stream`

#### Payload

There are no parameters for this request.

#### Response

The JSON response looks like:

```json
{
  "message": "Stream stopped",
  "uuid": "ssf61863-4a51-ef6b-11e1-w6edebcf93bb"
}
```

The 200 response contains the following keys and values:

Key | Value
-- | --
`message` | A string explaining the state of this request.
`uuid` | The unique id for this request.


## Talk

You use the following requests to start and stop synthesized audio messages in an active call.

### Send a synthesized speech message to an active call

[PUT] `https://api.nexmo.com/v1/calls/{uuid}/talk`

You use a PUT request to send a synthesized speech message to an active call.

This request contains:

* A [Base URL](#ctpbase)
* [Payload](#ctpparameters )
* [JWT](#jwt_minting)

Information about streaming is sent to you in the:

* [Response](#ctpresponse) - parameters sent synchronously when streaming starts.

#### Base URL
All requests must contain:

* `https://api.nexmo.com/v1/calls/{uuid}/talk`

#### Payload

The following table shows the parameters you use to send synthesized audio to a call:

Parameter | Description | Required
-- | -- | --
`text` | A UTF-8 and URL encoded string of up to 1500 characters containing the message to be synthesized in the call or conversation. Each comma in text adds a short pause to the synthesized speech. | Yes
`voice_name` | The name of the voice used to deliver text. You use the `voice_name` that has the correct language, gender and accent for the message you are sending. For example, the default voice Kimberly is a female who speaks English with an American accent (`en-US`). @[Possible values](/_modals/voice/guides/ncco-reference/voice-name.md). | No
`loop` | The number of times the audio file at `stream_url` is repeated before the stream ends. The default value is `1`. Set to `0` to loop infinitely. | Yes

#### Response

The JSON response looks like:

```json
{
  "message": "Talk started",
  "uuid": "ssf61863-4a51-ef6b-11e1-w6edebcf93bb"
}
```

The 200 response contains the following keys and values:

Key | Value
-- | --
`message` | A string explaining the state of this request.
`uuid` | The unique id for this request.

### Stop sending a synthesized speech message to an active call

[DELETE] `https://api.nexmo.com/v1/calls/{uuid}/talk`

You use a DELETE request to stop send synthesized audio to an active call.

This request contains:

* A [Base URL](#ctdbase)
* [Payload](#ctdparameters )
* [JWT](#jwt_minting)

Information about the synthesized audio is sent to you in the:

* [Response](#ctdresponse) - parameters sent synchronously when the synthesized audio stops.

#### Base URL

All requests must contain:

* `https://api.nexmo.com/v1/calls/{uuid}/talk`

#### Payload

There are no parameters for this request.

#### Response

The JSON response looks like:

```json
{
  "message": "Talk stopped",
  "uuid": "ssf61863-4a51-ef6b-11e1-w6edebcf93bb"
}
```

The 200 response contains the following keys and values:

Key | Value
-- | --
`message` | A string explaining the state of this request.
`uuid` | The unique id for this request.

## DTMF

You can use the following requests to use DTMF tones in your calls.

### Send Dual-tone multi-frequency (DTMF) tones to an active call

[PUT] `https://api.nexmo.com/v1/calls/{uuid}/dtmf`

You use a PUT request to send DTMF tones to an active call.

This request contains:

* A [Base URL](#dtmfbase)
* [Payload](#dtmfparameters )
* [JWT](#jwt_minting)

Information about this request is sent to you in the:

* [Response](#dtmfresponse) - parameters sent synchronously when you send DTMF tones.

#### Base URL
All requests must contain:

* `https://api.nexmo.com/v1/calls/{uuid}/dtmf`

#### Payload

The following table shows the parameters you use to stream audio to a call:

Parameter | Description | Required
-- | -- | --
`digits` | The array of digits to send to the call | Yes

#### Response

The JSON response looks like:

```json
{
  "message": "DTMF sent",
  "uuid": "ssf61863-4a51-ef6b-11e1-w6edebcf93bb"
}
```

The 200 response contains the following keys and values:

Key | Value
-- | --
`message` | A string explaining the state of this request.
`uuid` | The unique id for this request.

## Security and authentication

Each call you make to this API must have:

* [Security](#security)
* [Encoding](#encode)

### Encoding

You submit all requests with a [POST] or [GET] call using UTF-8 encoding and URL encoded values. The expected `Content-Type` for [POST] is `application/x-www-form-urlencoded`. For calls to a JSON endpoint, we also support:

* `application/json`
* `application/jsonrequest`
* `application/x-javascript`
* `text/json`
* `text/javascript`
* `text/x-javascript`
* `text/x-json` when posting parameters as a JSON object.

## Generating a JWT

The Nexmo Voice API uses JWTs to authenticate calls from your application. You generate a JWT by encrypting a JSON object containing the ID and private key of your application plus the current time. You add your JWT to the header in your requests to Nexmo API. The JWT authenticates your requests and tells Nexmo which application you are using.

A JWT consists of a header, a payload and a signature in the structure xxxxx.yyyyy.zzzzz. For more information, see  <https://jwt.io/introduction/> and the [JWT reference ](/concepts/guides/applications#reference).

The following code examples show how to generate a JWT token:

When you use JWTs for authentication, you must still follow [Security](#security) and [Encoding](#encode).

## `status` values

The table below lists the possible values for the status of a call as returned by a number of Voice API endpoints.

Value | Description
-- | --
`started` | Platform has stared the call.
`ringing` | The user's handset is ringing.
`answered` | The user has answered your call.
`machine` | Platform detected an answering machine.
`completed` | Platform has terminated this call.
`timeout` | Your user did not answer your call within `ringing_timer` seconds.
`failed` | The call failed to complete
`rejected` | The call was rejected
`unanswered` | The call was not answered
`busy` | The number being dialled was on another call
`cancelled` | The call was ended before the user could answer the call

When a Call enters a state of `timeout`, `failed`, `rejected`, `unanswered` or `busy` the `event_url` webhook endpoint can optionally return an NCCO to override the current NCCO. See [Connect with fallback NCCO](/voice/guides/ncco-reference#connect_fallback).


## Errors

The following HTTP codes are supported:

Code | Description
-- | --
 | Success
`201` | Resource created
`204` | No content
`401` | Unauthorized
`404` | Not found
`429` | Rate limited
`500` | Nexmo server error

The error format is standardized to the `4xx`/`5xx` range with a code and a human readable explanation. For example, for an authentication failure.

```json
{
  "type": "TYPE",
  "error_title":"TITLE",
  "invalid_parameters":{
    "type":"Is required."
  }
}
```
