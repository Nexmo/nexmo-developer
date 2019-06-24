---
title: Swift
language: swift
menu_weight: 1
---



`Call Jane/Joe` button press is already connected to the `MainViewController`.

Implement the `call:` method to start a call. 

```swift
@IBAction func call(_ sender: Any) {
    // call initiated but not yet active
    if callStatus == .initiated && call == nil {
        return
    }
    // start a new call (check if a call already exists)
    guard let call = call else {
        startCall()
        return
    }
    end(call: call)
}

private func startCall() {

}
private func end(call: NXMCall) {

}
```

If a call is already in progress, taping the button will end it. 

Let's implement `startCall` - it will start the call, and also update the visual elements so that Jane or Joe know the call is in progress:

```swift
private func startCall() {
    callStatus = .initiated
    client?.call([user.callee.userId], callHandler: .inApp, delegate: self) { [weak self] (error, call) in
        guard let self = self else { return }
        // Handle create call failure
        guard let call = call else {
            if let error = error {
                // Handle create call failure
                print("❌❌❌ call not created: \(error.localizedDescription)")
            } else {
                // Handle unexpected create call failure
                print("❌❌❌ call not created: unknown error")
            }
            self.callStatus = .error
            self.call = nil
            self.updateInterface()
            return
        }
        // Handle call created successfully.
        // callDelegate's  statusChanged: will be invoked with needed updates.
        call.setDelegate(self)
        self.call = call
        self.updateInterface()
    }
    updateInterface()
}
```

NB: You can have multiple users in a call (`client?.call` method takes an array as its first argument). However, this tutorial demonstrates a 1-on-1 call.