---
title: iOS
menu_weight: 3
---

``` objective-c
NXMClientConfig *config = [[NXMClientConfig alloc] initWithApiUrl:restUrl websocketUrl:wsUrl ipsUrl:ipsUrl iceServerUrls:iceUrls];
[NXMClient setConfiguration:config]
// NOTE: You must call `setConfiguration` method before using `NXMClient.shared`.
```
