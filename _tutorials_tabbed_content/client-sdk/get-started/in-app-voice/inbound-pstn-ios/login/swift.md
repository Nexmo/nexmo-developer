---
title: Swift
language: swift
menu_weight: 1
---

Inside `ReceivePhoneCallViewController`, explore the setup methods that were written for you on `viewDidLoad`.

Now locate the following line `//MARK:  Setup Nexmo Client` and complete the `setupNexmoClient` method implementation:

```swift
func setupNexmoClient() {
    client.setDelegate(self)
    client.login(withAuthToken: user.jwt)
}
```

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.

Add the required protocol adoption declaration to the class extension located towards the end of the `ReceivePhoneCallViewController.swift` file, under the `//MARK:- Client Delegate` line:

```swift
extension ReceivePhoneCallViewController: NXMClientDelegate {
    ...
}
```

The `client(_:didChanged:reason:)` methods of the `NXMClientDelegate` protocol indicates if the login was successful and you can start using the SDK.

Add the following methods inside the extension.

```swift
extension ReceivePhoneCallViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        updateInterface()
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        updateInterface()
    }
    
}
```
