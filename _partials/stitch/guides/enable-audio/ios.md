---
title: iOS
platform: ios
---

# Getting Started with Nexmo In-App Voice for iOS

In this guide we'll cover adding audio events to the Conversation we have created in the [simple conversation with events](/stitch/in-app-messaging/guides/utilizing-events/ios) guide. We'll deal with sending and receiving media events to and from the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Audio Stream** - The stream that the SDK gives you in your browser to listen to audio and send audio
- **Audio Leg** - A server side API term. Legs are a part of a conversation. When audio is enabled on a conversation, a leg is created

### Before you begin

* Ensure you have Node.JS and NPM installed (you'll need it for the Nexmo CLI)
* Ensure you have Xcode installed
* Create a free Nexmo account - [signup](https://dashboard.nexmo.com)
* Install the Nexmo CLI:

    ```bash
    $ npm install -g nexmo-cli@beta
    ```

    Setup the CLI to use your Nexmo API Key and API Secret. You can get these from the [setting page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.

    ```bash
    $ nexmo setup api_key api_secret
    ```

### 1.0 - Start a new iOS project

Open Xcode and start a new project. We'll name it "AudioQuickStart".

### 1.1 Adding the Nexmo Stitch iOS SDK to Cocoapods

Navigate to the project's root directory in the Terminal. Run: `pod init`. Open the file entitled `Podfile`. Configure its specifications accordingly:

```ruby
platform :ios, '10.0'

use_frameworks!

source "https://github.com/Nexmo/PodSpec.git"
source 'git@github.com:CocoaPods/Specs.git'


target 'enable-audio' do

  pod "Nexmo-Stitch" #, :git => "https://github.com/Nexmo/stitch-ios-sdk", :branch => "release" # development

end
```
### 1.2 Adding ViewControllers & .storyboard files

Let's add a few view controllers. Start by adding a custom subclass of `UIViewController` from a CocoaTouch file named `LoginViewController`, which we will use for creating the login functionality, and another custom subclass of `UIViewController` from a CocoaTouch file named `ChatViewController`, which we will use for creating the chat functionality. Add two new scenes to `Main.storyboard`, assigning each to one of the added custom subclasses of `UIViewController` respectively.


### 1.3 Creating the login layout
Let's layout the login functionality. Set constraints on the top & leading attributes of an instance of UIButton with a constant HxW at 71x94 to the top of the Bottom Layout Guide + 20 and the leading attribute of `view` + 16. This is our login button. Reverse leading to trailing for another instance of UIButton with the same constraints. This our chat button. Set the text on these instances accordingly. Add a status label centered horizontally & vertically. Finally, embed this scene into a navigation controller. Control drag from the chat button to scene assigned to the chat controller, naming the segue `chatView`.


### 1.4 - Create the Login Functionality

Below `UIKit` let's import `Stitch`. Next we setup a custom instance of the `ConversationClient` and saving it as a member variable in the view controller.

```swift
/// Nexmo Conversation client
let client: ConversationClient = {
    return ConversationClient.instance
}()
```

We also need to wire up the buttons in `LoginViewController.swift` Don't forget to replace `USER_JWT` with the JWT generated from the Nexmo CLI. For a refresher on how to generate a JWT, check out [quickstart one](/stitch/in-app-messaging/guides/simple-conversation/ios).

```swift
    // status label
    @IBOutlet weak var statusLbl: UILabel!

    // login button
    @IBAction func loginBtn(_ sender: Any) {

        print("DEMO - login button pressed.")

        let token = Authenticate.userJWT

        print("DEMO - login called on client.")

        client.login(with: token).subscribe(onSuccess: {

            print("DEMO - login susbscribing with token.")
            self.statusLbl.isEnabled = true
            self.statusLbl.text = "Logged in"

            if let user = self.client.account.user {
                print("DEMO - login successful and here is our \(user)")
            } // insert activity indicator to track subscription

        }, onError: { [weak self] error in
            self?.statusLbl.isHidden = false

            print(error.localizedDescription)

            // remove to a function
            let reason: String = {
                switch error {
                case LoginResult.failed: return "failed"
                case LoginResult.invalidToken: return "invalid token"
                case LoginResult.sessionInvalid: return "session invalid"
                case LoginResult.expiredToken: return "expired token"
                case LoginResult.success: return "success"
                default: return "unknown"
                }
            }()

            print("DEMO - login unsuccessful with \(reason)")

        }).addDisposableTo(client.disposeBag) // Rx does not maintain a memory reference; to make sure that reference is still in place; keep a reference of this object while I do an operation.
    }

    // chat button
    @IBAction func chatBtn(_ sender: Any) {

        let aConversation: String = "aConversation"
        _ = client.conversation.new(aConversation, withJoin: true).subscribe(onError: { error in

            print(error)

            guard self.client.account.user != nil else {

                let alert = UIAlertController(title: "LOGIN", message: "The `.user` property on self.client.account is nil", preferredStyle: .alert)

                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)

                alert.addAction(alertAction)

                self.present(alert, animated: true, completion: nil)

                return print("DEMO - chat self.client.account.user is nil");

            }

            print("DEMO - chat creation unsuccessful with \(error.localizedDescription)")

        })

        performSegue(withIdentifier: "chatView", sender: nil)
    }
```

### 1.5 Stubbed Out Login

Next, let's stub out the login workflow.

Create an authenticate struct with a member set as `userJWT`. For now, stub it out to always return the value for `USER_JWT`.

```swift
// a stub for holding the value for private.key
struct Authenticate {

    static let userJWT = ""

}
```

After the user logs in, they'll press the "Chat" button which will take them to the ChatViewController and let them begin chatting in the conversation we've already created.

### 1.6 Navigate to ChatViewController

As we mentioned above, creating a conversation results from a call to the `new()` method. In the absence of a server we’ll 'simulate' the creation of a conversation within the app when the user clicks the chatBtn.

When we construct the segue for `ChatViewController`, we pass the first conversation so that the new controller. Remember that the `CONVERSATION_ID` comes from the id generated in [the first quickstart](/stitch/in-app-messaging/guides/simple-conversation/ios).

```swift
// prepare(for segue:)
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    // setting up a segue
    let chatVC = segue.destination as? ChatController

    // passing a reference to the conversation
    chatVC?.conversation = client.conversation.conversations.first

}
```

### 1.7 Create the Chat layout

We'll make a `ChatActivity` with this as the layout. Add an instance of UITextView, UITextField, & UIButton.Set the constraints on UITextView with setting its constraints: .trailing = trailingMargin, .leading = Text Field.leading, .top = Top Layout Guide.bottom, .bottom + 15 = Text Field.top. Set the leading attribute on the Text Field to = leadingMargin and its .bottom attribute + 20 to Bottom Layout Guide's top attribute. Set the Button's .trailing to trailingMargin + 12 and its .bottom attribute + 20 to the Bottom Layout Guide's .top attribute.


### 1.8 Create the ChatActivity

Like last time we'll wire up the views in `ChatViewController.swift` We also need to grab the reference to `conversation` from the incoming view controller.

```swift

import UIKit
import NexmoConversation

class ChatController: UIViewController {

    // conversation for passing client
    var conversation: Conversation?

    // textView for displaying chat
    @IBOutlet weak var textView: UITextView!

    // textField for capturing text
    @IBOutlet weak var textField: UITextField!

}

```

### 1.9 - Sending and receiving `text` Events

To send a message we simply need to call `send()` on our instance of `conversation`. `send()` takes one argument, a `String message`.

```swift
// sendBtn for sending text
@IBAction func sendBtn(_ sender: Any) {

    do {
        // send method
        try conversation?.send(textField.text!)

    } catch let error {
        print(error)
    }

}
```

In `viewDidLoad()` we want to add a handler for handling new events like the TextEvents we create when we press the send button. We can do this like so:

```swift
conversation?.events.newEventReceived.subscribe(onSuccess: { event in
   guard let event = event as? TextEvent, event.isCurrentlyBeingSent == false else { return }
   guard let text = event.text else { return }
   self.textView.insertText(" \(text) \n ")
})
```

## 2.0 - Building Audio

Since we will be tapping into protected device functionality we will have to ask for permission. We will update our `.plist` as well as display an alert. After permissions we will add AVFoundation class, set up audio from within the SDK and add a speaker emoji for our UI 🔈

## 2.1 Xcode Permission

Open up the raw version of the `.plist`. Drop the following lines of code in there.

```
<key>NSMicrophoneUsageDescription</key>
	<string>audio call permission</string>
```

## 2.2 User Permission

Add the AVFoundation library:
```swift
import AVFoundation
```

Create a `setupAudio()` function:

```swift
private func setupAudio() {
    do {
        let session = AVAudioSession.sharedInstance()

        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        session.requestRecordPermission { _ in }
    } catch  {
        print(error)
    }
}
```

## 2.3 Enable / Disable

To add functionality for enable / disable, we simple create functions that call the `.enable()` or `.disable()` methods on media property of our instance of the conversation client like so down below in sections 2.3.1 and 2.3.2

Note that enabling audio in a conversation establishes an audio leg for a member of the conversation. The audio is only streamed to other members of the conversation who have also enabled audio.

### 2.3.1 Enable
Create a function for enable.

```swift
private func enable() {
    do {
        try self.conversation?.media.enable()
    } catch let error {
        self.getView.state.text = "failed: \(error)"
    }
}
```

### 2.3.2 Disable
Create a function for disable.

```swift
@IBAction internal func disable() {
    conversation?.media.disable()

    self.navigationController?.popViewController(animated: true)
}
```

## 2.4 Speaker Emoji for UI

Let's use a speaker emoji for our UI. Drag and drop a UIButton on the left hand side of the UITextField. Control click to drag an action onto `ViewController.Swift`. Name the function like so:

```swift

  @IBAction func phoneButtonPressed(_ sender: UIButton) {

    do {
        try conversation?.media.enable()
        sender.titleLabel?.text = "🔇"
    } catch {
        conversation?.media.disable()
        sender.titleLabel?.text = "🔈"
    }

  }

```

Configure the text property on the button's text label to display either speaker 🔈 for enabled audio or else mute 🔇 for disabled audio.

## 2.5 Console logs

By implementing our enable / disable functions, we will see the updates right there inside of Xcode in the console log.

## Try it out!

After this you should be able to run the app and enable / disable audio. Try it out [here](https://github.com/Nexmo/stitch-ios-quickstart/tree/master/examples/enable-audio)!

The [next guide](/stitch/in-app-voice/guides/calling-users) covers how to easily call users with the convenience method `call()`. This method offers an easy to use alternative for creating a conversation, inviting users and manually enabling their audio streams.
