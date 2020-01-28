---
title: Javascript
language: javascript
menu_weight: 1
---

Achieved by adding a listener on the `application` object for the `member:invited` event:

```javascript
app.on("member:invited", (member, event) => {
  //identify the sender and type of conversation.
  if (event.body.cname.indexOf("CALL") != 0 && member.invited_by) {
    console.log("*** Invitation received:", event);

    //accept an invitation.
    app.getConversation(event.cid || event.body.cname)
      .then((conversation) => {
        conversation
          .join()
          .then(() => {
            ...
          })
          .catch(this.errorLogger)
      })
      .catch(this.errorLogger)
  }
})
```
