---
title:  通話を発信する
description:  このステップでは、アプリからアプリへの通話を発信する方法を学びます。

---

通話を発信する
=======

`MainViewModel`クラス内の`startAppToAppCall`メソッドを見つけ、その本文を埋めて通話を有効にします：

```java
@SuppressLint("MissingPermission")
public void startAppToAppCall() {
    String otherUserName = otherUserLiveData.getValue();
    lastCalledUserName = otherUserName;
    client.call(otherUserName, NexmoCallHandler.SERVER, callListener);
    loadingMutableLiveData.postValue(true);
}
```

> **注：** NCCO設定を使用した場合、AliceがBobに発信するシナリオだけが動作します。

ここで、ボタンを押した後に上記のメソッドが呼び出されることを確認する必要があります。`MainFragment`クラスを開き、 `onViewCreated`メソッド内の`startAppToAppCallButton.setOnClickListener`を更新します：

```java
startAppToAppCallButton.setOnClickListener(it -> viewModel.startAppToAppCall());
```

