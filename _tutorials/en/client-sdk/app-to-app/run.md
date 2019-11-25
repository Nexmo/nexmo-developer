---
title: Run your application
description: In this step you learn how to run your app to phone application.
---

# Run your application

> **NOTE:** If you have not already done so, make sure you have [Ngrok running](/client-sdk/tutorials/app-to-app/prerequisites#how-to-run-ngrok).

1. Run your application with `node server.js`.
2. Load [http://localhost:3000/index1](http://localhost:3000/index1) into your browser. This is the calling app.
3. Start a new Icognito tab (if using Google Chrome), or a new browser instance.
4. Load [http://localhost:3000/index2](http://localhost:3000/index2) into this new tab or instance. This is the receiving app.

In the call app tab (index1):

1. Enter the user to call, for example `user2`. The username depends on the usernames you decided to use when you generated your JWTs. For example you may have generated users with User JWT claims of `user1` and `user2`.
2. Click the `Call` button to make the call.

In the receive call tab (index2):

1. Note the status has changed to reflect the incoming call:
2. Click Answer to answer the call.

You can now test the two-way voice call, although you may experience some audio feedback.

> **NOTE:** You may be prompted to allow your web browser access to your microphone and speaker. It is necessary to allow this for testing purposes.
