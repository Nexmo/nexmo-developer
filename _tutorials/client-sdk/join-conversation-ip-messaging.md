---
title: Join the conversation
description: In this step you join your Users to your Conversation
---

# Join the Conversation

Having written the code to authenticate your users you can now add them to the Conversation as members.

Create a function called `setupUserEvents`. This function will initially respond to the user clicking the login button by attempting to authenticate the user. You will extend it in a later step to add an event handler for when your user sends a message.

```javascript

setupUserEvents()

function setupUserEvents() {

  loginForm.addEventListener('submit', (event) => {
    event.preventDefault()
    const userToken = authenticate(document.getElementById('username').value)
    if (userToken) {
      document.getElementById('messages').style.display = 'block'
      document.getElementById('login').style.display = 'none'
      joinConversation(userToken)
    }
  })
}

function joinConversation(userToken) {
  new NexmoClient({
    debug: false
  })
    .login(userToken)
    .then(app => {
      return app.getConversation(CONVERSATION_ID)
    })
    .then(setupShowMessages.bind(this))
}
```

