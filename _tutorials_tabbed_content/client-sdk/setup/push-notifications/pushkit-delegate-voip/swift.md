---
title: Swift
language: swift
menu_weight: 1
---

```swift
func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith 
        payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
    if(NXMClient.shared.isNexmoPush(userInfo: payload.dictionaryPayload)) {
        guard let pushPayload = NXMClient.shared.processNexmoPushPayload(payload.dictionaryPayload) else {
            NSLog("Not a Nexmo push notification")
            return
        }
    }
}
```
