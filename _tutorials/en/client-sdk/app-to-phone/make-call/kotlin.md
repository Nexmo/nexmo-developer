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
