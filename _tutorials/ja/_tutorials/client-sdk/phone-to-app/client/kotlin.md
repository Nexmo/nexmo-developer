---
title:  クライアントを初期化する
description:  このステップでは、Vonageサーバーに対して認証を行います。

---

クライアントを初期化する
============

コールを発信する前に、クライアントSDKを初期化する必要があります。`MainActivity`クラスの`onCreate`メソッドの最後にこの行を追加します：

```kotlin
val client: NexmoClient = NexmoClient.Builder().build(this)
```

接続リスナーの設定
=========

stを聞く必要があります

```kotlin
client.setConnectionListener { connectionStatus, _ ->
    runOnUiThread {
        connectionStatusTextView.text = connectionStatus.toString()
    }
}
```

これで、クライアントはVonageサーバーに対して認証する必要があります。`MainActivity`内の`onCreate`メソッドには以下の追加が必要です。`ALICE_TOKEN`を前のステップで生成されたJWTに置き換えます：

```kotlin
client.login("ALICE_TOKEN");
```

ビルドして実行
-------

`Cmd + R`を押して、アプリをビルドして実行します。

