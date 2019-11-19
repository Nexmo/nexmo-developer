---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    if([client isNexmoPushWithUserInfo:userInfo]) {
        [client processNexmoPushWithuserInfo:userInfo completion:^(NSError * _Nullable error) {
            //Code
        }];
    }
}
```
