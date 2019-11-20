---
title: Number Insight Standard
navigation_weight: 3
---

# Number Insight Standard

The Number Insight Standard API provides all the information from the [Number Insight Basic API](/number-insight/code-snippets/number-insight-basic) together with the following additional data:

* The line type (mobile/landline/virtual number/premium/toll-free)
* The Mobile Country Code (MCC) and Mobile Network Code (MNC)
* The name of the caller (USA only)

Use this information to determine the best type of communication for a number (SMS or voice) and block virtual numbers.

Before attempting to run the code examples, replace the variable placeholders as instructed in [replaceable variables](/number-insight/code-snippets/before-you-begin#replaceable-variables).

```code_snippets
source: '_examples/number-insight/standard'
```

The response from the API contains the following data:

```json
{
    "status": 0,
    "status_message": "Success",
    "request_id": "e98e0dfb-c485-491b-8d2a-283f35e21d04",
    "international_format_number": "447700900000",
    "national_format_number": "07700 900000",
    "country_code": "GB",
    "country_code_iso3": "GBR",
    "country_name": "United Kingdom",
    "country_prefix": "44",
    "request_price": "0.00500000",
    "remaining_balance": "10.000000",
    "current_carrier": {
        "network_code": "23420",
        "name": "Hutchison 3G Ltd",
        "country": "GB",
        "network_type": "mobile"
    },
    "original_carrier": {
        "network_code": "23410",
        "name": "Telefonica UK Limited",
        "country": "GB",
        "network_type": "mobile"
    },
    "ported": "assumed_ported",
    "roaming": {"status": "unknown"}
}
```

For a description of each returned field and to see all possible values, see the [Number Insights API documentation](/api/number-insight?expandResponses=true#response-getNumberInsightStandard)
