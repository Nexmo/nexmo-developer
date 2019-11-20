---
title: Run your application
description: In this step you learn how to run your phone to app application.
---

# Run your application

> **NOTE:** If you have not already done so, make sure you have [Ngrok running](/client-sdk/tutorials/app-to-phone/prerequisites#how-to-run-ngrok).

Run your application with `node server.js`, then visit [http://localhost:3000](http://localhost:3000)

The call’s current status and an Answer button are displayed on the page.

> **NOTE:** It is a good idea to start the Developer console in your browser at this point if you have not already done so.

From your PSTN phone, you can now call the Nexmo number associated with your Client SDK application.

You will hear a message saying to wait while you are connected through to an agent.

In your web app, you will see the call status updated. Click the `Answer` button to answer the inbound call.

A conversation can now take place between the web app (agent) and the inbound caller.

Hang up when you're done and the call status will be updated again.
