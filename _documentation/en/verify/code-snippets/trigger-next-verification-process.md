---
title: Trigger next verification process
navigation_weight: 5
---

# Trigger next verification process

The Verify API starts the verification process by sending an SMS to the user. If the user does not confirm the code that they received within a [certain time period](/verify/guides/verification-events), the Verify API sends a second SMS. If that does not elicit a response it attempts a Text-to-Speech (TTS) call.

You can advance to the next verification attempt programmatically by making a [control request](/api/verify#verify-control). You would normally do this if your user indicates that they prefer to verify via a phone call instead of by SMS. An alternative approach in this situation is to use an appropriate [workflow](/verify/guides/workflows-and-events) for the user's preference.

Replace the following variables in the sample code with your own values:

Name | Description
--|--
`NEXMO_API_KEY` | Your Nexmo [API key](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`NEXMO_API_SECRET` | Your Nexmo [API secret](https://developer.nexmo.com/concepts/guides/authentication#api-key-and-secret)
`REQUEST_ID` | The ID of the Verify request you wish to cancel (this is returned in the API response when you [send a verification code](/verify/code-snippets/send-verify-request))

```code_snippets
source: '_examples/verify/trigger-next-verification-process'
```
