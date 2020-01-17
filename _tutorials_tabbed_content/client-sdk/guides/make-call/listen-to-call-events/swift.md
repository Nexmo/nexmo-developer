---
title: Swift
language: swift
menu_weight: 1
---

Add the current `ViewController`, or similar, as a delegate for the `call` object returned when making a call:

```swift
call.setDelegate(self)
call.answer { [weak self] error in
    ...
}
```

`ViewController` will now have to conform to `NXMCallDelegate`: 

```swift
extension ViewController: NXMCallDelegate {

    func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, with status: NXMCallMemberStatus) {
        // handle call status updates
        ...
    }
    
    func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, isMuted muted: Bool) {
        // handle call member muting updates
        ...
    }
    
    func call(_ call: NXMCall, didReceive error: Error) {
        print("call error: \(error.localizedDescription)")
        // handle call errors
        ...
    }
    
}
```
