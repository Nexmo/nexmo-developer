---
title: Swift
language: swift
menu_weight: 1
---



`Call Jane/Joe` button press is already connected to the `AppToAppCallViewController`.

Implement the `call:` method to start a call. 

```swift
@IBAction func call(_ sender: Any) {
    // start a new call (if one doesn't already exists)
    guard let call = call else {
        startCall()
        return
    }
    // or end an existing call
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
    client.call(user.callee.rawValue, callHandler: .inApp) { [weak self] (error, call) in
        guard let self = self else { return }
        // Handle create call failure
        guard let call = call else {
            if let error = error {
                // Handle create call failure
                print("✆  ‼️ call not created: \(error.localizedDescription)")
            } else {
                // Handle unexpected create call failure
                print("✆  ‼️ call not created: unknown error")
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
