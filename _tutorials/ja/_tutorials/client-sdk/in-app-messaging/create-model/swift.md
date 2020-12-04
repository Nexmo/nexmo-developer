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
* [conversation ID (カンバセーションID)]

これを行うには、`Struct`を使用します。`ViewController.swift`を開いて追加し、`CONVERSATION_ID`を、前に作成した[conversation ID (カンバセーションID)]に置き換えます：

```swift
class ViewController: UIViewController {
    ...
}

struct User {
    let name: String
    let jwt: String
    let chatPartnerName: String
    let conversationId = "CONVERSATION_ID"
}
```

後で簡単にするために、ユーザーAliceとBobの`User`タイプにいくつかの静的プロパティを追加します。`ALICE_JWT`と`BOB_JWT`を、前に作成した値に置き換えます：

```swift
struct User {
    ...
````
static let Alice = User(name: "Alice",
                        jwt:"ALICE_JWT",
                        chatPartnerName: "Bob")
static let Bob = User(name: "Bob",
                      jwt:"BOB_JWT",
                      chatPartnerName: "Alice")
}
```
````
