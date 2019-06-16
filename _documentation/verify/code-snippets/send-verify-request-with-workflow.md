---
title: Send verification code with workflow
navigation_weight: 2
---

# Send verification code with workflow

When you have collected a user's phone number, start the verification process by sending a [verify request](/api/verify#verify-request) to the Verify API. This example includes use of a specific [workflow](/verify/guides/workflows-and-events) for the request.

The Verify API returns a `request_id`. Use this to identify a specific verification request in subsequent calls to the API, such as when making a [check request](/verify/code-snippets/check-verify-request) to see if the user provided the correct code.

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`RECIPIENT_NUMBER` | The phone number to verify
`WORKFLOW_ID` | Choose a workflow (number between 1 and 5), these are defined in the [workflows guide](/verify/guides/workflows-and-events)

```code_snippets
source: '_examples/verify/send-verification-request-with-workflow'
```
