---
title: Receive a call
description: In this step you learn how to receive an in-app call
---

# Make a call

Locate the `incomingCallListener` property within the `MainViewModel` class and fill its body:

```kotlin
private val incomingCallListener = NexmoIncomingCallListener { call ->
    callManager.onGoingCall = call
    val otherUserName = call.callMembers.first().user.name
    val navDirections = MainFragmentDirections.actionMainFragmentToIncomingCallFragment(otherUserName)
    navManager.navigate(navDirections)
}
```

Now you need to make sure that above listener will be called. Locate the `onInit` property within the `MainViewModel` class and fill its body:

```kotlin
fun onInit(mainFragmentArg: MainFragmentArgs) {
    val currentUserName = mainFragmentArg.userName
    _currentUserNameMutableLiveData.postValue(currentUserName)
    otherUserName = Config.getOtherUserName(currentUserName)
    client.removeIncomingCallListeners()
    client.addIncomingCallListener(incomingCallListener)
}
```
