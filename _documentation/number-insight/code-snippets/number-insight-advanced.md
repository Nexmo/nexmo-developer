---
title: Number Insight Advanced
navigation_weight: 4
---

# Number Insight Advanced

The Number Insight Advanced API provides all the data from the [Number Insight Standard API](/number-insight/code-snippets/number-insight-standard) together with the following additional information:

* If the number is likely to be valid
* If the number is ported
* If the number is reachable
* If the number is roaming and, if so, the carrier and country

Use this information to determine the risk associated with a number.

> Note that the Advanced API does not provide any extra information about landlines than the [Number Insight Standard API](/number-insight/code-snippets/number-insight-standard). For insights about landline numbers, use the Standard API.

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
