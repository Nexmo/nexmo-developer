---
title: Run your application
description: Try it out!
---

# Run Your Application

You need to run your application in a web server. If you don't already have one, you can install the Node.js `http-server` module:

```bash
npm install http-server -g
```

The following command starts the server on port 3000:

```bash
http-server -p 3000
```

Then, visit `http://localhost:3000` in two browser tabs. You might want to position these side-by-side so that you can see both users' view of the chat simultaneously.

First, log in to the application in both browser tabs, using `user1` and `user2` respectively.

Then, start sending messages from one user to the other. Messages received from the other user should appear in red, the messages you send should appear in black. Test that the typing indicators appear in one tab when you start typing in the other.