---
title: Number Insight API Reference
description: Reference guide for Number Insight API.
api: Number Insight
---

# Number Insight API Reference

* [Request](#request) - ask for information about a phone number
* [Response](#response) - the information you requested about a phone number

## Request

Getting information about a number with Nexmo's Number Insight API is straightforward. [Sign up for an account](https://dashboard.nexmo.com/sign-up) and replace the following variables in the example below:

| Key | Description |
| -------- | ----------- |
| `API_KEY` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview) |
| `API_SECRET` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview) |
| `NUMBER` | A single phone number that you need insight about in national or international format. The number may include any or all of the following: `white space`, `-`, `+`, `(`, `)`. |
| `LEVEL` | Should be `basic`, `standard` or `advanced`. See features in the table below. |
| `FORMAT` | Should be `json`, `xml`. |

```sh
curl "https://api.nexmo.com/ni/:LEVEL/:FORMAT" \
   -d "api_key=API_KEY" \
   -d "api_secret=API_SECRET" \
   -d "number=NUMBER"
```

###  Optional parameters

The following table shows extra parameters you can use in the request:

Parameter | Description | Required
-- | -- | --
`country` | If a number does not have a country code or is uncertain, set the two-character country code. This code must be in ISO 3166-1 alpha-2 format and in upper case. For example, GB or US. If you set country and number is already in [E.164](https://en.wikipedia.org/wiki/E.164) format, country must match the country code in number.| ❎
`cnam` | Indicates if the name of the person who owns the phone number should be looked up and returned in the response. Set to true to receive phone number owner name in the response. This features is available for US numbers only and incurs an additional charge. Default value is false. | ❎
`ip` | The IP address of the user. If supplied, we will compare this to the country the user's phone is located in and return an error if it does not match. | ❎


## Response

The response to each *request* you make to Number Insight API returns the:

* Status of your request to Nexmo in [JSON or XML](#format) format.
* Information you asked for in the request.

Each response comes:

* In a specific [Format](#format)
* With <a href="#keys-and-values">Keys and values</a>

### Format

You set the response type using the [Base URL](#base). The following table shows example responses in JSON or XML:

```tabbed_content
source: '/_examples/api/number-insight/response'
```

### Keys and Values

The response contains the following keys and values:

Key | Value | Basic | Standard | Advanced
-- | -- | -- | -- | --
`status`, `status_message`, `error_text` | The status code and a description about your request. When `status` is 0 or 1,`status_message` is returned. For all other values,`error_text`. @[Possible values](/_modals/api/number-insight/response/status.md). | ✅ | ✅ | ✅
`request_id` | The unique identifier for your request. This is a alphanumeric string up to 40 characters. | ✅ | ✅ | ✅
`international_format_number` | The `number` in your request in International format. | ✅ | ✅ | ✅
`national_format_number` | The `number` in your request in the format used by the country the number belongs to. | ✅ | ✅ | ✅
`country_code` | Two character country code for `number`. This is in [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) format. | ✅ | ✅ | ✅
`country_code_iso3` | Three character country code for `number`. This is in [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) format. | ✅ | ✅ | ✅
`country_name` | The full name of the country that `number` is registered in. | ✅ | ✅ | ✅
`country_prefix` | The numeric prefix for the country that `number` is registered in. | ✅ | ✅ | ✅
`request_price` | The amount in EUR charged to your account. | ❎ | ✅ | ✅
`refund_price` | If there is an internal lookup error, the `refund_price` will reflect the lookup price. If `cnam` is requested for a non-US number the `refund_price` will reflect the `cnam` price. If both of these conditions occur, `refund_price` is the sum of the lookup price and `cnam` price. | ❎ | ✅ | ✅
`remaining_balance` | Your account balance in EUR after this request. Not returned with Number Insight Advanced Async API. | ❎ | ✅ | ✅
`ported` | If the user has changed carrier for `number`. Possible values are: `unknown`, `ported`, `not_ported`, `assumed_not_ported`, `assumed_ported`. The assumed status means that the information supplier has replied to the request but has not said explicitly that the number is ported. | ❎ | ✅ | ✅
`current_carrier` | Information about the network `number` is currently connected to. @[Possible values](/_modals/api/number-insight/response/carrier.md) | ❎ | ✅ | ✅
`original_carrier` | Information about the network `number` was initially connected to. @[Possible values](/_modals/api/number-insight/response/carrier.md): | ❎ | ✅ | ✅
`caller_name` | Full name of the person who owns the phone number. `unknown` if this information is not available. This parameter is only present if `cnam` had a value of `true` within the request. | ❎ | ✅ | ✅
`first_name` | First name of the person who owns the phone number if the owner is an individual. This parameter is only present if `cnam` had a value of `true` within the request. | ❎ | ✅ | ✅
`last_name` | Last name of the person who owns the phone number if the owner is an individual. This parameter is only present if `cnam` had a value of `true` within the request. | ❎ | ✅ | ✅
`caller_type` | The value will be `business` if the owner of a phone number is a business. If the owner is an individual the value will be `consumer`. The value will be `unknown` if this information is not available. This parameter is only present if `cnam` had a value of `true` within the request. | ❎ | ✅ | ✅
`lookup_outcome` and `lookup_outcome_message` | Shows if all information about a phone number has been returned. @[Possible values](/_modals/api/number-insight/response/lookup_outcome.md). | ❎ | ❎ | ✅
`valid_number` | Does `number` exist. Possible values are `unknown`, `valid`, `not_valid`. This is applicable to mobile numbers only. | ❎ | ❎ | ✅
`reachable` | Can you call `number` now. Possible values are: `unknown`, `reachable`, `undeliverable`, `absent`, `bad_number`, `blacklisted`. This is applicable to mobile numbers only. | ❎ | ❎ | ✅
`roaming` | Information about the roaming status for `number`. @[Possible values](/_modals/api/number-insight/response/roaming.md). This is applicable to mobile numbers only. | ❎ | ❎ | ✅
`ip` | The [ip](#ip) address you specified in the request. This field is blank if you did not specify `ip`. | ❎ | ❎ | ✅
`ip_warnings` | Warning levels for `ip`: `unknown` or `no_warning` | ❎ | ❎ | ✅
`ip_match_level` | The match status between [ip](#ip) and [number](#parameters). Possible values are. `Country Level` or `Mismatch`. This value is only returned if you set [ip](#ip) in the `request`. | ❎ | ❎ | ✅
`ip_country` | The country that `ip` is allocated to. This value is only returned if you set [ip](#ip) in the `request`. | ❎ | ❎ | ✅
