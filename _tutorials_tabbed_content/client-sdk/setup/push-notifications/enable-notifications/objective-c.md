---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
[NXMClient.shared enablePushNotificationsWithPushKitToken:pushKitToken userNotificationToken:deviceToken 
        isSandbox:YES completionHandler:^(NSError * _Nullable error) {
    // Code
}];

```
