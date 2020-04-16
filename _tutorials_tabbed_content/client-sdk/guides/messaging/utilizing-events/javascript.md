---
title: Javascript
language: javascript
menu_weight: 1
---

The `getEvents` method retrieves all the events that occurred in the context of the conversation. It returns a subset or "page" of events with each invocation - the number of events it returns is based on the `page_size` parameter (the default is 10 results, the maximum is 100).

> **Note**: See the [documentation](/sdk/stitch/javascript/EventsPage.html) for helper methods you can use to work with this paginated data.

```javascript
conversation
  .getEvents({ page_size: 20 })
  .then((events_page) => {
    events_page.items.forEach((value, key) => {
      if (conversation.members.get(value.from)) {
        const date = new Date(Date.parse(value.timestamp))
        
        switch (value.type) {

          case 'member:joined':
            console.log(`${conversation.members.get(value.from).user.name} @ ${date}: joined the conversation`);
            break;
          case 'member:left':
            console.log(`${conversation.members.get(value.from).user.name} @ ${date}: left the conversation`);
            break;
          case 'member:invited':
            console.log(`${conversation.members.get(value.from).user.name} @ ${date}: invited to the conversation`);
            break;

          case 'text:seen':
            console.log(`${conversation.members.get(value.from).user.name} saw text at @ ${date} : ${value.body.text}`))
            break;
          case 'text:delivered':
            console.log(`Text from ${conversation.members.get(value.from).user.name} delivered at @ ${date} : ${value.body.text}`))
            break;
          case 'text':
            console.log(`${conversation.members.get(value.from).user.name} @ ${date}: ${value.body.text}`);
            break;

          case 'text:typing:on':
            console.log(`${conversation.members.get(value.from).user.name} starting typing @ ${date}`);
            break;
          case 'text:typing:off':
            console.log(`${conversation.members.get(value.from).user.name} stopped typing @ ${date}`);
            break;

          default:
            console.log(`${conversation.members.get(value.from).user.name} @ ${date}: unknown event`);
        }
      }
    })

  })
  .catch(this.errorLogger)

```
