---
title: Javascript
language: javascript
menu_weight: 1
---

```javascript
conversation.invite({ user_name: "Jane" }).then((member) => {
  console.log(member.state + " user: " + user_id + " " + user_name);
  }).catch((error) => {
  console.log(error);
  });
```
