---
title: Make a call
description: In this step you learn how to make an app-to-app call.
---

# Make a call

To make a call we will make use of the `callButton` in the `CallViewController` UI. First we need to add a target to the button.

```swift
class CallViewController: UIViewController {
    ...
    override func viewDidLoad() {
        ...
        callButton.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
    }
}
```

When the `callButton` is tapped it will call the `makeCall` function. Add it to the end of the `CallViewController` class.

```swift
class CallViewController: UIViewController {
    ...
    @objc private func makeCall() {
        setStatusLabelText("Calling \(user.callPartnerName)")

        client.call(user.callPartnerName, callHandler: .inApp) { error, call in
            if error != nil {
                self.setStatusLabelText(error?.localizedDescription)
                return
            }
            call?.setDelegate(self)
            self.setHangUpButtonHidden(false)
            self.call = call
        }
    }
}
```

The `makeCall` function uses the `NXMClient` instance to make the call. If there is no error the call's delegate is set so that changes to the call can be monitored and the `hangUpButton` is made visible.  


## Build and run

Press `Cmd + R` to build and run again. You now have a functioning call app! To test it out you can run the app on two different simulators/devices:

![Sent messages](/images/client-sdk/ios-in-app-voice/active-call.png)