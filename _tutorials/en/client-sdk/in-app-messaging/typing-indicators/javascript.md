---
title: Add typing indicators
description: In this step you learn how to show when a user is typing
---

# Add Typing Indicators

In order to make the application a bit more polished, you will let your users know when the other parties in the Conversation are typing.

Add the following code to the end of the `run` function. If your application detects the `keypress` event on the message text area, call the `conversation.startTyping` function to alert your application that the user is currently typing. 

If you detect the `keyup` event on the text area for longer that half a second, you can assume that the user has stopped typing and call `conversation.stopTyping` to alert your application.

```javascript
messageTextarea.addEventListener('keypress', (event) => {
  conversation.startTyping();
});

var timeout = null;
messageTextarea.addEventListener('keyup', (event) => {
  clearTimeout(timeout);
  timeout = setTimeout(() => {
    conversation.stopTyping();
  }, 500);
});
```

When your application detects that a user has either started or stopped typing, you can determine which user the event came from. If the user is someone other than the person using your application, you update their status in the app.

Add the following to the bottom of your `run` function:

```javascript
conversation.on("text:typing:on", (data) => {
  if (data.user.id !== data.conversation.me.user.id) {
    status.innerHTML = data.user.name + " is typing...";
  }
});

conversation.on("text:typing:off", (data) => {
  status.innerHTML = "";
});
```
