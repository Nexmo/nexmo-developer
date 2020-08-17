---
title: Make a call
description: In this step you learn how to make a phone call.
---

# Make a call

Locate the `startAppToAppCall` method within the `MainViewModel` class and fill its body to enable call:

```kotlin
@SuppressLint("MissingPermission")
fun startAppToPhoneCall() {
    client.call("IGNORED_NUMBER", NexmoCallHandler.SERVER, callListener)
    loadingMutableLiveData.postValue(true)
}
```

> **NOTE:** we set the `IGNORED_NUMBER` argument, because our number is specified in the NCCO config (Nexmo application answer URL that you configured previously).

Now you need to make sure that above method is called after pressing UI button. Open `MainFragment` class and update `startAppToPhoneCallButton.setOnClickListener` inside `onViewCreated` method:

```kotlin
startAppToPhoneCallButton.setOnClickListener {
    viewModel.startAppToPhoneCall()
}
```

## Launch the app

Launch the app and make your first app to phone call. You can either launch the app on the physical phone (with [USB Debugging enabled](https://developer.android.com/studio/debug/dev-options#enable)) or create new [Android Virtual Device](https://developer.android.com/studio/run/managing-avds).