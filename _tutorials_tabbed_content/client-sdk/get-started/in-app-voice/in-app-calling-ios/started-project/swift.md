---
title: Swift
language: swift
menu_weight: 1
---

Clone this [Github project](https://github.com/Nexmo/Client-Get-Started-InApp-Voice-Swift).

Using the Github project you cloned, in the Starter app, with XCode:
    
1. Open `Constants.swift` file and replace the user IDs and tokens:

    ```swift
        var userId: String {
            switch self {
            case .jane:
                return "" //TODO: swap with Jane's userId
            case .joe:
                return "" //TODO: swap with Joe's userId
            }
        }
        
        var token: String {
            switch self {
            case .jane:
                return "" //TODO: swap with a token for Jane
            case .joe:
                return "" //TODO: swap with a token for Joe
            }
        }
    ```

2. Open `MainViewController.swift` file and make sure the following lines exist:

* `import NexmoClient` - imports the sdk
* `var client: NXMClient?` - property for the client instance
* `var call: NXMCall?` - property for the call instance
