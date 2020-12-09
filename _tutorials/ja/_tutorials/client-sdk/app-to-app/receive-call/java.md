---
title:  通話を受信する
description:  このステップでは、アプリ内通話を受信する方法を学びます

---

通話を受信する
=======

`MainViewModel`クラス内の`incomingCallListener`プロパティを見つけ、その本文を埋めます：

```java
private NexmoIncomingCallListener incomingCallListener = call -> {
    callManager.setOnGoingCall(call);
    String otherUserName = call.getCallMembers().get(0).getUser().getName();
    NavDirections navDirections = MainFragmentDirections.actionMainFragmentToIncomingCallFragment(otherUserName);
    navManager.navigate(navDirections);
};
```

上記のリスナーが呼び出されることを、ここで確認する必要があります。`MainViewModel`クラス内の`onInit`メソッドを見つけ、その本文を埋めます：

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

