---
title: iOS
menu_weight: 3
---

```swift
NXMClientConfig *config = [[NXMClientConfig alloc] initWithApiUrl:restUrl websocketUrl:wsUrl ipsUrl:ipsUrl iceServerUrls:iceUrls];
[NXMClient setConfiguration:config]
// NOTE: You must call `setConfiguration` method before using `NXMClient.shared`.
```
