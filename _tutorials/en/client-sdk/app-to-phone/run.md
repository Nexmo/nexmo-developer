---
title: Run your application
description: In this step you learn how to run your app to phone application.
---

# Run your application

> **NOTE:** If you have not already done so, make sure you have [Ngrok running](/client-sdk/tutorials/app-to-phone/prerequisites#how-to-run-ngrok).

Run your application with `node server.js`, then visit [http://localhost:3000](http://localhost:3000)

A text field and button is displayed on the page.

Enter the number of your mobile phone into the text field in [E.164](/concepts/guides/glossary#e-164-format) format (for example, `447700900000`) and then click the `Call` button.

To see the webhook server’s log messages, switch to the terminal tab running your server.

You can also open up the web browser console and view logging messages there for your web app and the Client SDK. You will see the application attempting to connect to the target number you provided.

Once the call comes through you can answer it and hear the in-app voice call.
