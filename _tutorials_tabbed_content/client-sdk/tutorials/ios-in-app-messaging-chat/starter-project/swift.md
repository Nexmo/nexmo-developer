---
title: Swift
language: swift
menu_weight: 1
---


Clone this [Github project](https://github.com/Nexmo/ClientSDK-Get-Started-Messaging-Swift).

Using the Github project you cloned, in the Start folder, open `GettingStarted.xcworkspace`. Then, within XCode:

    
Open `Constants.swift` file and add `Jane`'s and `Joe`'s user IDs and JWTs, and conversation ID you've created on the previous steps:

```swift
enum User: String {
    case jane = "Jane"
    case joe = "Joe"
    
    var uuid: String {
        switch self {
        case .jane:
            return "" //TODO: swap with Jane's user uuid
        case .joe:
            return "" //TODO: swap with Joe's user uuid
        }
    }
    
    var jwt: String {
        switch self {
        case .jane:
            return "" //TODO: swap with a token for Jane
        case .joe:
            return "" //TODO: swap with a token for Joe
        }
    }
    
    static let conversationId = "" //TODO: swap with a conversation id
}

```

Notice that we defined the `User` as an `enum` to make it clearer and simpler to work with its properties. 

We've also defined `conversationId` as a static property on `User` - this might feel a bit out of place but makes it easier to use later on.