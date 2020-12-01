---
title: Check verification code
navigation_weight: 3
---

# Check verification code

Check the verification code that a user has provided. Use the `request_id` that was received when the [verification code was sent](/verify/code-snippets/send-verify-request).

> **Note**: You should always [check the verification code](/verify/code-snippets/check-verify-request) after [sending it](/verify/code-snippets/send-verify-request). This enables Vonage to determine the number of successful requests and [protect against fraudulent use](/verify/guides/velocity-rules) of the platform

Replace the following variables in the sample code with your own values:

```snippet_variables
- VONAGE_API_KEY
- VONAGE_API_SECRET
- REQUEST_ID.VERIFY
- CODE.VERIFY
```

```code_snippets
source: '_examples/verify/check-verification-request'
```
