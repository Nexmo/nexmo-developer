---
title: Make a call
description: In this step you learn how to make an app-to-app call.
---

# Make a call

Locate the `startAppToAppCall` method within the `MainViewModel` class and fill its body to enable call:

```kotlin
@SuppressLint("MissingPermission")
fun startAppToAppCall() {
    lastCalledUserName = otherUserName
    client.call(otherUserName, NexmoCallHandler.IN_APP, callListener)
    loadingMutableLiveData.postValue(true)
}
```

> **NOTE:** we set the `IGNORED_NUMBER` argument, because our number is specified in the NCCO config (Nexmo application answer URL that you configured previously).

Now you need to make sure that above method is called after pressing UI button. Open `MainFragment` class and update `startAppToAppCallButton.setOnClickListener` inside `onViewCreated` method:

```kotlin
startAppToAppCallButton.setOnClickListener {
    viewModel.startAppToAppCall()
}
```

## Launch the app

Launch the app and make your first app to app call. You can either launch the app on the physical phone (with [USB Debugging enabled](https://developer.android.com/studio/debug/dev-options#enable)) or create new [Android Virtual Device](https://developer.android.com/studio/run/managing-avds).
