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
