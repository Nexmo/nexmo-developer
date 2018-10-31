---
title: Developer - Numbers API Reference
description: Reference guide for the Numbers API.
api: Developer API
---

# Developer - Numbers API Reference

The Numbers API lets you manage your numbers and buy new virtual numbers for use with Nexmo's APIs. Read our [Authentication Guide](/concepts/guides/authentication) for information on how to pass your credentials by query string.

## Numbers

### List owned numbers

Retrieve all the inbound numbers associated with your Nexmo account.

#### Request

```
[GET] https://rest.nexmo.com/account/numbers
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`index` | Page index [Default: 1] | No
`size` | Page size [Max: 100] [Default: 10] | No
`pattern` | A matching pattern | No
`search_pattern` | Strategy for matching pattern. Expected values: `0` (starts with, default), `1` (anywhere), `2` (ends with). | No

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
source: _examples/api/developer/numbers/list-owned-numbers
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`count` | The total amount of numbers owned by account.
`numbers` | A paginated array of numbers and their details.

### Search available numbers

Retrieve inbound numbers that are available for a given country.

#### Request

```
[GET] https://rest.nexmo.com/number/search
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`country` | The two character country code in ISO 3166-1 alpha-2 format. | Yes
`pattern` | A number pattern to search for. | No
`search_pattern` | Strategy for matching pattern. Expected values: `0` (starts with, default), `1` (anywhere), `2` (ends with). | No
`type` | The type of number to search for. Accepted values: `landline`, `landline-toll-free` and `mobile-lvn`. | No
`features` | Available features are SMS and VOICE. For both features, use a comma-separated value SMS,VOICE. | No
`size` | Page size [Max: 100] [Default: 10] | No
`index` | Page index [Default: 1] | No

#### Response

The following shows example Responses in JSON or XML:


```tabbed_examples
source: _examples/api/developer/numbers/search-available-numbers
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`count` | The total amount of numbers available in the pool.
`numbers` | A paginated array of available numbers and their details.

### Buy a number

Request to purchase a specific inbound number.

#### Request

```
[POST] https://rest.nexmo.com/number/buy
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`country` | The two character country code in ISO 3166-1 alpha-2 format. | Yes
`msisdn` | An available inbound virtual number. For example, `447700900000`. | Yes

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
source: _examples/api/developer/numbers/buy-a-number
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`count` | The total amount of numbers owned by account.
`numbers` | A paginated array of numbers and their details.

### Cancel a number

Cancel your subscription for a specific inbound number.

#### Request

```
[POST] https://rest.nexmo.com/number/cancel
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`country` | The two character country code in ISO 3166-1 alpha-2 format. | Yes
`msisdn` | One of your inbound numbers. For example, `447700900000`. | Yes

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
source: _examples/api/developer/numbers/cancel-a-number
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`count` | The total amount of numbers owned by account.
`numbers` | A paginated array of numbers and their details.

### Update a number

Change the behaviour of a number that you own

#### Request

```
[POST] https://rest.nexmo.com/number/update
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`country` | The two character country code in ISO 3166-1 alpha-2 format. | Yes
`msisdn` | An available inbound virtual number. For example, `447700900000`. | Yes
`moHttpUrl` | An URL encoded URI to the webhook endpoint that handles inbound messages. Your webhook endpoint must be active before you make this request, Nexmo makes a [GET] request to your endpoint and checks that it returns a `200 OK` response. Set to empty string to clear. | No
`moSmppSysType` | The associated system type for your SMPP client. For example `inbound`. | No
`voiceCallbackType` | The voice webhook type. Possible values are `sip`, `tel`, or `app` | No
`voiceCallbackValue` | A SIP URI, telephone number or Application ID  | No
`voiceStatusCallback` | A webhook URI for Nexmo to send a request to when a call ends. | No
`messagesCallbackType` | The messages API webhook type. Must be `app`. | No
`messagesCallbackValue` | Application ID referencing application with defined URLs. | No

Please note that if you specify a `voiceCallbackValue` you must also provide the `voiceCallbackType` parameter. If you specify a `messagesCallbackValue` you must also provide `messagesCallbackType`.

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
source: _examples/api/developer/numbers/update-a-number
```
