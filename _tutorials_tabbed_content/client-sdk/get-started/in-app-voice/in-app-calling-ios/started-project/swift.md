---
title: Swift
language: swift
menu_weight: 1
---

Clone this [Github project](https://github.com/Nexmo/ClientSDK-Get-Started-Voice-Swift).

Using the Github project you cloned, in the Start folder, open `GettingStarted.xcworkspace`. Then, within XCode:
    
1. Open `Constants.swift` file and replace the user `uuid`s and `jwt`s:

    ```swift
        var uuid: String {
            switch self {
            case .jane:
                return "" //TODO: swap with Jane's userId
            case .joe:
                return "" //TODO: swap with Joe's userId
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
    ```

2. From the `App-to-App` group, open `AppToAppCallViewController.swift` file and make sure the following lines exist:


* imports the SDK
    ```swift
    import NexmoClient
    ```

* the NexmoClient shrared instance
    ```swift
    let client = NXMClient.shared
    ```

* property for the call instance
    ```swift
    var call: NXMCall?
    ```
