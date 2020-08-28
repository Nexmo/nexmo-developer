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

> **NOTE** Only Alice calling Bob scenario will work given used NCCO config.

Now you need to make sure that above method is called after pressing the button. Open `MainFragment` class and update `startAppToAppCallButton.setOnClickListener` inside `onViewCreated` method:

```kotlin
startAppToAppCallButton.setOnClickListener {
    viewModel.startAppToAppCall()
}
```
