---
title: CNAM - retrieve number owner's name
---

# CNAM - retrieve number owner's name

Nexmo's Number Insight Advanced API allows you to retrieve details about the owner of many United States phone numbers, both landline and cellular. This includes both residential and business lines. It only works for numbers based in the United States—no information will be provided for numbers in any other country.

Passing `cname=true` as an extra parameter to a call to the [Number Insight Advanced API](/number-insight/building-blocks/number-insight-advanced) or its [async equivalent](/number-insight/building-blocks/number-insight-advanced-async) will look up that number's CNAM called ID.

In the response sent back by the Number Insight Advanced API, the following fields relate to CNAM:

* `lookup_outcome`: 
* `caller_name`: the full formatted name of the line owner.
* `caller_type`: either `business` or `consumer` depending on the type of number.
* `first_name` and `last_name`: for individual consumers.

## Consumer example

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

## Business example

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
