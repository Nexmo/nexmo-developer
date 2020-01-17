---
title: JavaScript
language: javascript
menu_weight: 1
---

To receive an incoming in-app call, you should listen to incoming call events:

```javascript
application.on("member:call", (member, call) => {
    ...
});
```

The listener method receives a `member` object that contains information about the caller and a `call` object, that lets you interact with the call in progress. With the later, you’ll be able to perform methods such as answer, reject and hang up.

