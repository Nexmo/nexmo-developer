---
title: Swift
language: swift
menu_weight: 1
---

```swift
@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
@IBOutlet weak var statusLabel: UILabel!

@IBOutlet weak var inputTextField: UITextField!
@IBOutlet weak var inputTextFieldBottomConstraint: NSLayoutConstraint!

@IBOutlet weak var conversationTextView: UITextView!
```

All the interface changes are affected inside the `updateInterface()` method; eg: when the conversation screen is showb, the loading interface will be shown:

```swift
func updateInterface() {
    DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        
        // default interface - loading screen
        self.activityIndicator.startAnimating()
        self.statusLabel.alpha = 1.0
        self.statusLabel.text = "Loading..."
        self.conversationTextView.alpha = 0
        self.inputTextField.alpha = 0

        ...
    }
}
```

Please do have a look at the other lines inside `updateInterface` to understand how the interface changes as resources are being retrieved.
