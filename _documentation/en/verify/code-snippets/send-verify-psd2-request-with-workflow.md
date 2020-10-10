---
title: Send payment auth code with workflow (PSD2)
navigation_weight: 3
---

# Send payment authentication code with workflow

Verify API supports Strong Customer Authentication for payments. To begin the process, supply the customer's telephone number (in [E.164 format](https://en.wikipedia.org/wiki/E.164) ), the payee that will receive the payment, and the amount (in Euro) of the transaction, to the [PSD2 endpoint](/api/verify#verifyRequestWithPSD2).

The Verify API returns a `request_id`. Use this to identify a specific verification request in subsequent calls to the API, such as when making a [check request](/verify/code-snippets/check-verify-request) to see if the user provided the correct code.

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`VONAGE_API_KEY` | Your Vonage [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`VONAGE_API_SECRET` | Your Vonage [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`RECIPIENT_NUMBER` | The phone number to verify
`PAYEE` | Included in the message to describe the payment recipient
`AMOUNT` | How much the payment is for (always in Euro)
`WORKFLOW_ID` | Choose a workflow (number between 1 and 7), these are defined in the [workflows guide](/verify/guides/workflows-and-events)

```code_snippets
source: '_examples/verify/send-psd2-verification-request-with-workflow'
```

