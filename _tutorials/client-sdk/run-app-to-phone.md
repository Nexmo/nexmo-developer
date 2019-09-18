---
title: Run your application
description: In this step you learn how to run your app to phone application.
---

# Run your application

> **NOTE:** If you have not already done so, make sure you have [Ngrok running](/client-sdk/tutorials/app-to-phone/prerequisites#how-to-run-ngrok).

Run your web server locally in your project directory with `http-server`, or other command depending on which HTTP server you installed.

After your web server starts, point your browser at `localhost:8080` and `index.html` will automatically be loaded.

A text field and button is displayed on the page.

Enter the number of your mobile phone into the text field in [E.164](concepts/guides/glossary#e-164-format) format (for example, `447700900000`) and then click the `Call` button.

To see the webhook server logging switch to the terminal tab running your server. You can also open up the web browser console and view logging messages there for your web app and the Client SDK.

You will see the application attempting to connect to the target number you provided.

Once the call comes through you can answer it and hear the in-app voice call.
