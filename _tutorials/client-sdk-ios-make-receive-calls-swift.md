---
title: How to Make and Receive Voice calls with the Nexmo Client SDK on iOS using Swift
products: client-sdk
description: This tutorial shows you how to create a Nexmo Client SDK application that can make and receive voice calls on iOS using Swift.
languages:
    - Swift
---

# How to Make and Receive Voice calls with the Nexmo Client SDK on iOS using Swift

In this tutorial you learn how to use Nexmo Client SDK for iOS, in order to perform an in-app (IP to IP) voice call.

You will create a simple app to make a call and receive a call.

The app will have two buttons, which log in different users: Jane or Joe. After logging in, Jane and Joe are able to place a call and perform actions such as answer, decline or hangup.

## Prerequisites

- [Create a Nexmo Application](/tutorials/client-sdk-generate-test-credentials).

- Make sure you have at least [two users for your Nexmo Application, with valid JWTs](/tutorials/client-sdk-generate-test-credentials).

- [Add Nexmo SDK to your project](/tutorials/client-sdk-ios-add-sdk-to-your-app).

## Create the project

Clone this [Github project](https://github.com/Nexmo/Client-Get-Started-InApp-Voice-Swift).

Using the Github project you cloned, in the Starter app, with XCode:
    
1. Open `Constants.swift` file and replace the user IDs and tokens:

    ```swift
        var userId: String {
            switch self {
            case .jane:
                return "" //TODO: swap with Jane's userId
            case .joe:
                return "" //TODO: swap with Joe's userId
            }
        }
        
        var token: String {
            switch self {
            case .jane:
                return "" //TODO: swap with a token for Jane
            case .joe:
                return "" //TODO: swap with a token for Joe
            }
        }
    ```

2. Open `MainViewController.swift` file and make sure the following lines exist:

* `import NexmoClient` - imports the sdk
* `var client: NXMClient?` - property for the client instance
* `var call: NXMCall?` - property for the call instance

## Login

Using the Nexmo Client SDK should start with logging in to `NexmoClient`, using a `jwt` user token.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

Open `MainViewController.swift`. Explore the setup methods that were written for you on `viewDidLoad`.

Now locate the following line `//MARK: - Setup Nexmo Client` and complete the `setupNexmoClient` method implementation:

```swift
func setupNexmoClient() {
    client = NXMClient(token: user.token)
    client?.setDelegate(self)
    client?.login()
}
```

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.

Add the required protocol adoption declaration to the class extension located towards the end of the `MainViewController.swift` file:

```swift
extension MainViewController: NXMClientDelegate {
    ...
}
```

The `connectionStatusChanged:reason` methods of the `NXMClientDelegate` protocol indicates if the login was successful and you can start using the SDK.

Add the following method under the `#pragma mark NXMClientDelegate` line.

```swift
func connectionStatusChanged(_ status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
    updateInterface()
}
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.

## Start a Call

You can now make a simple In-App call. If you logged in as Jane, you can call Joe, and if you logged in as Joe you can call Jane - the call button changes its text accordingly.

`Call Jane/Joe` button press is already connected to the `MainViewController`.

Implement the `call:` method to start a call. 

```swift
@IBAction func call(_ sender: Any) {
    // call initiated but not yet active
    if callStatus == .initiated && call == nil {
        return
    }
    // start a new call (check if a call already exists)
    guard let call = call else {
        startCall()
        return
    }
    end(call: call)
}

private func startCall() {

}
private func end(call: NXMCall) {

}
```

If a call is already in progress, taping the button will end it. 

Let's implement `startCall` - it will start the call, and also update the visual elements so that Jane or Joe know the call is in progress:

```swift
private func startCall() {
    callStatus = .initiated
    client?.call([user.callee.userId], callType: .inApp, delegate: self) { [weak self] (error, call) in
        guard let self = self else { return }
        // Handle create call failure
        guard let call = call else {
            if let error = error {
                // Handle create call failure
                print("❌❌❌ call not created: \(error.localizedDescription)")
            } else {
                // Handle unexpected create call failure
                print("❌❌❌ call not created: unknown error")
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

NB: You can have multiple users in a call (`client?.call` method takes an array as its first argument). However, this tutorial demonstrates a 1-on-1 call.

### Call Type
  
Note the second parameter in the `client?.call` method above - while `NXMCallType.inApp` is useful for simple calls, you can also start a call with customized logic [using an NCCO](/client-sdk/in-app-voice/concepts/ncco-guide) ), by choosing `NXMCallType.server` as the `callType`.

```swift
client?.call([calees], callType: .server, delegate: self) { [weak self] (error, call) in
```

This also allows you to start a PSTN phone call, by adding a phone number to the `callees` array.

### Call Delegate

As with `NXMClient`, `NXMCall` also receives a delegate supplied as the third argument in the `call:callType:delegate:completion:` method.  

We'll now adopt the `NXMCallDelegate` as en extension on `MainViewController`:

```swift
extension MainViewController: NXMCallDelegate {

}
```

Copy the following implementation for the `statusChanged` method of the `NXMCallDelegate` along with the aid methods under the `//MARK:- Call Delegate` line:

```swift
func statusChanged(_ member: NXMCallMember!) {
    print("🤙🤙🤙 Call Status changed | member: \(String(describing: member.user.name))")
    print("🤙🤙🤙 Call Status changed | member status: \(String(describing: member.status.description()))")
    
    guard let call = call else {
        // this should never happen
        self.callStatus = .unknown
        self.updateInterface()
        return
    }
    
    // call ended before it could be answered
    if member == call.myCallMember, member.status == .answered, let otherMember = call.otherCallMembers.firstObject as? NXMCallMember, [NXMCallMemberStatus.completed, NXMCallMemberStatus.cancelled].contains(otherMember.status)  {
        self.callStatus = .completed
        self.call?.myCallMember.hangup()
        self.call = nil
    }
    
    // call rejected
    if call.otherCallMembers.contains(member), member.status == .cancelled {
        self.callStatus = .rejected
        self.call?.myCallMember.hangup()
        self.call = nil
    }
    
    // call ended
    if call.otherCallMembers.contains(member), member.status == .completed {
        self.callStatus = .completed
        self.call?.myCallMember.hangup()
        self.call = nil
    }

    updateInterface()
}
```

The `statusChanged:` method notifies on changes that happens to members on the call.  

You can build the project now and make an outgoing call. Next you implement how to receive an incoming call.


## Receive incoming call

When Jane calls Joe, Joe should be notified, so that Joe may decide to answer or decline the call.

This is done by implementing the optional `incomingCall:` method which is declared in the `NXMClientDelegate`.

Go back to the `#pragma mark NXMClientDelegate` line and add the `incomingCall:' method

```swift
func incomingCall(_ call: NXMCall) {
    print("📲 📲 📲 Incoming Call: \(call)")
    DispatchQueue.main.async {
        let names: [String] = call.otherCallMembers?.compactMap({ participant -> String? in
            return (participant as? NXMCallMember)?.user.name
        }) ?? []
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

This method takes as a parameter an `NXMCall` object with which you can answer or decline the call. An alert was implemented to allow the user to choose whether to answer or decline the call.

## Answer a call

Under the `//MARK: Incoming call - Accept`, implement this method to answer the incoming call:

```swift
private func answer(call: NXMCall) {
    self.call = call
    call.answer(self) { [weak self] error in
        if let error = error {
            print("error answering call: \(error.localizedDescription)")
        }
        self?.updateInterface()
    }
}
```

The `answer:completionHandler` method accepts an object adopting the `NXMCallDelegate`, and a `completionHandler`, to indicate if an error occurred in the process. You already implemented `NXMCallDelegate` in a previous step.

## Decline a call

Under the `//MARK: Incoming call - Reject`, implement this method to decline the incoming call:

```swift
private func reject(call: NXMCall) {
    call.decline { [weak self] error in
        if let error = error {
            print("error declining call: \(error.localizedDescription)")
        }
        self?.updateInterface()
    }
}
```

`decline:` accepts a single `completionHandler` parameter to indicate if an error occurred in the process.

## Hangup a call

Once Jane or Joe presses the 'End Call' button, it is time to hangup the call. Implement the private `end:` method and call hangup for `myCallMember`.

```swift
private func end(call: NXMCall) {
    call.myCallMember.hangup()
    callStatus = .completed
    self.call = nil
    updateInterface()
}
```

Updates for `callMember` statuses are received in `statusChanged` as part of the `NXMCallDelegate` as you have seen before.  

The existing implementation for `statusChanged:` is already handling call hangup.

## Handle permissions

For the call to happen, `Audio Permissions` are required. In the `appDelegate` of the sample project, you can find an implementation for the permissions request in `application:didFinishLaunchingWithOptions`.  

To read more about the permissions required, [see the setup tutorial](/tutorials/client-sdk-ios-add-sdk-to-your-app#add-permissions).

## Conclusion

You have implemented your first In App Voice application with the Nexmo Client SDK for iOS.

Run the app on two simulators and see that you can call, answer, decline and hangup.

If possible, test on two phones using your developer signing and provisioning facility.
