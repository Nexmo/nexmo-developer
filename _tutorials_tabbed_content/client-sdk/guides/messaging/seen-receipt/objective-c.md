---
title: Objective-C
language: objective_c
menu_weight: 2
---

Have a `ViewController`, or similar, conform to `NXMClientDelegate` and implement `conversation:didReceiveImageEvent:`:

```objective_c
- (void)conversation:(NXMConversation *)conversation didReceive:(NSError *)error {
    NSLog(@"Conversation error: %@", error.localizedDescription);
}
- (void)conversation:(NXMConversation *)conversation didReceiveMessageStatusEvent:(NXMMessageStatusEvent *)event {
    if (event.status == NXMMessageStatusTypeSeen) {
        NSLog(@"Received seen event: %li", (long)event.referenceEventUuid);
    }
}
```