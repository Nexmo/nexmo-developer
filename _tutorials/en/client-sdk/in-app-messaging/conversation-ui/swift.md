---
title: Building the chat interface
description: In this step you will build the second screen of the app.
---

# Building the chat interface

To be able to chat, you will need to create a new View Controller for the chat interface. From the Xcode menu, select `File` > `New` > `File...`. Choose a *Cocoa Touch Class*, name it `ChatViewController` with a subclass of `UIViewController` and language of `Swift`.

![Xcode adding file](/images/client-sdk/ios-messaging/chatviewcontrollerswift.png)

This will create a new file called `ChatViewController`, at the top import `NexmoClient`:

```swift
import UIKit
import NexmoClient
```

The chat interface will need:

* A `UITextView` to show the chat messages
* A `UITextField` to type messages into

Open `ChatViewController.swift` and add it programmatically:

```swift
class ChatViewController: UIViewController {
    let inputField = UITextField()
    let conversationTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        conversationTextView.text = ""
        conversationTextView.backgroundColor = .lightGray
        conversationTextView.isUserInteractionEnabled = false
        conversationTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conversationTextView)
        
        inputField.delegate = self
        inputField.returnKeyType = .send
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = UIColor.lightGray.cgColor
        inputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputField)
        
        NSLayoutConstraint.activate([
            conversationTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conversationTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conversationTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conversationTextView.bottomAnchor.constraint(equalTo: inputField.topAnchor, constant: -20),
            
            inputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputField.heightAnchor.constraint(equalToConstant: 40),
            inputField.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])   
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown),
         name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func keyboardWasShown(notification: NSNotification) {
        if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size {
            view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height - 20, right: 0)
        }
    }
```

In the `viewWillAppear` function an observer is added to the `keyboardDidShowNotification` which calls the `keyboardWasShown`. The `keyboardWasShown` function adjusts the layout margins of the view which moves the input field. This stops the `inputField` being blocked by the keyboard when typing.


## The `UITextField` Delegate

You will need to conform to the `UITextFieldDelegate` to know when the user has finished typing to move the input field to its original position. At the end of the file, add:

```swift
extension ChatViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
```

## Presenting the `ChatViewController`

Now that the chat interface is built you will need to present the view controller from the log in screen you built earlier. You will need information about the logged in user to be passed between the two view controllers, within `ChatViewController.swift` add:

```swift 
class ChatViewController: UIViewController {
    ...
    let client = NXMClient.shared
    let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```
This defines a custom initializer for the class which has a `User.type` as its parameter, which then gets stored in the local `user` property. Now that we have the user information you use the navigation bar to show who the user will be chatting with, in `viewDidLoad` add:

```swift
navigationItem.leftBarButtonItem = 
UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.logout))
title = "Conversation with \(user.chatPartnerName)"

```
This will also creates a logout button in the navigation bar, add the `logout` function to the end of `ChatViewController.swift`:

```swift 
class ChatViewController: UIViewController {
    ...

     @objc func logout() {
        client.logout()
        dismiss(animated: true, completion: nil)
    }
```

Now you are ready to present the chat interface along with the user information. To do this you will need to edit the `NXMClientDelegate` extension in the `ViewController.swift` file:

```swift
extension ViewController: NXMClientDelegate {
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        guard let user = self.user else { return }

        switch status {
        case .connected:
            self.statusLabel.text = "Connected"
            let navigationController = UINavigationController(rootViewController: ChatViewController(user: user))
            navigationController.modalPresentationStyle = .overFullScreen
            present(navigationController, animated: true, completion: nil)
        ...
        }
    }
    ...
}
```
If the user connects successfully a `ChatViewController` will be presented with the user data needed.

## Build and Run

Run the project again (`Cmd + R`) to launch it in the simulator. If you log in with one of the users you will see the chat interface

![Chat interface](/images/client-sdk/ios-messaging/chat.png)
