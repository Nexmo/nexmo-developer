---
title: Receive a call
description: In this step you learn how to receive an in-app call
---

# Receive a call

Locate the `incomingCallListener` property within the `MainViewModel` class and fill its body:

```java
private NexmoIncomingCallListener incomingCallListener = call -> {
    callManager.setOnGoingCall(call);
    String otherUserName = call.getCallMembers().get(0).getUser().getName();
    NavDirections navDirections = MainFragmentDirections.actionMainFragmentToIncomingCallFragment(otherUserName);
    navManager.navigate(navDirections);
};
```

Now you need to make sure that above listener will be called. Locate the `onInit` method within the `MainViewModel` class and fill its body:

```java
public void onInit(MainFragmentArgs mainFragmentArgs) {
    String currentUserName = mainFragmentArgs.getUserName();
    currentUserNameMutableLiveData.postValue(currentUserName);

    String otherUserName = Config.getOtherUserName(currentUserName);
    otherUserNameMutableLiveData.postValue(otherUserName);

    client.removeIncomingCallListeners();
    client.addIncomingCallListener(incomingCallListener);
}
```
