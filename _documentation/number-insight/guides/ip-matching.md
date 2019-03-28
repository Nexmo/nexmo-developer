---
title: IP Matching
description: Detecting potential fraud by checking the location of the user's IP against their phone number.
navigation_weight: 2
---

# IP Matching

## Overview

You can use Nexmo's Number Insight Advanced API to determine whether a user's IP address is in the same location as their phone. This can help you detect potentially fraudulent use of your services.

## Making the request

Pass the user's IP address in the `ip` parameter when you make the request, as shown in the following `curl` example.

Replace the `NEXMO_API_KEY` and `NEXMO_API_SECRET` placeholder variables with your own API key and secret from the [developer dashboard](https://dashboard.nexmo.com/getting-started-guide).

```bash
curl 'https://api.nexmo.com/ni/advanced/json?api_key=NEXMO_API_KEY&api_secret=NEXMO_API_SECRET&number=INSIGHT_NUMBER&ip=&cname=true'
```

## Understanding the response

When you include the `ip` parameter in the request, the `ip` field in the response contains an object with the following properties:

* `address`: the IP address you specified in the request
* `ip_match_level`: either `country` (if Number Insight was able to determine the country the IP address originates from) or `mismatch` (if it couldn't)
* `ip_country`: the country that `ip` originates from (if successful)
* `ip_city`: the city that `ip` originates from (if successful and known)


### Example response

In the following sample response, the user's IP address originates from South Korea (`KR`), but the user's phone is located in the United Kingdom (`GB`). The `ip_match_level` indicates that there is a possible mismatch.

> **Note**: The `ip_warnings` property is deprecated and can safely be ignored. 

```json
{
    "status": 0,
    "status_message": "Success",
    "lookup_outcome": 1,
    "lookup_outcome_message": "Partial success - some fields populated",
    "request_id": "0aad8f5f-1ff4-404b-9dc2-6fc47737a668",
    "international_format_number": "447700900001",
    "national_format_number": "07700 900001",
    "country_code": "GB",
    "country_code_iso3": "GBR",
    "country_name": "United Kingdom",
    "country_prefix": "44",
    "request_price": "0.03000000",
    "remaining_balance": "5.00",
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
    },
    "ip_warnings": "unknown"
}
```
