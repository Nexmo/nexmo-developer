---
title: Buy a Number
navigation_weight: 3
---

# Buy a Number

You need to purchase a Vonage [virtual number](/concepts/guides/glossary#virtual-number) if you want to:

* Make or receive telephone calls with the [Voice API](/voice/voice-api/overview)
* Receive inbound SMS with the [SMS API](/messaging/sms/overview)
* Use multichannel messaging with the [Messages API](/messages/overview)

This page shows you how to buy a number programmatically.

> You can also cancel a number online, using the [developer dashboard](https://dashboard.nexmo.com/your-numbers) or from the command line, using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli#buying-a-number).

Replace the following variables in the sample code with your own values:

```snippet_variables
- VONAGE_API_KEY
- VONAGE_API_SECRET
- COUNTRY_CODE
- VONAGE_NUMBER
```

```code_snippets
source: '_examples/numbers/buy'
```

## See also

* [API reference](/api/numbers)
