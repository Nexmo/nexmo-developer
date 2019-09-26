---
title: Authenticate your users
description: In this step you authenticate your users via the JWTs you created earlier
---

# Authenticate Your Users

Your users must be authenticated to be able to participate in the Conversation. You perform this authentication using the Conversation ID and the JWTs you generated in a previous step.

Declare the following variables at the top of your `chat.js` file and populate `USER1_JWT`, `USER2_JWT` and `CONVERSATION_ID` with your own values:

```javascript
const USER1_JWT = '';
const USER2_JWT = '';
const CONVERSATION_ID = '';

let conversation = null;
let timeout = null;
const messageTextarea = document.getElementById('messageTextarea');
const messageFeed = document.getElementById('messageFeed');
const sendButton = document.getElementById('send');
const loginForm = document.getElementById('login');
const status = document.getElementById('status');

function authenticate(username) {
  if (username == "user1") {
    return USER1_JWT;
  }
  if (username == "user2") {
    return USER2_JWT;
  }
  alert("User not recognized");
}
```
