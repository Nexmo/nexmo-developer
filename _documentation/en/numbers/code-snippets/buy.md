---
title: Buy a Number
navigation_weight: 3
---

# Buy a Number

You need to purchase a Nexmo [virtual number]() if you want to:

* Make or receive telephone calls with the [Voice API](https://developer.nexmo.com/voice/voice-api/overview)
* Receive inbound SMS with the [SMS API](https://developer.nexmo.com/messaging/sms/overview)
* Use multichannel messaging with the [Messages API](https://developer.nexmo.com/messages/overview)

This page shows you how to buy a number programmatically.

> You can also cancel a number online, using the [developer dashboard](https://dashboard.nexmo.com/your-numbers) or from the command line, using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli#buying-a-number).

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`COUNTRY_CODE` | The two digit country code for the number you want to buy. For example: `GB` for the United Kingdom.
`NEXMO_NUMBER` | The Nexmo virtual number you want to cancel. Omit the leading zero but include the international dialing code. For example: `447700900000`.

```code_snippets
source: '_examples/numbers/buy'
```

## See also

* [API reference](/api/numbers)
