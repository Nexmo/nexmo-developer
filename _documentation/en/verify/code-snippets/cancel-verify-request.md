---
title: Cancel verification request
navigation_weight: 4
---

# Cancel verification request

If the user decides to cancel the verification process, you should send a [control request](/api/verify#verify-control) to the Verify API. This will terminate the verification process even if the user supplied the correct code.

> **Note**: You can only cancel a [verification request](/verify/code-snippets/send-verify-request) after 30 seconds, but before any second attempt is made.

Replace the following variables in the sample code with your own values:

```snippet_variables
- VONAGE_API_KEY
- VONAGE_API_SECRET
- REQUEST_ID.VERIFY
```

```code_snippets
source: '_examples/verify/cancel-verification-request'
```
