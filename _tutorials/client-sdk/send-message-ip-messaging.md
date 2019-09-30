---
title: Send a message
description: In this step you enable your user to send a message
---

# Send a Message

To send a message to other participants in the Conversation, you need to call the `conversation.sendText()` method.

You can do this by adding a handler for the message box's Submit button at the end of the `run` function:

```javascript
// Listen for clicks on the submit button and send the existing text value
sendButton.addEventListener('click', async () => {
  await conversation.sendText(messageTextarea.value);
  messageTextarea.value = '';
});
```
