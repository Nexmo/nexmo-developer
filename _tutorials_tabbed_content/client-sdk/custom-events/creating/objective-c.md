---
title: Objective-C
language: objective_c
menu_weight: 2
---

Once you've installed the iOS Client SDK and [have a `conversation` object](/client-sdk/tutorials/ios-in-app-messaging-chat/client-sdk/ios-in-app-messaging-chat/fetch-conversation/swift), you can call `sendCustomWithEvent:data:completionHandler:` to add a custom event to the conversation.

```objective_c
[conversation sendCustomWithEvent:@"my_custom_event" data:@{@"your": @"data"} completionHandler:^(NSError * _Nullable error) {
    if (error) {
        NSLog(@"Error sending custom event: %@", error);
        return;
    }
    NSLog(@"Custom event sent.");
}];
```