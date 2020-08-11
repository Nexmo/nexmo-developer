---
title: Objective-C
language: objective_c
menu_weight: 2
---

The `getEventsPageWithSize:order:completionHandler:` method on `NXMConversation` retrieves all the events that occurred in the context of the conversation. It returns a subset or _page_ of events with each invocation - the number of events it returns is based on the page_size parameter (the default is 10 results, the maximum is 100).

Below is an example of using the function to retrieve member and text events followed by using the conversation to send a text event. You can find out more about the supported event types in the [Conversation API documentation](/conversation/concepts/event).

```objective_c
[self.conversation getEventsPageWithSize:20 order:NXMPageOrderAsc completionHandler:^(NSError * _Nullable error, NXMEventsPage * _Nullable eventsPage) {
    if (error) {
        NSLog(@"Error retrieving events: %@", error);
        return;
    }
    
    // events found - process them based on their type
    for(id event in eventsPage.events) {
        if ([event isKindOfClass: [NXMMemberEvent class]]) {
            [self showMemberEvent:(NXMMemberEvent *)event];
        }
        if ([event isKindOfClass: [NXMTextEvent class]]) {
            [self showTextEvent:(NXMTextEvent *)event];
        }
    }
}];

- (void)showMemberEvent:(NXMMemberEvent *)event {
    switch (event.state) {
        case NXMMemberStateInvited:
            NSLog(@"%@", [NSString stringWithFormat:@"%@ was invited", event.member.user.name]);
            break;
        case NXMMemberStateJoined:
            NSLog(@"%@", [NSString stringWithFormat:@"%@ joined", event.member.user.name]);
            break;
        case NXMMemberStateLeft:
            NSLog(@"%@", [NSString stringWithFormat:@"%@ left", event.member.user.name]);
            break;
    }
}

- (void)showTextEvent:(NXMTextEvent *)event {
    NSString *message = [NSString stringWithFormat:@"%@ said %@", event.fromMember.user.name, event.text];
    NSLog(@"%@", message);
}
```

```objective_c
[self.conversation sendText:message completionHandler:^(NSError * _Nullable error) {
    if (error) {
        NSLog(@"%@", error);
    }
}];
```