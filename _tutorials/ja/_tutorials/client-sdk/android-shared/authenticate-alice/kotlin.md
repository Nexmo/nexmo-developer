---
title:  ユーザーを認証する
description:  このステップでは、先ほど作成したJWTを使用してユーザーを認証します

---

ユーザーを認証する
=========

ログイン画面（`LoginFragment`および`LoginViewModel`クラス）で、ユーザーの認証を行います。

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/login-screen-user.png
```

> **注：** この認証は、前の手順で生成された`JWT`を使用して行います。

NexmoClientインスタンスを取得する
----------------------

`LoginViewModel`クラス内でクライアントインスタンスを取得する必要があります。通常、それはインジェクションを介して提供されますが、チュートリアルのために、静的メソッドを使用して直接インスタンスを取得します。`LoginViewModel`クラス内の`private val client`プロパティを見つけ、その実装を更新します。

```kotlin
private val client = NexmoClient.get()
```

不足しているインポートを再度追加してください。

ログインユーザー
--------

通話に参加するには、ユーザー認証が必要です。`LoginViewModel`クラス内の`onLoginUser`メソッドを見つけて、このコードに置き換えます。

```kotlin
fun onLoginUser(user: User) {
    if (!user.jwt.isBlank()) {
        this.user = user
        client.login(user.jwt)
    }
}
```

> **注：** `LoginFragment`クラス内で、あなたのために書かれた`loginUser`メソッドを探索してください。このメソッドは、2つの`Login ...`ボタンのいずれかがクリックされたときに呼び出されます。このメソッドは、上記の`onLoginUser`メソッドを呼び出します。

> **注：** `User`タイプは、 `Config.kt`ファイルで定義した`data class`です。

接続状態の監視
-------

接続が確立されると、ユーザーを`MainFragment`にナビゲートする必要があります。`LoginViewModel`クラス内の`init`ブロックを見つけ、このコードに置き換えます。

```kotlin
init {
        client.setConnectionListener { newConnectionStatus, _ ->

            if (newConnectionStatus == ConnectionStatus.CONNECTED) {
                navigate()
                return@setConnectionListener
            }

            connectionStatusMutableLiveData.postValue(newConnectionStatus)
        }
}
```

上記のコードは、接続状態を監視し、ユーザーが認証されている場合（`ConnectionStatus.CONNECTED`）、ユーザーを`MainFragment`にナビゲートします。

これで、アプリ内で通話する準備ができました。

