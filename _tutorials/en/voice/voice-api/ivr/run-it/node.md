---
title: Run it!
description: Test your application
---

# Run it!

Before proceeding, ensure that:

1. You have created a Vonage Application (see the [prerequisites](voice/voice-api/tutorials/ivr/prerequisites/))
2. You have purchased a Vonage number and linked it to your Vonage Application (see the [prerequisites](voice/voice-api/tutorials/ivr/prerequisites/))
3. You have installed and run Ngrok and made a note of the temporary tunnel URLs it generated for you (see the [prerequisites](voice/voice-api/tutorials/ivr/prerequisites/))
4. You have updated your Vonage Application with the URLs to your webhooks (as described in the [preceding step](/voice/voice-api/tutorials/ivr/voice/voice-api/ivr/configure-application/node))

To test your application:

1. Run `node index.js`
2. Call your Vonage number
3. Listen to the menu that is read to you
4. Make your selection and ensure that the response corresponds to your chosen option
5. Examine the console output to see the call progress events
