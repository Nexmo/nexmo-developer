---
title: Objective-C
language: objective_c
menu_weight: 2
---


Once Jane presses the "End Call" button, it is time to hangup the call. Implement `endCall:` method and call hangup for `call`.

```objective-c
- (IBAction)endCall:(id)sender {
    [self.call hangup];
    [self updateInterface];
}
```