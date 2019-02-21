---
title: Swift
language: swift
menu_weight: 1
---

Open `MainViewController.swift`. Explore the setup methods that were written for you on `viewDidLoad`.

Now locate the following line `//MARK: - Setup Nexmo Client` and complete the `setupNexmoClient` method implementation:

```swift
func setupNexmoClient() {
    client = NXMClient(token: user.token)
    client?.setDelegate(self)
    client?.login()
}
```

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.

Add the required protocol adoption declaration to the class extension located towards the end of the `MainViewController.swift` file:

```swift
extension MainViewController: NXMClientDelegate {
    ...
}
```

The `connectionStatusChanged:reason` methods of the `NXMClientDelegate` protocol indicates if the login was successful and you can start using the SDK.

Add the following method under the `#pragma mark NXMClientDelegate` line.

```swift
func connectionStatusChanged(_ status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
    updateInterface()
}
```
