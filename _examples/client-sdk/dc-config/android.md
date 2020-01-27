---
title: Android
menu_weight: 2
---

``` java
nexmoClient = new NexmoClient.Builder()
  .restEnvironmentHost("https://api-eu-1.nexmo.com")
  .environmentHost("https://ws-eu-1.nexmo.com")
  .imageProcessingServiceUrl("https://api-eu-1.nexmo.com/v1/image")
  .build(context);
```
