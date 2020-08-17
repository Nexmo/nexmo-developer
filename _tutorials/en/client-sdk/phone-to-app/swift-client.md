---
title: NXMClient
description: In this step you will authenticate to the Vonage servers.
---

# `NXMClient`

Before you can place a call, the Client SDK needs to authenticate to the Vonage servers. 

The following additions are required to `ViewController.swift`:

At the top of the file, import `NexmoClient`:

```swift
import UIKit
import NexmoClient
```

Add a `NXMClient` instance, below the `connectionStatusLabel`:

```swift
class ViewController: UIViewController {
    ...
    let connectionStatusLabel = UILabel()
    let client = NXMClient.shared
    ...
}
```

## Add the JWT

At the end of `viewDidLoad`, set the client delegate and log in - please make sure to replace `ALICE_JWT` for the `JWT` you created during a previous step. Please remember, the expiry time for the token was set to 6 hours so you will need to generate a new one if it is too old.

```swift
override func viewDidLoad() {
    ...
    client.setDelegate(self)
    client.login(withAuthToken: "ALICE_JWT")
}
```

## The Client Delegate

For the delegate to work, you need to have `ViewController` conform to `NXMClientDelegate`. At the end of the file, add:

```swift
extension ViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        switch status {
        case .connected:
            connectionStatusLabel.text = "Connected"
        case .disconnected:
            connectionStatusLabel.text = "Disconnected"
        case .connecting:
            connectionStatusLabel.text = "Connecting"
        @unknown default:
            connectionStatusLabel.text = "Unknown"
        }
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        connectionStatusLabel.text = error.localizedDescription
    }
    
}
```

An error is shown if encountered and the `connectionStatusLabel` is updated with the relevant connection status. 

## Build and Run

`Cmd + R` to build and run again:

![Interface connected](/meta/client-sdk/ios-phone-to-app/interface-connected.png)
