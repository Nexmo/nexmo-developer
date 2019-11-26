---
title: Number Insight Basic
navigation_weight: 2
---

# Number Insight Basic

Use Nexmo's Number Insight Basic API to determine:

* The country where a number is registered
* The local and international representation of that number

This can help you present numbers to your users in the correct format for their locale.

Before attempting to run the code examples, replace the variable placeholders as instructed in [replaceable variables](/number-insight/code-snippets/before-you-begin#replaceable-variables).

```code_snippets
source: '_examples/number-insight/basic'
```

The response from the API contains the following data:

```json
{
    "status": 0,
    "status_message": "Success",
    "request_id": "fcb1e9a2-db9c-4ea2-84be-4e60da45e187",
    "international_format_number": "447700900000",
    "national_format_number": "07700 900000",
    "country_code": "GB",
    "country_code_iso3": "GBR",
    "country_name": "United Kingdom",
    "country_prefix": "44"
}
```

For a description of each returned field and to see all possible values, see the [Number Insights API documentation](/api/number-insight?expandResponses=true#response-getNumberInsightBasic)
