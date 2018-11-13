---
title: Developer - Pricing API Reference
description: Reference guide for the Pricing API.
api: Developer API
---

# Developer - Pricing API Reference

> <strong>Please note that the Pricing API is rate limited to one request per second.</strong>

## Pricing

### Pricing by country

Retrieve our outbound pricing for a given country

#### Request

```
[GET] https://rest.nexmo.com/account/get-pricing/outbound/:type
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`type` | The type of service you wish to retrieve data about: either `sms`, `sms-transit` or `voice`. | No
`api_key` | Your Nexmo API key. | Yes
`api_secret` | Your Nexmo API secret. | Yes
`country` | 	A 2 letter [country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). For example, `CA` | Yes

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
source: _examples/api/developer/account/pricing/per-country-pricing/
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`dialingPrefix` | The numerical dialing prefix code for the country in question (e.g. for the United Kingdom, `44`, for the United States `1`)
`currency` | The currency that your account is being billed in (by default: Euros—`EUR`). Changeable via the Dashboard to US Dollars—`USD`.
`countryDisplayName` | The display name for the country you looked up: e.g. `United Kingdom`, `Belgium`, `Japan`.
`countryCode` | The code for the country you looked up: e.g. `GB`, `US`, `BR`, `RU`.
`countryName` | The name for the country you looked up: e.g. `United Kingdom`.
`networks` | An array containing [networks](#network).

The number prefix ranges refer to who owns the number range. In many countries it is possible to port your number from mobile operator to another: number prefix ranges refer to who owns the number range, but a mobile subscriber using a ported number may be using a network different from the owner of the network. You can use the [Number Insight API](/number-insight) to look up individual numbers to see if they have been ported.

### Pricing for all countries

Retrieve our outbound pricing for all countries.

#### Request

```
[GET] https://rest.nexmo.com/account/get-full-pricing/outbound/:type
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`type` | The type of service you wish to retrieve data about: either `sms`, `sms-transit` or `voice`. | Yes
`api_key` | Your Nexmo API key. | Yes
`api_secret` | Your Nexmo API secret. | Yes

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
tabs:
  JSON:
    source: _examples/api/developer/account/pricing/full-pricing/JSON
  XML:
    source: _examples/api/developer/account/pricing/full-pricing/XML
```

Actual responses are quite lengthy; these responses have been shortened.

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`count` | The number of countries returned in the response.
`countries` | An array containing each country.

For each country, the following information is provided:

Key | Value
-- | --
`dialingPrefix` | The numerical dialing prefix code for the country in question (e.g. for the United Kingdom, `44`, for the United States `1`)
`currency` | The currency that your account is being billed in (by default: Euros—`EUR`). Changeable via the Dashboard to US Dollars—`USD`.
`countryDisplayName` | The display name for the country you looked up: e.g. `United Kingdom`, `Belgium`, `Japan`.
`countryCode` | The code for the country you looked up: e.g. `GB`, `US`, `BR`, `RU`.
`countryName` | The name for the country you looked up: e.g. `United Kingdom`.
`networks` | An array containing [networks](#network).

The number prefix ranges refer to who owns the number range. In many countries it is possible to port your number from mobile operator to another: number prefix ranges refer to who owns the number range, but a mobile subscriber using a ported number may be using a network different from the owner of the network. You can use the [Number Insight API](/number-insight) to look up individual numbers to see if they have been ported.

### Pricing by prefix

```
[GET] https://rest.nexmo.com/account/get-prefix-pricing/outbound/:type
```

Retrieves pricing information based on the numerical prefix used in phone numbers.

In most cases, a number prefix will only be used by one country, but exceptions exist. In the case of `1`, it is used by both the United States and Canada, as well as the [United States Minor Outlying Islands](https://en.wikipedia.org/wiki/United_States_Minor_Outlying_Islands), due to the [North American Numbering Plan](https://en.wikipedia.org/wiki/North_American_Numbering_Plan). All three appear as separate entries in the response.

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`type` | The type of service you wish to retrieve data about: either `sms`, `sms-transit` or `voice`. | Yes
`api_key` | Your Nexmo API key. | Yes
`api_secret` | Your Nexmo API secret. | Yes
`prefix` | The numerical prefix to look up. Examples: `44`, `1` etc.

#### Response

The following shows example Responses in JSON or XML:

```tabbed_examples
tabs:
  JSON:
    source: _examples/api/developer/account/pricing/prefix/JSON
  XML:
    source: _examples/api/developer/account/pricing/prefix/XML
```

Actual responses are quite lengthy; these responses have been shortened.


##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`count` | The number of countries returned in the response.
`prices` | An array of objects.
`countries` | An array containing each country.

For each country, the following information is provided:

Key | Value
-- | --
`dialingPrefix` | The numerical dialing prefix code for the country in question (e.g. for the United Kingdom, `44`, for the United States `1`)
`currency` | The currency that your account is being billed in (by default: Euros—`EUR`). Changeable via the Dashboard to US Dollars—`USD`.
`countryDisplayName` | The display name for the country you looked up: e.g. `United Kingdom`, `Belgium`, `Japan`.
`countryCode` | The code for the country you looked up: e.g. `GB`, `US`, `BR`, `RU`.
`countryName` | The name for the country you looked up: e.g. `United Kingdom`.
`networks` | An array containing [networks](#network).

The number prefix ranges refer to who owns the number range. In many countries it is possible to port your number from mobile operator to another: number prefix ranges refer to who owns the number range, but a mobile subscriber using a ported number may be using a network different from the owner of the network. You can use the [Number Insight API](/number-insight) to look up individual numbers to see if they have been ported.


## Common elements in responses

### Network

The following data is common in a number of the above responses.

Key | Value
-- | --
`type` | The type of network: `mobile` or `landline`.
`price` | The cost to send a message or make a call to this network
`currency` | The currency used for prices for this network.
`ranges` | A list of number prefixes that belong to this network.
`mcc` | The [Mobile Country Code](https://en.wikipedia.org/wiki/Mobile_country_code) of the operator.
`mnc` | The Mobile Network Code of the operator.
`networkCode` | The Mobile Country Code and Mobile Network Code combined to give a unique reference for the operator.
`networkName` | The company/organisational name of the operator.
