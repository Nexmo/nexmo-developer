---
title: Javascript
language: javascript
menu_weight: 1
---

```javascript
conversation.on('text:typing:on', (data) => {
  console.log(data.name + " is typing");
});

conversation.on("text:typing:off", (data) => {
  console.log(data.name + " stopped typing");
});
```
