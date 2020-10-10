---
title: Try it yourself!
description: Try it yourself!
---


## Try it yourself!

There's a detailed walkthrough of the code sample but for the impatient, let's try the application before we dive in too deeply. You should have your number and application created and linked from the above instructions; now we'll grab and run the code.

Start by cloning the [repository](https://github.com/spiritbro1/nodejs-phone-menu) if you haven't already.

In the project directory, install the dependencies with NPM:

```
npm install
```

> If you're using ngrok, it randomly generates a tunnel URL. It can be helpful to start ngrok before doing the other configuration so that you know what URL your endpoints will be on (paid ngrok users can reserve tunnel names). It might also be useful to know that there is a `nexmo app:update` command if you need update the URLs you set at any time

All set? Then start up the Node.js webserver:

```
node index.js
```

Once it's running, call your Nexmo voice number and follow the instructions! The code receives webhooks to `/event` as the call is started, ringing, etc. When the system answers the call, a webhook comes in to `/answer` and the code responds with some text-to-speech and then waits for user input. The user's input then arrives by webhook to `/search` and again the code responds with some text-to-speech.

Now you've seen it in action, you may be curious to know how the various elements work. Read on for a full walkthrough of our Node.js code and how it manages the flow of the call...
