---
title: Objective-C
language: objective_c
menu_weight: 2
---


Right below  `getConversation`, let's add a method to retrieve the events:

```objective-c
- (void)getEvents {
    [self.conversation getEvents:^(NSError * _Nullable error, NSArray<NXMEvent *> * _Nullable events) {
        self.error = error;
        self.events = [events mutableCopy];
        [self updateInterface];
    }];
}
```

Once the events are retrieved (or an error is returned), we're updating the interface to reflect the new data.

Inside `updateInterface` locate the `// events found - show them based on their type` line - this is where we're going to list our conversation history:

```objective-c
// events found - show them based on their type
for(id event in self.events) {
    if ([event isKindOfClass: [NXMMemberEvent class]]) {
        [self showMemberEvent:event];
    }
    if ([event isKindOfClass: [NXMTextEvent class]]) {
        [self showTextEvent:event];
    }
}
```

We're only show text and member related events (member invited, joined or left) for now.

Locate the line `//MARK: Show events` and let's add the `showMemberEvent:` and `showTextEvent:` methods:

```objective-c
//MARK: Show events

- (void)showMemberEvent:(NXMMemberEvent *)event {
    switch (event.state) {
        case NXMMemberStateInvited:
            [self addConversationLine:[NSString stringWithFormat:@"%@ was invited.", event.member.user.name]];
            break;
        case NXMMemberStateJoined:
            [self addConversationLine:[NSString stringWithFormat:@"%@ joined.", event.member.user.name]];
            break;
        case NXMMemberStateLeft:
            [self addConversationLine:[NSString stringWithFormat:@"%@ left.", event.member.user.name]];
            break;
    }
}

- (void)showTextEvent:(NXMTextEvent *)event {
    if (event.text.length > 0) {
        [self addConversationLine:[NSString stringWithFormat:@"%@ said: %@", event.fromMember.user.name, event.text]];
    }
}

- (void)addConversationLine:(NSString *)line {
    if (self.conversationTextView.text.length > 0) {
        self.conversationTextView.text = [NSString stringWithFormat:@"%@\n%@", self.conversationTextView.text, line];
    } else {
        self.conversationTextView.text = line;
    }
}
```
