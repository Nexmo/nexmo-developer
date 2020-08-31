---
title: Objective-C
language: objective_c
---

```objective_c
if (eventsPage.hasNextPage) {
    [eventsPage nextPage:^(NSError * _Nullable error, NXMEventsPage * _Nullable page) {
        // handle page events
    }];
}
```
