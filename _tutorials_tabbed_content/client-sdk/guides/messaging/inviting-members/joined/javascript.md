---
title: Javascript
language: javascript
menu_weight: 1
---

Listen for the `member:joined` event on the conversation:

```javascript
conversation.on("member:joined", (member, event) => {
  const date = new Date(Date.parse(event.timestamp))
  console.log(`*** ${member.user.name} joined the conversation`)
  ...
})
```
