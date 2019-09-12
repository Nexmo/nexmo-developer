---
title: Swift
language: swift
menu_weight: 1
---

Go back to the `NXMClientDelegate` extension and add the following methods:

```swift
func client(_ client: NXMClient, didReceive call: NXMCall) {
	DispatchQueue.main.async { [weak self] in
		self?.displayIncomingCallAlert(call: call)
	}
}

func displayIncomingCallAlert(call: NXMCall) {
    var from = "Unknown"
    if let otherParty = call.otherCallMembers.firstObject as? NXMCallMember {
        print("Type: \(String(describing: otherParty.channel?.from.type))")
        print("Number: \(String(describing: otherParty.channel?.from.data))")
        from = otherParty.channel?.from.data ?? "Unknown"
    }
    let alert = UIAlertController(title: "Incoming call from", message: from, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Answer", style: .default, handler: { _ in
        self.answer(call: call)
    }))
    alert.addAction(UIAlertAction(title: "Reject", style: .default, handler: { _ in
        self.reject(call: call)
    }))
    self.present(alert, animated: true, completion: nil)
}
```
