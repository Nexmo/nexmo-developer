---
title: Retrieving CNAM Owner Details
description: Retrieve identity details for US callers.
navigation_weight: 1
---

# Retrieving CNAM Owner Details

## Overview

Nexmo's Number Insight Advanced API enables you to retrieve CNAM owner details for many United States phone numbers. This includes landline and cellular numbers for both consumers and businesses.

CNAM is an acronym which stands for Caller ID Name. US networks use it to display the calling party’s name alongside the phone number, to help users identify a caller.

> The Number Insight Advanced API only provides CNAM details for US numbers: it cannot return this information for numbers in other countries.

## Making the request

Passing `cname=true` as an extra parameter in a call to the Advanced API looks up that number's CNAM.

The following example shows how you would request CNAM data using `curl`:

```bash
$ curl -X "POST" "https://api.nexmo.com/ni/advanced/json" \
> -d "api_key=NEXMO_API_KEY" \
> -d "api_secret=NEXMO_API_KEY" \
> -d "number=14155550100" \
> -d "cname=true"
```

## Understanding the response

In the response returned by the Number Insight Advanced API, the following fields relate to CNAM:

* `caller_name`: the owner name
* `caller_type`: either `business` or `consumer` depending on the type of number
* `first_name` and `last_name`: for consumer numbers only

### Consumer example

```json
{
    "status": 0,
    "status_message": "Success",
    "lookup_outcome": 1,
    "lookup_outcome_message": "Partial success - some fields populated",
    "request_id": "50793c0c-8025-408f-ab9a-71cbbaf033bf",
    "international_format_number": "14155550100",
    "national_format_number": "(415) 55500100",
    "country_code": "US",
    "country_code_iso3": "USA",
    "country_name": "United States of America",
    "country_prefix": "1",
    "request_price": "0.04000000",
    "remaining_balance": "10.000000",
    "current_carrier": {
        "network_code": "310004",
        "name": "Verizon Wireless",
        "country": "US",
        "network_type": "mobile"
    },
    "original_carrier": {
        "network_code": "310004",
        "name": "Verizon Wireless",
        "country": "US",
        "network_type": "mobile"
    },
    "valid_number": "valid",
    "reachable": "unknown",
    "ported": "not_ported",
    "roaming": {"status": "unknown"},
    "ip_warnings": "unknown",
    "caller_name": "Wile E. Coyote",
    "last_name": "Coyote",
    "first_name": "Wile",
    "caller_type": "consumer"
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
