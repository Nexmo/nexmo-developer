---
title: Sending a message
description: In this step you will build the send message functionality.
---

# Sending a message

In the previous step you learned about conversations and events, sending a message creates a new event and sends it via the conversation.

To send a message, add the following function to `ChatViewController.swift`:

```swift
class ChatViewController: UIViewController {
    ...
    func send(message: String) {
        inputField.isEnabled = false
        conversation?.sendText(message, completionHandler: { [weak self] (error) in
            DispatchQueue.main.async { [weak self] in
                self?.inputField.isEnabled = true
            }
        })
    }
}
```

To get the text from the `inputField` you need to add another function provided by the `UITextFieldDelegate`. Add the following function to the `UITextFieldDelegate` extension: 

```swift
extension ChatViewController: UITextFieldDelegate {
    ...
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            send(message: text)
        }
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
```

This delegate function is called when the return button on the keyboard is pressed.


## Build and Run

`Cmd + R` to build and run again. You now have a functioning chat app! To chat simultaneously you can run the app on two different simulators/devices:

![Sent messages](/images/client-sdk/ios-messaging/messages.png)
