---
title: Swift
language: swift
menu_weight: 1
---

We'll now adopt the `NXMCallDelegate` as en extension on `MainViewController`:

```swift
extension MainViewController: NXMCallDelegate {

}
```

Copy the following implementation for the `statusChanged` method of the `NXMCallDelegate` along with the aid methods under the `//MARK:- Call Delegate` line:

```swift
func statusChanged(_ member: NXMCallMember!) {
    print("🤙🤙🤙 Call Status changed | member: \(String(describing: member.user.name))")
    print("🤙🤙🤙 Call Status changed | member status: \(String(describing: member.status.description()))")
    
    guard let call = call else {
        // this should never happen
        self.callStatus = .unknown
        self.updateInterface()
        return
    }
    
    // call ended before it could be answered
    if member == call.myCallMember, member.status == .answered, let otherMember = call.otherCallMembers.firstObject as? NXMCallMember, [NXMCallMemberStatus.completed, NXMCallMemberStatus.cancelled].contains(otherMember.status)  {
        self.callStatus = .completed
        self.call?.myCallMember.hangup()
        self.call = nil
    }
    
    // call rejected
    if call.otherCallMembers.contains(member), member.status == .cancelled {
        self.callStatus = .rejected
        self.call?.myCallMember.hangup()
        self.call = nil
    }
    
    // call ended
    if call.otherCallMembers.contains(member), member.status == .completed {
        self.callStatus = .completed
        self.call?.myCallMember.hangup()
        self.call = nil
    }

    updateInterface()
}
```

The `statusChanged:` method notifies on changes that happens to members on the call.  
