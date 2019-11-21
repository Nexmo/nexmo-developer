---
title: Create a webhook server
description: In this step you learn how to create a suitable webhook server that supports an app-to-app call.
---

# Create a webhook server

Nexmo will make a request to your `answer_url` when an in-app voice call is received. You need to create a webhook server that is capable of receiving this request and returning an NCCO containing a `connect` action that will forward the call to the requested user. 

Create a file named `server.js` and add the server code as shown.

``` javascript
TBD
```

The important part of this code is in the `answer` webhook handler:

1. Extraction of the destination user from the answer webhook query parameters.
2. Check that a username is provided. If not play a message and hang up.
3. The dynamically built NCCO then forwards the call to the destination application (user) using a `connect` action.
