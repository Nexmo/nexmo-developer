---
title: Objective-C
language: objective_c
menu_weight: 2
---

Have a `ViewController`, or similar, conform to `NXMClientDelegate` and implement `conversation:didReceiveTextEvent:`:

```objective_c
- (void)conversation:(NXMConversation *)conversation didReceive:(NSError *)error {
    NSLog(@"Conversation error: %@", error.localizedDescription);
}
- (void)conversation:(NXMConversation *)conversation didReceiveTextEvent:(NXMTextEvent *)event {
    NSLog(@"Received text event: %@", event.text);
}
```
