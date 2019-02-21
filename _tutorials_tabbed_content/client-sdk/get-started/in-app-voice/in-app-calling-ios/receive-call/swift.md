---
title: Swift
language: swift
menu_weight: 1
---

Go back to the `//MARK: NXMClientDelegate` line and add the `incomingCall:' method

```swift
func incomingCall(_ call: NXMCall) {
    print("📲 📲 📲 Incoming Call: \(call)")
    DispatchQueue.main.async {
        let names: [String] = call.otherCallMembers.compactMap({ participant -> String? in
            return (participant as? NXMCallMember)?.user.name
        })
        let alert = UIAlertController(title: "Incoming call from", message: names.joined(separator: ", "), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Answer", style: .default, handler: { _ in
            self.answer(call: call)
        }))
        alert.addAction(UIAlertAction(title: "Reject", style: .default, handler: { _ in
            self.reject(call: call)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
```
