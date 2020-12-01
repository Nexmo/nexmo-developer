---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    if([NXMClient.shared isNexmoPushWithUserInfo:userInfo]) {
        NXMPushPayload *pushPayload = [NXMClient.shared processNexmoPushPayload:userInfo];
        if (!pushPayload){
            NSLog(@"Not a Nexmo push!!");
            return;
        };
        if (pushPayload.template == NXMPushTemplateCustom) {
            // Got custom push
            NSLog(@"Got a custom push: %@", pushPayload.customData);
        }
    }
}
```
