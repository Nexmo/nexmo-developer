---
title: Link phone numbers to the Nexmo Application
description: Link phone numbers to the Nexmo Application using nexmo cli
---

## Link phone numbers to the Nexmo Application

Next you will link each phone number with the *phone-menu* application you just created. When any event occurs relating to a number associated with an application, Nexmo sends a web request to your webhook endpoints with information about the event. To do this, use the `link:app` command in the Nexmo CLI:

```bash
nexmo link:app 441632960960 5555f9df-05bb-4a99-9427-6e43c83849b8
```

The parameters are the phone number you want to use and the UUID returned when you [created a voice application](/voice/voice-api/tutorials/ivr-node/voice-api/ivr-node/create-a-voice-application/) earlier.
