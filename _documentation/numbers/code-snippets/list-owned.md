---
title: List Your Numbers
navigation_weight: 1
---

# List Your Numbers

This page shows you how to list the numbers that you own programmatically.

> You can also view your numbers online, using the [developer dashboard](https://dashboard.nexmo.com/your-numbers) or from the command line, using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli#list-all-numbers-on-your-account).

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`COUNTRY_CODE` | The two digit country code for the number you want to cancel. For example: `GB` for the United Kingdom.
`NUMBER_SEARCH_CRITERIA` | The filter criteria. For example, numbers containing `234`.
`NUMBER_SEARCH_PATTERN` | Where the `NUMBER_SEARCH_CRITERIA` should appear in the number: <ul><li>`0` - At the beginning of the number</li><li>`1`- Anywhere in the number</li><li>`2` - At the end of the number</ul>

```code_snippets
source: '_examples/numbers/list-owned'
```

## See also

* [API reference](/api/numbers)