---
title: NXMClient
description: In this step you will authenticate to the Vonage servers.
---

# `NXMClient`

Before you can place a call, the Client SDK needs to authenticate to the Vonage servers. The following additions are required to `ViewController.swift`.

At the top of the file, import `NexmoClient`.

```swift
import UIKit
import NexmoClient
```

Add a `NXMClient` instance, below the `callButton`.

```swift
class ViewController: UIViewController {
    ...
    var callButton = UIButton(type: .roundedRect)
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

For the delegate part to work, you need to have `ViewController` conform to `NXMClientDelegate`. At the end of the file, add this extension.

```swift
extension ViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        print("✆  ‼️ connection error: \(error.localizedDescription)")
        DispatchQueue.main.async { [weak self] in
            self?.callButton.alpha = 0
            self?.connectionStatusLabel.text = error.localizedDescription
        }
    }
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus,
                reason: NXMConnectionStatusReason) {
        DispatchQueue.main.async { [weak self] in
            self?.callButton.alpha = 0
            switch status {
            case .connected:
                self?.connectionStatusLabel.text = "Connected"
                self?.callButton.alpha = 1
            case .disconnected:
                self?.connectionStatusLabel.text = "Disconnected"
            case .connecting:
                self?.connectionStatusLabel.text = "Connecting"
            @unknown default:
                self?.connectionStatusLabel.text = "Unknown"
            }
        }
    }
    
}
```

An error is shown if encountered and the `connectionStatusLabel` is updated with the relevant connection status. Also, `callButton` is shown when connected.

## Build and Run

`Cmd + R` to build and run again:

![Interface connected](/images/client-sdk/ios-voice/interface-connected.jpg)
