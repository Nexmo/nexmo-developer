---
title: Run your application
description: In this step you learn how to run your phone to app application.
---

# Run your application

> **NOTE:** If you have not already done so, make sure you have [Ngrok running](/client-sdk/tutorials/app-to-phone/prerequisites#how-to-run-ngrok).

Run your web server locally in your project directory with `http-server`, or other command depending on which HTTP server you installed.

Your application `index.html` is automatically loaded when the web server starts.

You will see a simple status console and a button that is clicked to answer an inbound call displayed.

> **NOTE:** It is worth activating the JavaScript console in your browser at this point if you have not already done so.

From your PSTN phone you can now call the Nexmo number associated with your Client SDK application.

You will hear a message saying to wait while you are connected through to an agent.

In your web app you will see the call status updated. Click the `Answer` button to answer the inbound call. A conversation can now take place between the web app (agent) and the inbound caller.

On the handset hangup the call. You again see the call status updated.
