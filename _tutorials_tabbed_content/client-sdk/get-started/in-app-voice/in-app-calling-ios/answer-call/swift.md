---
title: Swift
language: swift
menu_weight: 1
---

Under the `//MARK: Incoming call - Accept`, implement this method to answer the incoming call:

```swift
private func answer(call: NXMCall) {
    self.call = call
    call.answer { [weak self] error in
        if let error = error {
            print("✆  ‼️ error answering call: \(error.localizedDescription)")
        }
        self?.updateInterface()
    }
}
```