---
title: Update a Number
navigation_weight: 4
---

# Update a Number

This page shows you how to programmatically update the configuration settings for one of your numbers.

> You can also update these settings online, using the [developer dashboard](https://dashboard.nexmo.com/). Select the "Your Applications" option from either the "Voice" or "Messages and Dispatch" menu. Or, you can use the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli#update-a-number).

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`COUNTRY_CODE` | The two digit country code for the number you want to update. For example: `GB` for the United Kingdom.
`NEXMO_NUMBER` | The Nexmo virtual number you want to update. Omit the leading zero but include the international dialing code. For example: `447700900000`.
`SMS_CALLBACK_URL` | An URL-encoded URI to the webhook endpoint that handles inbound messages. Your webhook endpoint must be active before you make this request. Nexmo makes a GET request to the endpoint and checks that it returns a 200 OK response. Set this parameter's value to an empty string to remove the webhook.
`MESSAGES_APPLICATION_ID` | The ID associated with your Messages API application
`VOICE_CALLBACK_TYPE` | The Voice API webhook type: `sip`, `tel` or `app`
`VOICE_CALLBACK_VALUE` | A SIP URI, telephone number or Application ID, depending on `VOICE_CALLBACK_TYPE`
`VOICE_STATUS_URL` | A webhook URL for Nexmo to post Voice API status updates to

```code_snippets
source: '_examples/numbers/update'
```

## See also

* [API reference](/api/numbers)
