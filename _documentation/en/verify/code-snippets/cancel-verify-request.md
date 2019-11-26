---
title: Cancel verification request
navigation_weight: 4
---

# Cancel verification request

If the user decides to cancel the verification process, you should send a [control request](/api/verify#verify-control) to the Verify API. This will terminate the verification process even if the user supplied the correct code.

> **Note**: The intended behavior for cancelling a Verify request is after 30 seconds, but before any second attempt is made.

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`REQUEST_ID` | The ID of the Verify request you wish to cancel (this is returned in the API response when you [send a verification code](/verify/code-snippets/send-verify-request))

```code_snippets
source: '_examples/verify/cancel-verification-request'
```
