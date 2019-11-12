---
title: Swift
language: swift
menu_weight: 1
---

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    if(client.isNexmoPush(userInfo: userInfo)) {
        client.processNexmoPush(userInfo: userInfo) { (error: Error?) in
            //Code
        }
    }
}
```
