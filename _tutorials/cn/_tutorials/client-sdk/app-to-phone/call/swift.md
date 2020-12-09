---
title:  Place a call
description:  In this step you will place the call.

---

Place a call
============

At the top of the `ViewController` class, just below the `client` declaration, add a `NXMCall` property to hold a reference to any call in progress

```swift
class ViewController: UIViewController, NXMClientDelegate {
    ...
    let client = NXMClient.shared
    var call: NXMCall?
    ...
}
```

Based on the object referenced by the `call` property, the `callButtonPressed` method can now be used to either place or end calls; the `placeCall` and `endCall` methods are triggered for each case.

Please make sure to replace `PHONE_NUMBER` below with the actual phone number you want to call. Note: must be the same one as the one specified in the gist NCCO:

```swift
@IBAction func callButtonPressed(_ sender: Any) {
    if call == nil {
        placeCall()
    } else {
        endCall()
    }
}

func placeCall() {
    callButton.setTitle("End Call", for: .normal)
    client.call("PHONE_NUMBER", callHandler: .server) {  [weak self] (error, call) in
        if let error = error {
            self?.connectionStatusLabel.text = error.localizedDescription
            self?.callButton.setTitle("Call", for: .normal)
        }
        self?.call = call
    }
}

func endCall() {
    call?.hangup()
    call = nil
    callButton.setTitle("Call", for: .normal)
}
```

That's it\! You can now build, run and place the call\! Magic\!

