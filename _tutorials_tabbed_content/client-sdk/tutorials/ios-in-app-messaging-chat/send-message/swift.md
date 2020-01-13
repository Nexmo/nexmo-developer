---
title: Swift
language: swift
menu_weight: 1
---


Inside `ConversationViewController.swift`, locate the following line 

`///MARK: Send a message` 

and fill in the `send(message:)` method implementation:

```swift
//MARK: Send a message

func send(message: String) {
    inputTextField.resignFirstResponder()
    inputTextField.isEnabled = false
    activityIndicator.startAnimating()
    conversation?.sendText(message, completionHandler: { [weak self] (error) in
        DispatchQueue.main.async { [weak self] in
            self?.inputTextField.isEnabled = true
            self?.activityIndicator.stopAnimating()
        }
    })
}
```

You'll notice that, altought the message was sent, the conversation doesn't include it. We could be calling `getEvents` after sending but the SDK provides a way to receive new events.
