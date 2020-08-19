---
title: JavaScript
language: javascript
---

```javascript
function listEvents(events_page){
      events_page.items.forEach(event => {
        renderEvent(event);
      })
}

conversation.getEvents({ event_type: 'member:*', page_size: 100, order: 'asc' })
    .then((events_page) => {
        listEvents(events_page);
    })
    .catch((error) =>{
        console.log('Error: Unable to load conversation events ',error);
    });
```
