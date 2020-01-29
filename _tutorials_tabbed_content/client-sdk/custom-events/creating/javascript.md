---
title: Javascript
language: javascript
menu_weight: 1
---

Once you've installed the JavaScript Client SDK and [have a `conversation` object](/client-sdk/tutorials/in-app-messaging/client-sdk/ip-messaging/join-conversation), you can call `sendCustomEvent` to add a custom event to the conversation.

```javascript
conversation.sendCustomEvent({ type: 'my_custom_event', body: { your: 'data' }}).then((custom_event) => {
  console.log(custom_event);
});
```
