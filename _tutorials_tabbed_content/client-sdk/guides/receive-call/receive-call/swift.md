---
title: Swift
language: swift
menu_weight: 2
---

Add `NXMClientDelegate` as an extension to a `ViewController` or similar: 

```swift
extension ViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        // handle connection status changed - eg: logout
        ...
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        print("connection error: \(error.localizedDescription)")
        // handle client connection failure
        ...
    }
    
    func client(_ client: NXMClient, didReceive call: NXMCall) {
        print("Incoming Call: \(call)")
        // handle incoming call
        ...
    }

}
```
