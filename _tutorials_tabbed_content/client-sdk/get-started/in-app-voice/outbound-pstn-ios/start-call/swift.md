---
title: Swift
language: swift
menu_weight: 1
---



Implement the `callNumber:` method to start a call. 

```swift
@IBAction func callNumber(_ sender: Any) {
    // call initiated but not yet active
    if callStatus == .initiated && call == nil {
        callStatus = .unknown
        self.call = nil
        updateInterface()
        return
    }
    // start a new call (check if a call already exists)
    guard let call = call else {
        startCall()
        return
    }
    end(call: call)
}
```

If a call is already in progress, taping the button will end it. 

Implement `startCall` - it will start the call, and also update the interface to show that a call is in progress:

```swift
private func startCall() {
    callStatus = .initiated
    client.call(User.calleePhoneNumber, callHandler: .server) { [weak self] (error, call) in
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
