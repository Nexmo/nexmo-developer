---
title: Trigger next verification process
navigation_weight: 5
---

# Trigger next verification process

The Verify API starts the verification process by sending an SMS to the user. If the user does not confirm the code that they received within a [certain time period](/verify/guides/verification-stages), the Verify API sends a second SMS. If that does not elicit a response it attempts a Text-to-Speech (TTS) call.

You can advance to the next verification attempt programmatically by making a [control request](/api/verify#verify-control). You would normally do this if your user indicates that they prefer to verify via a phone call instead of by SMS.

```code_snippets
source: '_examples/verify/trigger-next-verification-process'
```
