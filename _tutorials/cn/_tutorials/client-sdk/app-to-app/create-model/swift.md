---
title:  Building the user model
description:  In this step you will build the user model struct.

---

Building the user model
=======================

To be have a conversation you need to store some information about a user:

* A user's name
* A user's JWT
* Who they are chatting with

To do this you will use a `Struct`. Open the `ViewController.swift` file and add it below the class.

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

To make things easier for later on add some static properties on the `User` type for the users Alice and Bob. Replacing `ALICE_USERID`, `ALICE_JWT`, `BOB_USERID`, `BOB_JWT` with the values you created earlier.

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

