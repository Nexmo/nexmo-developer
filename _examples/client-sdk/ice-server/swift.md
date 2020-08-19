---
title: Swift
language: swift
---

```swift
let config = NXMClientConfig(apiUrl: restUrl, websocketUrl: wsUrl, ipsUrl: ipsUrl, iceServerUrls: iceUrls)
NXMClient.setConfiguration(config)

// NOTE: You must call `setConfiguration` method before using `NXMClient.shared`.
```
