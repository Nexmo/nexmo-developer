---
title: IP Matching
description: Detecting potential fraud by checking the location of the user's IP against their phone number.
navigation_weight: 2
---

# IP Matching

## Overview

You can use Nexmo's Number Insight Advanced API to determine whether a user's IP address is in the same location as their handset. This can help you detect potentially fraudulent use of your services.

## Making the request

Pass the user's IP address in the `ip` parameter when you make the request, as shown in the following `curl` example.

Replace the following values in the code snippets with your own details:

Key |	Description
-- | --
`NEXMO_API_KEY` | API key.
`NEXMO_API_SECRET` | API secret.
`INSIGHT_NUMBER` | The number you want to retrieve insight information for.
`IP_ADDRESS` | The user's IP address.

```bash
curl 'https://api.nexmo.com/ni/advanced/json?api_key=NEXMO_API_KEY&api_secret=NEXMO_API_SECRET&number=INSIGHT_NUMBER&ip=IP_ADDRESS&cname=true'
```

## Understanding the response

When you include the `ip` parameter in the request, the `ip` field in the response contains an object with the following properties:

* `address`: the IP address you specified in the request
* `ip_match_level`: either `country` (if Number Insight was able to determine the country the IP address originates from) or `mismatch` (if it couldn't)
* `ip_country`: the country that `ip` originates from (if successful)
* `ip_city`: the city that `ip` originates from (if successful)

> *** MARK:

The `ip_warnings` property in the response consists of `no_warning` if the `ip_country` is the same as `country_name` and `unknown` if not.

### Example response

```json
{
{
    "status": 44,
    "status_message": "Lookup Handler unable to handle request",
    "lookup_outcome": 1,
    "lookup_outcome_message": "Partial success - some fields populated",
    "request_id": "6b1abd76-9bdf-4a22-936c-2b4fc98ce446",
    "international_format_number": "*****",
    "national_format_number": "******",
    "country_code": "GB",
    "country_code_iso3": "GBR",
    "country_name": "United Kingdom",
    "country_prefix": "44",
    "request_price": "0.03000000",
    "remaining_balance": "123.20567499",
    "current_carrier": {
        "network_code": "23410",
        "name": "Telefonica UK Limited",
        "country": "GB",
        "network_type": "mobile"
    },
    "original_carrier": {
        "network_code": "23410",
        "name": "Telefonica UK Limited",
        "country": "GB",
        "network_type": "mobile"
    },
    "valid_number": "valid",
    "reachable": "reachable",
    "ported": "not_ported",
    "roaming": {
        "status": "not_roaming"
    },
    "ip": {
        "address": "123.0.0.255",
        "ip_match_level": "mismatch",
        "ip_country": "KR",
        "ip_city": ""
    }
}
}
```

### Business example

```json
{
    "status": 0,
    "status_message": "Success",
    "lookup_outcome": 1,
    "lookup_outcome_message": "Partial success - some fields populated",
    "request_id": "27c61a46-5b4a-4e80-b16d-725432559078",
    "international_format_number": "14155550101",
    "national_format_number": "(415) 555-0101",
    "country_code": "US",
    "country_code_iso3": "USA",
    "country_name": "United States of America",
    "country_prefix": "1",
    "request_price": "0.04000000",
    "remaining_balance": "10.000000",
    "current_carrier": {
        "network_code": "US-FIXED",
        "name": "United States of America Landline",
        "country": "US",
        "network_type": "landline"
    },
    "original_carrier": {
        "network_code": "US-FIXED",
        "name": "United States of America Landline",
        "country": "US",
        "network_type": "landline"
    },
    "valid_number": "valid",
    "reachable": "unknown",
    "ported": "not_ported",
    "roaming": {"status": "unknown"},
    "ip_warnings": "unknown",
    "caller_name": "ACME Corporation",
    "caller_type": "business"
}
```
