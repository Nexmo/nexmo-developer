---
title:  Receive a call
description:  In this step you learn how to receive an in-app call

---

Receiving a call
================

Now that the calling interface is built, you can now add the code needed receive a call. The `NXMClientDelegate` has a function that is called when there is an incoming call. Add an implementation for it in the `NXMClientDelegate` extension in the `ViewController.swift` file.

```swift
extension ViewController: NXMClientDelegate {
    ...

    func client(_ client: NXMClient, didReceive call: NXMCall) {
        nc.post(name: .call, object: call)
    }
}

extension Notification.Name {
    static var call: Notification.Name {
        return .init(rawValue: "NXMClient.incommingCall")
    }
}
```

The `CallViewController` class will be in the foreground and the class handling the call, so the call is passed along using a `NSNotification` post. For `CallViewController` to receive this notification it needs to observe it. In the `CallViewController` add.

```swift
class CallViewController: UIViewController {
    ...
    
    override func viewDidLoad() {
        ...

        nc.addObserver(self, selector: #selector(didReceiveCall), name: .call, object: nil)

        hangUpButton.addTarget(self, action: #selector(endCall), for: .touchUpInside)
    }

    ...

    @objc private func didReceiveCall(_ notification: Notification) {
        guard let call = notification.object as? NXMCall else { return }
        DispatchQueue.main.async { [weak self] in
            self?.displayIncomingCallAlert(call: call)
        }
    }
    
    private func displayIncomingCallAlert(call: NXMCall) {
        var from = "Unknown"
        if let otherParty = call.otherCallMembers.firstObject as? NXMCallMember {
            from = otherParty.user.name
        }

        let alert = UIAlertController(title: "Incoming call from", message: from, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Answer", style: .default, handler: { _ in
            call.answer { error in
                if error != nil {
                    self.setStatusLabelText(error?.localizedDescription)
                    return
                }
                call.setDelegate(self)
                self.setHangUpButtonHidden(false)
                self.setStatusLabelText("On a call with (from)")
                self.call = call
            }
        }))

        alert.addAction(UIAlertAction(title: "Reject", style: .destructive, handler: { _ in
            call.reject(nil)
        }))

        self.present(alert, animated: true, completion: nil)
    }

    @objc private func endCall() {
        call?.hangup()
        self.setHangUpButtonHidden(true)
        self.setStatusLabelText("Ready to receive call...")
    }
}
```

When a notification is received `didReceiveCall` is called which in turn calls `displayIncomingCallAlert` to present the user with the option of accepting or rejecting the call. If the user accepts the UI is updated to show who the user is on a call with and the `hangUpButton` becomes visible. If the `hangUpButton` is tapped `endCall` is called which hangs up the call and updates the UI.

The call delegate
-----------------

Similar to `NXMClient`, `NXMCall` also has a delegate to handle changes to the call. To the end of the `CallViewController.swift` file add the conformance to the `NXMCallDelegate`.

```swift
extension CallViewController: NXMCallDelegate {
    func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, with status: NXMCallMemberStatus) {
        switch status {
        case .answered:
            guard callMember.user.name != self.user.name else { return }
            setStatusLabelText("On a call with (callMember.user.name)")
        case .completed:
            setStatusLabelText("Call ended")
            setHangUpButtonHidden(true)
            self.call = nil
        default:
            break
        }
    }

    func call(_ call: NXMCall, didReceive error: Error) {
        setStatusLabelText(error.localizedDescription)
    }

    func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, isMuted muted: Bool) {}
}
```

In the next step you will add the code needed to make a call.

