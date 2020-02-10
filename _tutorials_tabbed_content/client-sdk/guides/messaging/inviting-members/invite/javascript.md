---
title: Javascript
language: javascript
menu_weight: 1
---

```javascript
conversation.invite({ user_name: "Jane" }).then((member) => {
  console.log(member.state + " user: " + member.user.id + " " + member.user.name);
}).catch((error) => {
  console.log(error);
});
```
