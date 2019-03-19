---
title: Send verification code
navigation_weight: 2
---

# Send verification code

When you have collected a user's phone number, start the verification process by sending a [verify request](/api/verify#verify-request) to the Verify API.  

The Verify API returns a `request_id`. Use this to identify a specific verification request in subsequent calls to the API, such as when making a [check request](/verify/code-snippets/check-verify-request) to see if the user provided the correct code.

```code_snippets
source: '_examples/verify/send-verification-request'
```
