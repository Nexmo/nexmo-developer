---
title: Search Available Numbers
navigation_weight: 2
---

# Search Available Numbers

This page shows you how to programmatically search for numbers that are available for purchase.

> You can also search for available numbers online, using the [developer dashboard](https://dashboard.nexmo.com/buy-numbers) or from the command line, using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli#search-for-new-numbers).

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`COUNTRY_CODE` | The two digit country code for the numbers you want to search. For example: `GB` for the United Kingdom.
`NEXMO_NUMBER_TYPE` | The type of number: `landline`, `mobile-lvn` or `landline-toll-free`
`NEXMO_NUMBER_FEATURES` | The capabilities of the number: `SMS`, `VOICE` or `SMS,VOICE` for both
`NUMBER_SEARCH_CRITERIA` | The filter criteria. For example, numbers containing `234`.
`NUMBER_SEARCH_PATTERN` | Where the `NUMBER_SEARCH_CRITERIA` should appear in the number: <ul><li>`0` - At the beginning of the number</li><li>`1`- Anywhere in the number</li><li>`2` - At the end of the number</ul>

```code_snippets
source: '_examples/numbers/search'
```

## See also

* [API reference](/api/numbers)
