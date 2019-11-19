---
title: Swift
language: swift
menu_weight: 1
---

```swift
func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, 
        for type: PKPushType, completion: @escaping () -> Void) {
    if(client.isNexmoPush(userInfo: payload.dictionaryPayload)) {
        client.processNexmoPush(userInfo: payload.dictionaryPayload) { (error: Error?) in
            //Code
        }
    }
}
```
