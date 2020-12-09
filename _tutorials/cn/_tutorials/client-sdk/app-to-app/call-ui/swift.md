---
title:  Building the call interface
description:  In this step you will build the second screen of the app.

---

Building the call interface
===========================

To be able to call, you will need to create a new View Controller for the calling interface. From the Xcode menu, select `File` > `New` > `File...`. Choose a *Cocoa Touch Class* , name it `CallViewController` with a subclass of `UIViewController` and language of `Swift`.

![Xcode adding file](/images/client-sdk/ios-in-app-voice/callviewcontroller.png)

This will create a new file called `CallViewController`, at the top import `NexmoClient`.

```swift
import UIKit
import NexmoClient
```

The call interface will need:

* A `UIButton` to start a call
* A `UIButton` to end a call
* A `UILabel` to show status updates

Open `CallViewController.swift` and add it programmatically.

```swift
class CallViewController: UIViewController {
    
    let callButton = UIButton(type: .system)
    let hangUpButton = UIButton(type: .system)
    let statusLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        callButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(callButton)
        
        hangUpButton.setTitle("Hang up", for: .normal)
        hangUpButton.translatesAutoresizingMaskIntoConstraints = false

        setHangUpButtonHidden(true)
        view.addSubview(hangUpButton)
        
        setStatusLabelText("Ready to receive call...")
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            callButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            hangUpButton.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 20),
            hangUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hangUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hangUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statusLabel.topAnchor.constraint(equalTo: hangUpButton.bottomAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setHangUpButtonHidden(_ isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.hangUpButton.isHidden = isHidden
            self.callButton.isHidden = !self.hangUpButton.isHidden
        }
    }
    
    private func setStatusLabelText(_ text: String?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.statusLabel.text = text
        }
    }
}
```

There are two helper functions `setHangUpButtonHidden` and `setStatusLabelText` to avoid repetition of calling `DispatchQueue.main.async` as changing the state of the UI elements needs to be done on the main thread as required by `UIKit`. The `setHangUpButtonHidden` function toggles the visibility of the `hangUpButton` as this only needs to be visible during an active call.

Presenting the `CallViewController`
-----------------------------------

Now that the calling interface is built you will need to present the view controller from the log in screen you built earlier. You will need information about the logged in user to be passed between the two view controllers, within `CallViewController.swift` add the following.

```swift
class CallViewController: UIViewController {
    ...
    let user: User
    let client = NXMClient.shared
    let nc = NotificationCenter.default
    
    var call: NXMCall?

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```

This defines a custom initializer for the class which has a `User.type` as its parameter, which then gets stored in the local `user` property. Now that you have the user information you can use the `callButton` to show who the user will be calling, in `viewDidLoad` add the following.

```swift
navigationItem.leftBarButtonItem = 
UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.logout))
callButton.setTitle("Call (user.callPartnerName)", for: .normal)
if user.name == "Alice" {
    callButton.alpha = 0
}
```

This will hide the call button for Alice since for this demonstration only Bob will be able to make a call to Alice. In a production application the `NCCO` that is returned by your application's answer URL will dynamically return the correct username to avoid this. It also creates a logout button in the navigation bar, add the corresponding `logout` function to the end of `CallViewController.swift`

```swift
class CallViewController: UIViewController {
    ...

     @objc func logout() {
        client.logout()
        dismiss(animated: true, completion: nil)
    }
```

Now you are ready to present the calling interface along with the user information. To do this you will need to edit the `NXMClientDelegate` extension in the `ViewController.swift` file.

```swift
extension ViewController: NXMClientDelegate {
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        guard let user = self.user else { return }

        switch status {
        case .connected:
            self.statusLabel.text = "Connected"
            let navigationController = UINavigationController(rootViewController: CallViewController(user: user))
            navigationController.modalPresentationStyle = .overFullScreen
            self.present(navigationController, animated: true, completion: nil)
        ...
        }
    }
    ...
}
```

If the user connects successfully a `CallViewController` will be presented with the user data needed.

Build and Run
-------------

Run the project again (`Cmd + R`) to launch it in the simulator. If you log in with one of the users you will see the calling interface

![Call interface](/images/client-sdk/ios-in-app-voice/call.png)

