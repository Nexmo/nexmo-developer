---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload 
        forType:(PKPushType)type withCompletionHandler:(void (^)(void))completion {
    if([client isNexmoPushWithUserInfo: payload.dictionaryPayload]) {
        [client processNexmoPushWithUserInfo:payload.dictionaryPayload completion:^(NSError * _Nullable error) {
            //Code
        }];
    }
}
```
