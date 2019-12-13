---
title: Check verification code
navigation_weight: 3
---

# Check verification code

Check the verification code that a user has provided. Use the `request_id` that was received when the [verification code was sent](/verify/code-snippets/send-verify-request).

> **Note**: You should always [check the verification code](/verify/code-snippets/check-verify-request) after [sending it](/verify/code-snippets/send-verify-request). This enables Vonage to determine the number of successful requests and [protect against fraudulent use](/verify/guides/velocity-rules) of the platform

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`REQUEST_ID` | The ID of the Verify request you wish to cancel (this is returned in the API response when you [send a verification code](/verify/code-snippets/send-verify-request))
`CODE` | The code the user supplies as having been sent to them

```code_snippets
source: '_examples/verify/check-verification-request'
```
