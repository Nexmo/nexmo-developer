---
title: Receive a call
description: In this step you will receive the call.
---

# Receive a call

At the top of the `ViewController` class, just below the `client` declaration, add a `NXMCall` property to hold a reference to any call in progress.

```swift
class ViewController: UIViewController {
    ...
    let client = NXMClient.shared
    var call: NXMCall?
    ...
}
```

When the application receives a call we want to give the option to accept or reject the call. To do this add the `displayIncomingCallAlert` function to the `ViewController` class.

```swift
class ViewController: UIViewController {
    ...
    func displayIncomingCallAlert(call: NXMCall) {
        var from = "Unknown"
        if let otherParty = call.otherCallMembers.firstObject as? NXMCallMember {
            from = otherParty.channel?.from.data ?? "Unknown"
        }
        
        let alert = UIAlertController(title: "Incoming call from", message: from, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Answer", style: .default, handler: { _ in
            self.call = call
            call.answer(nil)

        }))
        alert.addAction(UIAlertAction(title: "Reject", style: .default, handler: { _ in
            call.reject(nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
```
The `displayIncomingCallAlert` function takes a `NXMCall` as a parameter, with this we can access the members, which are the type `NXMCallMember`, of the call to retrieve the phone number of the incoming call. Note in the `UIAlertAction` for answering the call we assign the call to the property from earlier.

To use `displayIncomingCallAlert` you need to use the `NXMClientDelegate` which has a function that will be called when the client receives an incoming `NXMCall`.

```swift
extension ViewController: NXMClientDelegate {
    ...
    func client(_ client: NXMClient, didReceive call: NXMCall) {
        DispatchQueue.main.async { [weak self] in
            self?.displayIncomingCallAlert(call: call)
        }
    }
}
```

## Build and Run

Press `Cmd + R` to build and run again, when you call the number linked with your application from earlier you will be presented with an alert. You can pick up and the call will be connected!

![Incoming call alert](/meta/client-sdk/ios-phone-to-app/alert.png)

