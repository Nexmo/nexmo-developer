---
title: Objective-C
language: objective_c
---

```objective_c
[self.conversation getEventsPageWithSize:10 order:NXMPageOrderAsc
 completionHandler:^(NSError * _Nullable error, NXMEventsPage * _Nullable events) {

    self.events = [NSMutableArray arrayWithArray:events.events];

}];
```
