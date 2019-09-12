---
title: Swift
language: swift
menu_weight: 1
---


We'll now adopt the `NXMCallDelegate` as an extension on `AppToAppCallViewController`, under the `//MARK:- NXMCallDelegate` line:

```swift
extension AppToAppCallViewController: NXMCallDelegate {

}
```

Copy the following `NXMCallDelegate` methods inside the extension:

```swift
func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, with status: NXMCallMemberStatus) {
    
    // call error
    if call.otherCallMembers.contains(callMember), [NXMCallMemberStatus.failed, NXMCallMemberStatus.busy, NXMCallMemberStatus.timeout].contains(callMember.status) {
        self.callStatus = .rejected
        self.call?.hangup()
        self.call = nil
    }
    
    // call rejected
    if call.otherCallMembers.contains(callMember), callMember.status == .rejected {
        self.callStatus = .rejected
        self.call?.hangup()
        self.call = nil
    }
    
    // call ended
    if call.otherCallMembers.contains(callMember), callMember.status == .completed {
        self.callStatus = .completed
        self.call?.hangup()
        self.call = nil
    }
    
    updateInterface()  
}

func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, isMuted muted: Bool) {
    updateInterface()
}

func call(_ call: NXMCall, didReceive error: Error) {
    updateInterface()
}

```

The `call(_:didUpdate:with:)` method notifies on changes that happen to members on the call.  
