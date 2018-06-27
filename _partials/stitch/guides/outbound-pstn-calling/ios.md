---
title: iOS
platform: ios
---

# Outbound PSTN Calling for iOS with Swift

In this getting started guide we'll cover how to make an outbound PSTN call from your iOS app using the Nexmo Stitch SDK.

## Concepts

This guide will cover the following concepts:

 - **Calls** - calling a PSTN number in your application without creating a Conversation first
 - **Call State** - A state a call can be in. Either `STARTED`, `RINGING`, or `ANSWERED`

## Before you begin

You should read the [Outbound PSTN Calling NCCO guide](/stitch/in-app-voice/ncco-guide) before completing this quickstart. In order to make an outbound PSTN call, you'll have to correctly link your application to an answer url with an NCCO. The NCCO guide goes into further detail.

## Setting up an iOS Project

To set up the Nexmo In-App to Phone Calling in iOS with Swift, you will need to setup both the UI and the methods. Here we'll program methods and then wire them up.

### Programming the methods

First you'll need the latest version of the Nexmo Stitch SDK in your `ViewController.swift`.

```swift
import Stitch
```

Now that you have the SDK included in your project, you'll ned to create a new instance of the `ConversationClient`. You can do this in your `ViewController.swift` where you'll be making your outbound PSTN call.

 ```swift
 private var call: Call?
 ```

 ```swift
override func viewDidLoad() {
    super.viewDidLoad()
    ConversationClient.configuration = Configuration.init(with: .info)
    ConversationClient.instance
       .login(with: "JWT_TOKEN")
       .subscribe()
}
 ```

In this example we're assuming the user has already logged in with the `conversationClient.login()` method. For more details about how to implement that read the [simple conversation quickstart](/stitch/in-app-messaging/guides/1-simple-conversation/ios).

 ```swift
@IBAction
func makeCall() {
     guard let number = textfield.text else { return }

     ConversationClient.instance.media.callPhone(number, onSuccess: { result in
         self.call = result.call

          print("DEMO - Created call")
      }) { error in
          print("DEMO - Failed to make call: \(error)")
      }
}
 ```


```swift
@IBAction
func hangup() {
     call?.hangUp(onSuccess: {
         print("DEMO - Hangup call successful")
     })
}
```

### Programming the UI

To configure the UI were going to add two instances of UIButton below an instance of UITextField.

- add an instance of UITextField
- add an instance of UIButton but inside of its label, make sure to add a telephone 📞 emoji!
- add an instance of UIButton but inside of its label, make sure to add a stop sign 🛑 emoji!

Make sure that you wire up each one of these UI elements to their respective properties or methods.

# Try it out!

After you've followed along with this quickstart, you will be able to make a call to a PSTN phone. Don't forget to include the country code when you make a call! For example if you're calling a phone number in the USA, the phone number will need to begin with a 1. When calling a phone number in Great Britain the phone number will need to be prefixed with 44.

## Where next?

You can view the source code for this [quickstart on GitHub](https://github.com/Nexmo/stitch-ios-quickstart/tree/master/examples/ip-pstn_phone-calling/ip-pstn_phone-calling).
