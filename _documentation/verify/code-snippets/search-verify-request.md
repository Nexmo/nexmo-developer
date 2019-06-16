---
title: Search for Verify request
navigation_weight: 2
---

# Search for a Verify Request

You can use the search functionality to see the current status or eventual outcome of a Verify request, using the `request_id` returned when the verify code was sent.

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`REQUEST_ID` | The ID of the Verify request you wish to cancel (this is returned in the API response when you [send a verification code](/verify/code-snippets/send-verify-request))


```code_snippets
source: '_examples/verify/search-verification-request'
```
