---
title: Objective-c
language: objective_c
---

```objective_c
if (eventsPage.hasPreviousPage) {
    [eventsPage previousPage:^(NSError * _Nullable error, NXMEventsPage * _Nullable page) {
        // handle page events
    }];
}
```
