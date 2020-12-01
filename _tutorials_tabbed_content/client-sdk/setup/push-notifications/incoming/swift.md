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
    if NXMClient.shared.isNexmoPush(userInfo: userInfo) {
        guard let pushPayload = NXMClient.shared.processNexmoPushPayload(userInfo) else {
            NSLog("Not a Nexmo push notification")
            return
        }
        if pushPayload.template == NXMPushTemplate.custom {
            // Got custom push
            NSLog("Received custom push notification \(String(describing: pushPayload.customData))")
        }
    }
}
```
