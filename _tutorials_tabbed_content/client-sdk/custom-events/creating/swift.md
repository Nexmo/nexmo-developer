---
title: Swift
language: swift
menu_weight: 1
---


Once you've installed the iOS Client SDK and [have a `conversation` object](/client-sdk/tutorials/ios-in-app-messaging-chat/client-sdk/ios-in-app-messaging-chat/fetch-conversation/swift), you can call `sendCustom(withEvent: data: completionHandler:)` to add a custom event to the conversation.

```swift
conversation.sendCustom(withEvent: "my_custom_event", data: ["your": "data"], completionHandler: { (error) in
    if let error = error {
        NSLog("Error sending custom event: \(error.localizedDescription)")
        return
    }
    NSLog("Custom event sent.")
})
```
