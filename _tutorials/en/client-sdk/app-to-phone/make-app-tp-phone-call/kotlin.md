---
title: Make a call
description: In this step you make a phone call
---

# Authenticate Your Users

Locate the `startAppToAppCall` method within the `MainViewModel` class and fill its body to enable call:

```kotlin
@SuppressLint("MissingPermission")
fun startAppToPhoneCall() {
    lastCalledUserName = ""
    client.call("IGNORED_NUMBER", NexmoCallHandler.SERVER, callListener)
    loadingMutableLiveData.postValue(true)
}
```

> **NOTE:** we set the `IGNORED_NUMBER` argument, becaue our number is speciified in the NCCO config (answer URL that points to the gist file)

Now you need to make sure that above method is called after pressing UI button. Open `MainFragment` class and update `startAppToPhoneCallButton.setOnClickListener` inside `onViewCreated` method.

```kotlin
startAppToPhoneCallButton.setOnClickListener {
    viewModel.startAppToPhoneCall()
}
```

Launch the app and make your first call.