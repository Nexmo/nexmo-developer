---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload 
        forType:(PKPushType)type withCompletionHandler:(void (^)(void))completion {
    if ([NXMClient.shared isNexmoPushWithUserInfo:payload.dictionaryPayload]) {
        NXMPushPayload *pushPayload = [NXMClient.shared processNexmoPushPayload:payload.dictionaryPayload];
        if (!pushPayload){
           NSLog(@"Not a nexmo push");
           return;
        };
    }
}
```
