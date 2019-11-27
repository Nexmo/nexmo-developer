---
title: Get past events
description: In this step you learn how to get past events.
---

# Get past events

Events Controller syncs events forward. Loading past events is done on demand:

```objective-c
[eventsController loadEarlierEventsWithMaxAmount:AMOUNT_OF_EVENTS_TO_LOAD_MORE completion:^(NSError * _Nullable error) {
        if (error) {
            //error loading more events
            return;
        }

        //more events loaded, update
    }];
```

Note that completion is not guaranteed to be invoked on the main thread, so beware of directly calling UI methods here.

Also note that `AMOUNT_OF_EVENTS_TO_LOAD_MORE` is the maximum number of events to load. Filtered or deleted events will reduce the number of events loaded.
