---
title:  Initialize the client
description:  In this step you will initialize `NexmoClient`, so it can be used within the application.

---

Initialize the client
=====================

[NexmoClient](https://developer.nexmo.com/sdk/stitch/android/com/nexmo/client/NexmoClient.html) is the main class used to interact with `Android-Client-SDK`. Prior to usage, we have to initialize the client by providing an instance of the Android [Context](https://developer.android.com/reference/android/content/Context) class. The best place to initialize the client is the custom Android [Application](https://developer.android.com/reference/android/app/Application) class.

Locate the `initializeNexmoClient` method in the `BaseApplication` class and initialize `NexmoClient` using the builder. You can find this class in the Android view on the left or use `Navigate class` keyboard shortcut (Mac: `Cmd + O` ; Win: `Ctrl + O`).

```kotlin
private fun initializeNexmoClient() {
    new NexmoClient.Builder().build(this);
}
```

> **NOTE:** The above code will allow retrieving `NexmoClient` instance later by using `NexmoClient.get()`.

> **NOTE:** You can enable additional `Logcat` logging by using `logLevel()` method of the builder, for example, `NexmoClient.Builder().logLevel(ILogger.eLogLevel.SENSITIVE).build(this)`

If Android Studio can't find the reference to the `NexmoClient` class then you have to add the missing import. Roll over on the `NexmoClient` class, wait for window to appear and press `Import` (this will be required in following steps as well).

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/missing-import-java.png
```

You now have a working client. Your next step is to authenticate the users.

