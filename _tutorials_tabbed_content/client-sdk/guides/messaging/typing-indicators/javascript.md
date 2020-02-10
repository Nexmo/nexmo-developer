---
title: Javascript
language: javascript
menu_weight: 1
---

```javascript
conversation.on('text:typing:on', (event) => {
  console.log(event.user.name + " is typing");
});

conversation.on("text:typing:off", (event) => {
  console.log(event.user.name + " stopped typing");
});
```
