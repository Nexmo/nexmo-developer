---
title: NXMClient
description: In this step you will authenticate to the Vonage servers.
---

# `NXMClient`

Before you can start a chat, the Client SDK needs to authenticate to the Vonage servers. The following additions are required to `ViewController.swift`.

At the top of the file, import `NexmoClient`:

```swift
import UIKit
import NexmoClient
```

Add a `NXMClient` instance, below the `statusLabel`:

```swift
class ViewController: UIViewController {
    ...
    let statusLabel = UILabel()

    let client = NXMClient.shared
    ...
}
```

Add a `user` property, below the `client`:

```swift
class ViewController: UIViewController {
    ...
    
    var user: User? {
        didSet {
            login()
        }
    }
}
```

## Button Targets

For the log in buttons to work, you need to add targets to them which will run a function when they are tapped. In the `ViewController.swift` file add:

```swift
class ViewController: UIViewController {
    ...

    override func viewDidLoad() {
        ...
    }

    ...

    @objc func setUserAsAlice() {
        self.user = User.Alice
    }

    @objc func setUserAsBob() {
        self.user = User.Bob
    }
}
```

Then link the two functions them to their respective buttons at the end of the `viewDidLoad` function:

```swift
override func viewDidLoad() {
    ...

    loginAliceButton.addTarget(self, action: #selector(setUserAsAlice), for: .touchUpInside)
    loginBobButton.addTarget(self, action: #selector(setUserAsBob), for: .touchUpInside)
}
```

## Add the Log in function

At the end of `ViewController.swift`, add the `login` function needed by the user property. This function sets the client's delegate and logs in when the user property is set to a new value:

```swift
class ViewController: UIViewController {
    ...

    override func viewDidLoad() {
        ...
    }

    func login() {
        guard let user = self.user else { return }

        client.setDelegate(self)
        client.login(withAuthToken: user.jwt)
    }
}
```

## The Client Delegate

For the delegate to work, you need to have `ViewController` conform to `NXMClientDelegate`. At the end of the file, add:

```swift
extension ViewController: NXMClientDelegate {
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) { 
        switch status {
        case .connected:
            setStatusLabel("Connected")
        case .disconnected:
            setStatusLabel("Disconnected")
        case .connecting:
            setStatusLabel("Connecting")
        @unknown default:
            setStatusLabel("")
        }
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        setStatusLabel(error.localizedDescription)
    }
    
    func setStatusLabel(_ newStatus: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = newStatus
        }
    }
}
```

An error is shown if encountered and the `statusLabel` is updated with the relevant connection status. 

## Build and Run

Press `Cmd + R` to build and run again. If you tap on one of the log in buttons it will log the client in with the respective user:

![Interface connected](/images/client-sdk/ios-messaging/client.png)
