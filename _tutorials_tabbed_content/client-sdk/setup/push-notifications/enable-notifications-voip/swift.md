---
title: Swift
language: swift
menu_weight: 1
---

```swift
NXMClient.shared.enablePushNotifications(withPushKitToken: pushKitToken, 
        userNotificationToken: deviceToken, isSandbox: true) { (error) in
    // code
}
```
