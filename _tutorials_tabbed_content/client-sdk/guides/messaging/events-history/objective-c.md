---
title: Objective-C
language: objective_c
menu_weight: 2
---

The `getEventsPageWithSize:order:eventType:completionHandler:` method retrieves events that occurred in the context of the conversation via a `NXMEventsPage`:

```objective_c
[self.conversation getEventsPageWithSize:20 order:NXMPageOrderAsc completionHandler:^(NSError * _Nullable error, NXMEventsPage * _Nullable eventsPage) {
    if (error) {
        NSLog(@"Error retrieving events: %@", error);
        return;
    }
    // events found - process them based on their type
    for(id event in eventsPage.events) {
        if ([event isKindOfClass: [NXMMemberEvent class]]) {
            // show Member event
        }
        if ([event isKindOfClass: [NXMTextEvent class]]) {
            // show Text event
        }
    }
    
    if (eventsPage.hasNextPage) {
        [eventsPage nextPage:^(NSError * _Nullable error, NXMEventsPage * _Nullable page) {
            // process next page of events
        }];
    }
    
    if (eventsPage.hasPreviousPage) {
        [eventsPage previousPage:^(NSError * _Nullable error, NXMEventsPage * _Nullable page) {
            // process previous page of events
        }];
    }
}];
```