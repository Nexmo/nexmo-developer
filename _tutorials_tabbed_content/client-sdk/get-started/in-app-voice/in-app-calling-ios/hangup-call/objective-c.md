---
title: Objective-C
language: objective_c
menu_weight: 2
---

Once Jane or Joe presses the `End Call` button, it is time to hangup the call. Implement `endCall` method and call hangup for `call`.

```objective-c
- (void)endCall {
    [self.call hangup];
    [self updateInterface];
}
```

Updates for `callMember` statuses are received in `call:didUpdate:withStatus:` as part of the `NXMCallDelegate` as you have seen before.  

The existing implementation is already handling call hangup.

