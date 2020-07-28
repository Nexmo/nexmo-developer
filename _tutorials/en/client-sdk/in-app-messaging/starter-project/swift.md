---
title: The starter project
description: In this step you will clone the starter project
---

# The starter project

To make things easier, we are providing a starter project for you. It is a simple Xcode project that contains the following two screens:

```screenshot
image: public/screenshots/tutorials/client-sdk/ios-in-app-messaging-chat/screens.png
```

Clone this [GitHub project](https://github.com/nexmo-community/ClientSDK-Get-Started-Messaging-Swift).

Using the GitHub project you cloned, in the Start folder, open `GettingStarted.xcworkspace`. Then, within Xcode:

    
Open `Constants.swift` file and add `Alice`'s and `Bob`'s user IDs and JWTs, and conversation ID you've created on the previous steps:

```swift
enum User: String {
    case alice = "Alice"
    case bob = "Bob"
    
    var uuid: String {
        switch self {
        case .alice:
            return "" //TODO: swap with Alice's user uuid
        case .bob:
            return "" //TODO: swap with Bob's user uuid
        }
    }
    
    var jwt: String {
        switch self {
        case .alice:
            return "" //TODO: swap with a token for Alice
        case .bob:
            return "" //TODO: swap with a token for Bob
        }
    }
    
    static let conversationId = "" //TODO: swap with a conversation id
}

```

Notice that we defined the `User` as an `enum` to make it clearer and simpler to work with its properties. 

We've also defined `conversationId` as a static property on `User` - this might feel a bit out of place but makes it easier to use later on.
