---
title: Run your application
description: In this step you see how to run your app to phone application.
---

# Run your application

> **NOTE:** If you have not already done so, make sure you have Ngrok running.

Run your web server locally in your project directory with `http-server`, or other command depending on which HTTP server you installed.

Your application `index.html` is automatically loaded when the web server starts. A text field and button is displayed on the page.

Enter the number of your mobile phone into the text field in E.164 format (for example, `447700900000`) and then click the `Call` button.

To see the webhook server logging switch to the terminal tab running your server. You can also open up the web browser console and view logging messages there for your web app and the Client SDK.

You will see the application attempting to connect to the target number you provided.

Once the call comes through you can answer it and hear the in-app voice call.
