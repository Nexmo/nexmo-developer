---
title: Number Insight Advanced (Sync)
navigation_weight: 6
---

# Number Insight Advanced (Synchronous)

This code snippet shows you how to use Number Insight Advanced API synchronously.

> **Note**: Nexmo does not recommend this approach, because it can result in timeouts. In most cases, you should use an [asynchronous call](number-insight-advanced-async) to the Number Insight API.

Before attempting to run the code examples, replace the variable placeholders as instructed in [replaceable variables](/number-insight/code-snippets/before-you-begin#replaceable-variables).

```code_snippets
source: '_examples/number-insight/advanced'
```

The response from the API contains the following data:

```json
{
    "status": 0,
    "status_message": "Success",
    "lookup_outcome": 0,
    "lookup_outcome_message": "Success",
    "request_id": "75fa272e-4743-43f1-995e-a684901222d6",
    "international_format_number": "447700900000",
    "national_format_number": "07700 900000",
    "country_code": "GB",
    "country_code_iso3": "GBR",
    "country_name": "United Kingdom",
    "country_prefix": "44",
    "request_price": "0.03000000",
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
    "valid_number": "valid",
    "reachable": "reachable",
    "ported": "ported",
    "roaming": {"status": "not_roaming"}
}
```

For a description of each returned field and to see all possible values, see the [Number Insights API documentation](/api/number-insight?expandResponses=true#response-getNumberInsightAdvanced)
