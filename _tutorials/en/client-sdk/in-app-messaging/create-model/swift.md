---
title: Building the user model
description: In this step you will build the user model struct.
---

# Building the user model

To have a conversation you need to store some information about a user: 

* A user's name
* A user's JWT
* Who they are chatting with
* The conversation ID

To do this you will use a `Struct`. Open `ViewController.swift` and add it, replacing `CONVERSATION_ID` with the conversation ID created earlier:

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

To make things easier for later on add some static properties on the `User` type for the users Alice and Bob. Replacing `ALICE_JWT` and `BOB_JWT` with the values you created earlier:

```swift
struct User {
    ...

    static let Alice = User(name: "Alice",
                            jwt:"ALICE_JWT",
                            chatPartnerName: "Bob")
    static let Bob = User(name: "Bob",
                          jwt:"BOB_JWT",
                          chatPartnerName: "Alice")
}
```