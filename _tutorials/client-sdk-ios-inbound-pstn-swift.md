---
title: How to Receive Phone Calls with the Nexmo Client SDK on iOS using Swift
products: client-sdk
description: This tutorial shows you how to create a Nexmo Client SDK application that can receive phone calls on iOS using Swift.
languages:
    - Swift
---

# How to Receive Phone Calls with the Nexmo Client SDK on iOS using Swift

In this guide, we'll learn how to forward an incoming phone call from a Nexmo phone number to an in-app user by implementing a webhook and linking that to a Nexmo application.

You will create a simple app to receive a call.

The app will automatically log in a user called Jane. After logging in, Jane is able to receive a call and perform actions such as answer, decline or hangup.

## Prerequisites

- [Create a Nexmo Application](/tutorials/client-sdk-generate-test-credentials).
- Have a [user for your Nexmo Application, with a valid JWT](/tutorials/client-sdk-generate-test-credentials).
- [Add Nexmo SDK to your project](/tutorials/client-sdk-ios-add-sdk-to-your-app).


## Application webhook

For your application to connect an income phone call to an app user, you'll need to provide a URL as the `Answer URL` webhook - we've created a [gist](https://gist.github.com/NexmoDev/ed91ac99a0b278fbdcbde72ca3599ac7) for you to use.

To add this URL, go to your [Nexmo dashboard](https://dashboard.nexmo.com), navigate to [applications](https://dashboard.nexmo.com/voice/your-applications), select your application and click the 'Edit' button.

Set the application's `Answer URL` to: 

``https://gist.githubusercontent.com/NexmoDev/ed91ac99a0b278fbdcbde72ca3599ac7/raw/4a134363f8b3bbebae27f04095a57d0cebc5a1be/ncco.json``

and click 'Save changes'.

For more information on Nexmo application please visit the Nexmo [API Reference](https://developer.nexmo.com/api/application) and the [Nexmo Call Control Object (NCCO)](https://developer.nexmo.com/voice/voice-api/ncco-reference) reference.

## Create the project

Clone this [Github project](https://github.com/Nexmo/Client-Get-Started-PhoneToApp-Voice-Swift).

Using the Github project you cloned, in the Starter app, with XCode:
    
1. Open `Constants.swift` file and replace the user token:

    ```swift
        enum Constant {
        static var userName = "Jane"
        static var userToken = "" //TODO: swap with a token for Jane
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
    client = NXMClient(token: Constant.userToken)
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

## Receive incoming call

When someone calls the phone nukmber asssociated with your Nexmo app, Jane should be notified, so that Jane may decide to answer or reject the call.

This is done by implementing the optional `incomingCall:` method which is declared in the `NXMClientDelegate`.

Go back to the `#pragma mark NXMClientDelegate` line and add the `incomingCall:' method

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

This method takes as a parameter an `NXMCall` object with which you can answer or reject the call. An alert was implemented to allow the user to choose whether to answer or reject the call.

## Answer a call

Under the `//MARK: Incoming call - Accept`, implement this method to answer the incoming call:

```swift
private func answer(call: NXMCall) {
    self.call = call
    self.call?.setDelegate(self)
    call.answer(self) { [weak self] error in
        if let error = error {
            print("error answering call: \(error.localizedDescription)")
        }
        self?.updateInterface()
    }
}
```

The `answer:completionHandler` method accepts an object adopting the `NXMCallDelegate`, and a `completionHandler`, to indicate if an error occurred in the process. You already implemented `NXMCallDelegate` in a previous step.

## Reject a call

Under the `//MARK: Incoming call - Reject`, implement this method to reject the incoming call:

```swift
private func reject(call: NXMCall) {
    call.reject { [weak self] error in
        if let error = error {
            print("error rejecting call: \(error.localizedDescription)")
        }
        self?.updateInterface()
    }
}
```

`reject:` accepts a single `completionHandler` parameter to indicate if an error occurred in the process.


## Call Delegate

As with `NXMClient`, `NXMCall` also has a delegate. We'll now adopt the `NXMCallDelegate` as an extension on `MainViewController`:

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
    if member.status == .completed {
        self.callStatus = .completed
        self.call?.myCallMember.hangup()
        self.call = nil
    }
    
    updateInterface()
}
```

The `statusChanged:` method notifies on changes that happens to members on the call.  


## Hangup a call

Once Jane presses the 'End Call' button, it is time to hangup the call. Implement the private `end:` method and call hangup for `myCallMember`.

```swift
private func end(call: NXMCall) {
    guard let call = call else {
        updateInterface()
        return
    }
    call.myCallMember.hangup()
}
```

Updates for `callMember` statuses are received in `statusChanged` as part of the `NXMCallDelegate` as you have seen before.  

The existing implementation for `statusChanged:` is already handling call hangup.

## Handle permissions

For the call to happen, `Audio Permissions` are required. In the `appDelegate` of the sample project, you can find an implementation for the permissions request in `application:didFinishLaunchingWithOptions`.  

To read more about the permissions required, [see the setup tutorial](/tutorials/client-sdk-ios-add-sdk-to-your-app#add-permissions).

## Conclusion

You have implemented your first Phone to App Voice application with the Nexmo Client SDK for iOS using Swift.

Run the app on a simulatos and see that you can answer, reject and hangup a call received on the phone number associated with your Nexmo application.

If possible, test on a device using your developer signing and provisioning facility.

