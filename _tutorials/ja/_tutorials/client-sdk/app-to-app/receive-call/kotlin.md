---
title:  通話を受信する
description:  このステップでは、アプリ内通話を受信する方法を学びます

---

通話を受信する
=======

`MainViewModel`クラス内の`incomingCallListener`プロパティを見つけ、その本文を埋めます：

```kotlin
private val incomingCallListener = NexmoIncomingCallListener { call ->
    callManager.onGoingCall = call
    val otherUserName = call.callMembers.first().user.name
    val navDirections = MainFragmentDirections.actionMainFragmentToIncomingCallFragment(otherUserName)
    navManager.navigate(navDirections)
}
```

上記のリスナーが呼び出されることを、ここで確認する必要があります。`MainViewModel`クラス内の`onInit`メソッドを見つけ、その本文を埋めます：

```kotlin
fun onInit(mainFragmentArg: MainFragmentArgs) {
    val currentUserName = mainFragmentArg.userName
    _currentUserNameMutableLiveData.postValue(currentUserName)

    otherUserName = Config.getOtherUserName(currentUserName)

    client.removeIncomingCallListeners()
    client.addIncomingCallListener(incomingCallListener)
}
```

