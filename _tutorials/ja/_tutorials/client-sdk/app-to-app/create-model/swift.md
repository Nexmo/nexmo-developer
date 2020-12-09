---
title:  ユーザーモデルの構築
description:  このステップでは、ユーザーモデルの構造体を構築します。

---

ユーザーモデルの構築
==========

会話をするには、ユーザーに関するいくつかの情報を保存する必要があります：

* ユーザーの名前
* ユーザーのJWT
* チャットをしている相手

これを行うには、`Struct`を使用します。`ViewController.swift`ファイルを開き、クラスの下に追加します。

```swift
class ViewController: UIViewController {
    ...
}

struct User {
    let name: String
    let jwt: String
    let callPartnerName: String
}
```

後で簡単にするために、AliceとBobの`User`タイプにいくつかの静的プロパティを追加します。`ALICE_USERID`、`ALICE_JWT`、`BOB_USERID`、`BOB_JWT`を、前に作成した値に置き換えます。

```swift
struct User {
    ...

    static let Alice = User(name: "Alice",
                            jwt:"ALICE_JWT",
                            callPartnerName: "Bob")
    static let Bob = User(name: "Bob",
                          jwt:"BOB_JWT",
                          callPartnerName: "Alice")
}
```

