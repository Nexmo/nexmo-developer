---
title: Add typing indicators
description: In this step you learn how to show when a user is typing
---

# Add Typing Indicators

In order to make the application a bit more polished, you will let your users know when the other parties in the Conversation are typing.

Add the following code to the `setupUserEvents` function. If your application detects the `keypress` on the message text area control, you call the `conversation.startTyping` function to alert your application that the user is currently typing. 

If you detect the `keyup` event on the text area control for longer that half a second, you can assume that the user has stopped typing and call `conversation.stopTyping` to alert your application.

```javascript
function setupUserEvents() {
  ...

  messageTextarea.addEventListener('keypress', (event) => {
    conversation.startTyping()
  })

  messageTextarea.addEventListener('keyup', (event) => {
    clearTimeout(timeout)
    timeout = setTimeout(() => {
      conversation.stopTyping()
    }, 500);
  })
}
```

When your application detects that a user has either started or stopped typing, you can determine which user the event came from. If the user is someone other than the person using your application (who obviously already knows whether they are typing or not), you update their status in the app.

Extend the `showMessages` function with the following code:


```javascript
function setupShowMessages(conv) {
  ...

  conversation.on("text:typing:on", (data) => {
    console.log(data)
    if (data.user.id !== data.conversation.me.user.id) {
      status.innerHTML = data.name + " is typing..."
    }
  });

  conversation.on("text:typing:off", (data) => {
    status.innerHTML = ""
  });
}
```
