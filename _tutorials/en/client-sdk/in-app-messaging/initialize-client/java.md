---
title: Initialize the client
description: In this step you will initialize `NexmoClient`, so it can be used within the application.
---

# Initialize the client

[NexmoClient](https://developer.nexmo.com/sdk/stitch/android/com/nexmo/client/NexmoClient.html) is the main class used to interact with `Android-Client-SDK`. Prior to usage, you have to initialize the client by providing an instance of the Android [Context](https://developer.android.com/reference/android/content/Context) class. 

Locate the `onCreate` method in the `MainActivity` class and initialize `NexmoClient` using the builder:

```java
@Override
protected void onCreate(@Nullable Bundle savedInstanceState) {
    
    // ...

    new NexmoClient.Builder().build(this);
}
```

> **NOTE:** The above code will allow retrieving `NexmoClient` instance later by using `NexmoClient.get()`.

> **NOTE:** You can enable additional `Logcat` logging by using `logLevel()` method of the builder, for example, `NexmoClient.Builder().logLevel(ILogger.eLogLevel.SENSITIVE).build(this)`

![](/screenshots/tutorials/client-sdk/android-shared/missing-import-java.png)

Run `Build` > `Make project` to make sure project is compiling.
