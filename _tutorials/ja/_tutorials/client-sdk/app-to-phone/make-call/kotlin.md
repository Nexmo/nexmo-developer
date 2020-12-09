---
title:  通話を発信する
description:  このステップでは、電話をかける方法を学びます。

---

通話を発信する
=======

`MainViewModel`クラス内の`startAppToAppCall`メソッドを見つけ、その本文を埋めて通話を有効にします：

```kotlin
@SuppressLint("MissingPermission")
fun startAppToPhoneCall() {
    // Callee number is ignored because it is specified in NCCO config
    client.call("IGNORED_NUMBER", NexmoCallHandler.SERVER, callListener)
    loadingMutableLiveData.postValue(true)
}
```

> **注：** `IGNORED_NUMBER`引数が設定されます。番号がNCCO設定（前に設定したVonageアプリケーション応答URL）で指定されているためです。

ここで、UIボタンを押した後に上記のメソッドが呼び出されることを確認する必要があります。`MainFragment`クラスを開き、 `onViewCreated`メソッド内の`startAppToPhoneCallButton.setOnClickListener`を更新します：

```kotlin
startAppToPhoneCallButton.setOnClickListener {
    viewModel.startAppToPhoneCall()
}
```

