---
title: Objective-C
language: objective_c
menu_weight: 2
---

Have a `ViewController`, or similar, conform to `NXMConversationDelegate` and implement `conversation:didReceiveTypingEvent:`:

> Note: The first method below is required when implementing `NXMConversationDelegate`:

```objective_c
- (void)conversation:(NXMConversation *)conversation didReceive:(NSError *)error {
    NSLog(@"Conversation error: %@", error.localizedDescription);
}
- (void)conversation:(NXMConversation *)conversation didReceiveTypingEvent:(NXMTextTypingEvent *)event {
    if (event.status == NXMTextTypingEventStatusOn) {
        NSLog(@"Started typing");
    } else {
        NSLog(@"Typing ended");
    }
}
```