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

const messageTextarea = document.getElementById('messageTextarea');
const messageFeed = document.getElementById('messageFeed');
const sendButton = document.getElementById('send');
const loginForm = document.getElementById('login');
const status = document.getElementById('status');

function authenticate(username) {
  if (username == "USER1_NAME") {
    return USER1_JWT;
  }
  if (username == "USER2_NAME") {
    return USER2_JWT;
  }
  alert("User not recognized");
}
```

You'll also need to add an event listener to the `login` form to fetch the user's JWT and pass it in to the `run` function. The `run` function doesn't do anything yet, but at this point you have a valid user JWT to start building your application.

```javascript
loginForm.addEventListener('submit', (event) => {
  event.preventDefault();
  const userToken = authenticate(document.getElementById('username').value);
  if (userToken) {
    document.getElementById('messages').style.display = 'block';
    document.getElementById('login').style.display = 'none';
    run(userToken);
  }
});

async function run(userToken){

}
```
