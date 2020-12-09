---
title:  クライアントを初期化する
description:  このステップでは、アプリケーション内で使用できるように、`NexmoClient`を初期化します。

---

クライアントを初期化する
============

[NexmoClient](https://developer.nexmo.com/sdk/stitch/android/com/nexmo/client/NexmoClient.html)は、`Android-Client-SDK`と対話するために使用されるメインクラスです。使用する前に、Android [Context](https://developer.android.com/reference/android/content/Context)クラスのインスタンスを提供することにより、クライアントを初期化する必要があります。クライアントを初期化するのに最適な場所は、カスタムAndroid [Application](https://developer.android.com/reference/android/app/Application)クラスです。

`BaseApplication`クラス内の`initializeNexmoClient`メソッドを見つけ、ビルダーを使用して`NexmoClient`を初期化します。このクラスを見つけるには、左側のAndroidビューか、`Navigate class`キーボードショートカット（Mac：`Cmd + O`；Win：`Ctrl + O`）を使用します。

```kotlin
private fun initializeNexmoClient() {
    NexmoClient.Builder().build(this)
}
```

> **注：** 上記のコードにより、`NexmoClient.get()`を使用して、後で`NexmoClient`インスタンスを取得することができます。

> **注：** ビルダーの`logLevel()`メソッドを使用して、追加の`Logcat`ログを有効にすることができます。たとえば、 `NexmoClient.Builder().logLevel(ILogger.eLogLevel.SENSITIVE).build(this)`

Android Studioが`NexmoClient`クラスへの参照を見つけることができない場合は、不足しているインポートを追加する必要があります。`NexmoClient`クラスをロールオーバーし、ウィンドウが表示されるのを待って`Import`を押します（これは次の手順でも必要です）。

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/missing-import-kotlin.png
```

これで、クライアントが動作しています。次のステップは、ユーザーを認証することです。

