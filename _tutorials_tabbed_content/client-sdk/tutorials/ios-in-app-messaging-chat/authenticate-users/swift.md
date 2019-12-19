---
title: Swift
language: swift
menu_weight: 1
---

Inside `UserSelectionViewController`, explore the setup methods that were written for you on `viewDidLoad`.

Now locate the following line `//MARK: Setup Nexmo Client` and complete the `loginAs(user: User)` method implementation:

```swift
func loginAs(user: User) {
    self.user = user
    client.setDelegate(self)
    client.login(withAuthToken: user.jwt)
}
```

> **NOTE:** The `User` type is an enum we've defined in the `Constants.swift` file.

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.


Locate the following line `//MARK:- NXMClientDelegate` towards the end of `UserSelectionViewController.swift`, and add the required protocol adoption declaration to the class extension:

```swift
extension UserSelectionViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, 
            reason: NXMConnectionStatusReason) {
        print("connectionStatusChanged\n    - status: \(status.description())")
        print("    - reason: \(reason.description())")
        updateInterface()
        if status == .connected, let user = self.user {
            performSegue(withIdentifier: "showMessages", sender: user)
        }
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        print("✆  ‼️ connection error: \(error.localizedDescription)")
        updateInterface()
    }

}
```

The `client(_:didChanged:reason:)` methods of the `NXMClientDelegate` protocol indicates changes to the connection. 

If `status` is `.connected` then the user is authenticated and we're ready to move to the next screen, holding the conversation - we do this by performing the `showMessages` segue. 
