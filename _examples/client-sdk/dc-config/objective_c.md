---
title: Objective-C
language: objective_c
---

```objective_c
NXMClientConfig *config = [[NXMClientConfig alloc] initWithApiUrl:@"https://api-eu-1.nexmo.com" websocketUrl:@"wss://ws-eu-1.nexmo.com" ipsUrl:@"https://api-eu-1.nexmo.com/v1/image"];
[NXMClient setConfiguration:config];
NXMClient *client = NXMClient.shared;
```
