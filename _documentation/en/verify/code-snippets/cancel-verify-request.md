---
title: Cancel verification request
navigation_weight: 4
---

# Cancel verification request

If the user decides to cancel the verification process, you should send a [control request](/api/verify#verify-control) to the Verify API. This will terminate the verification process even if the user supplied the correct code.

> **Note**: You can only cancel a [verification request](/verify/code-snippets/send-verify-request) after 30 seconds, but before any second attempt is made.

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`VONAGE_API_KEY` | Your Vonage [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`VONAGE_API_SECRET` | Your Vonage [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`REQUEST_ID` | The ID of the Verify request you wish to cancel (this is returned in the API response when you [send a verification code](/verify/code-snippets/send-verify-request))

```code_snippets
source: '_examples/verify/cancel-verification-request'
```
