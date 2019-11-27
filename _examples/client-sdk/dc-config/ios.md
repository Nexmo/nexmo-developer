---
title: iOS
menu_weight: 3
---

``` swift
let config = NXMClientConfig(apiUrl: "https://api-eu-1.nexmo.com",
                             websocketUrl: "wss://ws-eu-1.nexmo.com",
                             ipsUrl: "https://api-eu-1.nexmo.com/v1/image")
NXMClient.setConfiguration(config)
let nexmoClient = NXMClient.shared
```
