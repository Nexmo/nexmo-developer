---
title: Send verification code
navigation_weight: 2
---

# Send verification code

When you have collected a user's phone number, start the verification process by sending a [verify request](/api/verify#verify-request) to the Verify API.

The Verify API returns a `request_id`. Use this to identify a specific verification request in subsequent calls to the API, such as when making a [check request](/verify/code-snippets/check-verify-request) to see if the user provided the correct code.

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`RECIPIENT_NUMBER` | The phone number to verify
`BRAND_NAME` | Included in the message to explain who is confirming the phone number

```code_snippets
source: '_examples/verify/send-verification-request'
```

> **Note**: If you receive the error code 15: `The destination number is not in a supported network`, the target network might have been blocked by the platform's anti-fraud system. See [Velocity Rules](/verify/guides/velocity-rules).
