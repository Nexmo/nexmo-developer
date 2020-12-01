---
title: Send verification code with workflow
navigation_weight: 2
---

# Send verification code with workflow

When you have collected a user's phone number, start the verification process by sending a [verify request](/api/verify#verify-request) to the Verify API. This example includes use of a specific [workflow](/verify/guides/workflows-and-events) for the request.

The Verify API returns a `request_id`. Use this to identify a specific verification request in subsequent calls to the API, such as when making a [check request](/verify/code-snippets/check-verify-request) to see if the user provided the correct code.

Replace the following variables in the sample code with your own values:

```snippet_variables
- VONAGE_API_KEY
- VONAGE_API_SECRET
- RECIPIENT_NUMBER.VERIFY
- BRAND_NAME.VERIFY
- WORKFLOW_ID.VERIFY
```

```code_snippets
source: '_examples/verify/send-verification-request-with-workflow'
```

> **Note**: If you receive the error code 15: `The destination number is not in a supported network`, the target network might have been blocked by the platform's anti-fraud system. See [Velocity Rules](/verify/guides/velocity-rules).