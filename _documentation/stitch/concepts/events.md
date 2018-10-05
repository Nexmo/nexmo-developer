---
title: Events
description: Introduction to the concept of Events in Stitch.
navigation_weight: 7
---

# Events

Stitch is event driven. When key activities occur an event is
generated, which can be handled by the application. For example when
a User joins a Conversation a `member:joined` event is fired. Other
events include `member:left`, and `member:invited`.

The following code sniipet shows that code can be executed based on the event fired:

``` javascript
...
    events.forEach((value, key) => {
        if (conversation.members[value.from]) {
            const date = new Date(Date.parse(value.timestamp))
            switch (value.type) {
                case 'text:seen':
                    ...
                    break;
                case 'text:delivered':
                    ...
                    break;
                case 'text':
                    ...
                    break;
                case 'member:joined':
                    ...
                    break;
                case 'member:left':
                    ...
                    break;
                case 'member:invited':
                    ...
                    break;
                case 'member:media':
                    ...
                    break;
                default:
                ...
            }
        }
    })
...
```
