---
title: Make a call
description: In this step you learn how to make an app-to-app call.
---

# Make a call

Locate the `startAppToAppCall` method within the `MainViewModel` class and fill its body to enable call:

```java
@SuppressLint("MissingPermission")
public void startAppToAppCall() {
    String otherUserName = otherUserLiveData.getValue();
    lastCalledUserName = otherUserName;
    client.call(otherUserName, NexmoCallHandler.IN_APP, callListener);
    loadingMutableLiveData.postValue(true);
}
```

Now you need to make sure that above method is called after pressing the button. Open `MainFragment` class and update `startAppToAppCallButton.setOnClickListener` inside `onViewCreated` method:

```java
startAppToAppCallButton.setOnClickListener(it -> viewModel.startAppToAppCall());
```
