---
title: Initialize the client
description: In this step you will initialize `NexmoClient`, so it can be used within the application.
---

# Initialize the client

[NexmoClient](https://developer.nexmo.com/sdk/stitch/android/com/nexmo/client/NexmoClient.html) is the main class used to interact with `Android-Client-SDK`. Prior to usage, we have to initialize the client by providing an instance of the Android [Context](https://developer.android.com/reference/android/content/Context) class. The best place to initialize the client is the custom Android [Application](https://developer.android.com/reference/android/app/Application) class.

Locate the `BaseApplication` class in the `app/src/main/java/com/vonage/tutorial/voice` package and initialize `NexmoClient` inside `initializeNexmoClient` methood:

```kotlin
class BaseApplication : Application() {

    // ...

    private fun initializeNexmoClient() {
        NexmoClient.Builder().build(this)
    }
}
```

The above code will allow retrieving `NexmoClient` instance later by using `NexmoClient.get()`.

> **NOTE:** You can enable additional `Logcat` logging by using `logLevel()` method of the builder, for example, `NexmoClient.Builder().logLevel(ILogger.eLogLevel.SENSITIVE).build(this)`

You now have a working client. Your next step is to authenticate the users.
