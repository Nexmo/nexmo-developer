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

Name | Description
--|--
`VONAGE_API_KEY` | Your Vonage [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`VONAGE_API_SECRET` | Your Vonage [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`COUNTRY_CODE` | The two digit country code for the number you want to buy. For example: `GB` for the United Kingdom.
`VONAGE_NUMBER` | The Vonage virtual number you want to cancel. Omit the leading zero but include the international dialing code. For example: `447700900000`.

```code_snippets
source: '_examples/numbers/buy'
```

## See also

* [API reference](/api/numbers)
