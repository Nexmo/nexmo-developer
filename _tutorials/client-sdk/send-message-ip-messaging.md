---
title: Send a message
description: In this step you enable your user to send a message
---

# Send a Message

Write the code that enables a user to send a message to other participants in the Conversation. You'll want to log the details of the message to the console for debugging purposes, so first create a reusable function for this purpose:

```javascript
function eventLogger(event) {
  return () => { console.log("'%s' event was sent", event) }
}
```

Then, add a handler for the message box's Submit button in the `setupUserEvents` function:

```javascript
function setupUserEvents() {
  sendButton.addEventListener('click', () => {
    conversation.sendText(messageTextarea.value).then(() => {
      eventLogger('text')()
      messageTextarea.value = ''
    }).catch((error) => {
      console.log(error)
    })
  })
  ...
}
```