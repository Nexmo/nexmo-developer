---
title: Try it yourself!
description: Try it yourself!
---
## Try it yourself!

There's a detailed walkthrough of the code sample but for the impatient, let's try the application before we dive in too deeply. You should have your number and application created and linked from the above instructions; now we'll grab and run the code.

Start by cloning the [repository](https://github.com/spiritbro1/nodejs-phone-menu) if you haven't already.

In the project directory, run vercel command to login to your vercel account:

```
vercel login
```

> If you're using vercel, it will generate a URL. You can also set your own domain at vercel. It might also be useful to know that there is a `nexmo app:update` command if you need update the URLs you set at any time

All set? Then deploy the serverless function to vercel:

```
vercel .
```

Once it's running, call your Nexmo voice number and follow the instructions! Call events such as `started`, `ringing`, `completed` and so on are sent as requests to your `/event` webhook. When the system answers the call, a request is sent to your `/answer` webhook and the code responds with some text-to-speech and then waits for user input. The dial tone that the user entered is sent as a request  to your `/search` webhook and again the code responds with some text-to-speech.

Now you've seen it in action, you may be curious to know how the various elements work. Read on for a full walkthrough of our node.js code and how it manages the flow of the call...
