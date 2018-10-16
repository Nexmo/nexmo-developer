---
title: iOS
platform: ios
---

# Getting Started with the Nexmo Stitch iOS SDK

In this getting started guide we'll demonstrate how to build a simple conversation app with IP messaging using the Nexmo Stitch iOS SDK.

## Concepts

This guide will introduce you to the following concepts.

* **Nexmo Applications** - contain configuration for the application that you are building
* **JWTs** ([JSON Web Tokens](https://jwt.io/)) - the Stitch API uses JWTs for authentication. JWTs contain all the information the Nexmo platform needs to authenticate requests. JWTs also contain information such as the associated Applications, Users and permissions. It helps you as well as Nexmo facilitate the retention & analysis of metadata for future AI implementations.
* **Users** - users who are associated with the Nexmo Application. It's expected that Users will have a one-to-one mapping with your own authentication system.
* **Conversations** - A thread of conversation between two or more Users.
* **Members** - Users that are part of a conversation.

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

## 1 - Setup

_Note: The steps within this section can all be done dynamically via server-side logic. But in order to get the client-side functionality we're going to manually run through setup._

### 1.1 - Create a Nexmo application

Create an application within the Nexmo platform.

```bash
$ nexmo app:create "Stitch iOS App" http://example.com/answer http://example.com/event --type=rtc --keyfile=private.key
```

Nexmo Applications contain configuration for the application that you are building. The output of the above command will be something like this:

```bash
Application created: aaaaaaaa-bbbb-cccc-dddd-0123456789ab
No existing config found. Writing to new file.
Credentials written to /path/to/your/local/folder/.nexmo-app
Private Key saved to: private.key
```

The first item is the Application ID and the second is a private key that is used generate JWTs that are used to authenticate your interactions with Nexmo. You should take a note of it. We'll refer to this as `YOUR_APP_ID` later.


### 1.2 - Create a Conversation

Create a conversation within the application:

```bash
$ nexmo conversation:create display_name="Nexmo Chat"
```

The output of the above command will be something like this:

```sh
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

That is the Conversation ID. Take a note of it as this is the unique identifier for the conversation that has been created. We'll refer to this as YOUR_CONVERSATION_ID later.

### 1.3 - Create a User

Create a user who will participate within the conversation.

```bash
$ nexmo user:create name="jamie"
```

The output will look as follows:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Take a note of the `id` attribute as this is the unique identifier for the user that has been created. We'll refer to this as `YOUR_USER_ID` later.

### 1.4 - Add the User to the Conversation

Finally, let's add the user to the conversation that we created. Remember to replace `YOUR_CONVERSATION_ID` and `YOUR_USER_ID` values.

```bash
$ nexmo member:add YOUR_CONVERSATION_ID action=join channel='{"type":"app"}' user_id=YOUR_USER_ID
```

The output of this command will confirm that the user has been added to the "Nexmo Chat" conversation.

```sh
Member added: MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

You can also check this by running the following request, replacing `YOUR_CONVERSATION_ID`:

```bash
$ nexmo member:list YOUR_CONVERSATION_ID -v
```

Where you should see a response similar to the following:

```sh
name                                     | user_id                                  | user_name | state  
---------------------------------------------------------------------------------------------------------
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | jamie     | JOINED
```

### 1.5 - Generate a User JWT

Generate a JWT for the user and take a note of it. Remember to change the `YOUR_APP_ID` value in the command.

```bash
$ USER_JWT="$(nexmo jwt:generate ./private.key sub=jamie exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=YOUR_APP_ID)"
```

*Note: The above command saves the generated JWT to a `USER_JWT` variable. It also sets the expiry of the JWT to one day from now.*

You can see the JWT for the user by running the following:

```bash
$ echo $USER_JWT
```

### 1.6 The Nexmo Stitch API Dashboard

If you would like to double check any of the JWT credentials, navigate to [your-applications](https://dashboard.nexmo.com/voice/your-applications) where you can see a table with three entries respectively entitled "Name", "Id", or "Security settings". Under the menu options for "Edit" next to "Delete", you can take a peak at the details of the applications such as "Application name", "Application Id", etc...

## 2 - Create the iOS App

With the basic setup in place we can now focus on the client-side application

### 2.1 Start a new project

Open Xcode and start a new project. We'll name it "QuickStartOne".

### 2.2 Adding the Nexmo Stitch iOS SDK to Cocoapods

Navigate to the project's root directory in the Terminal. Run: `pod init`. Open the file entitled `PodFile`. Configure its specifications accordingly:

```bash
# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

source "https://github.com/Nexmo/PodSpec.git"
source 'git@github.com:CocoaPods/Specs.git'

target 'QuickStartOne' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod "Nexmo-Stitch" #, :git => "https://github.com/Nexmo/stitch-ios-sdk", :branch => "release" # development
end
```
### 2.3 Adding ViewControllers & .storyboard files

Let's add a few view controllers. Start by adding a custom subclass of `UIViewController` from a CocoaTouch file named `LoginViewController`, which we will use for creating the login functionality, and another custom subclass of `UIViewController` from a CocoaTouch file named `ChatViewController`, which we will use for creating the chat functionality. Add two new scenes to `Main.storyboard`, assigning each to one of the added custom subclasses of `UIViewController` respectively.


### 2.4 Creating the login layout
Let's layout the login functionality. Set constraints on the top & leading attributes of an instance of UIButton with a constant HxW at 71x94 to the top of the Bottom Layout Guide + 20 and the leading attribute of `view` + 16. This is our login button. Reverse leading to trailing for another instance of UIButton with the same constraints. This our chat button. Set the text on these instances accordingly. Add a status label centered horizontally & vertically. Finally, embed this scene into a navigation controller. Control drag from the chat button to scene assigned to the chat controller, naming the segue `chatView`.


### 2.5 - Create the Login Functionality

Below `UIKit` let's import the `NexmoConversation`. Next we setup a custom instance of the `ConversationClient` and saving it as a member variable in the view controller.

```swift
    /// Nexmo Conversation client
    let client: ConversationClient = {
        return ConversationClient.instance
    }()
```

We also need to wire up the buttons in `LoginViewController.swift` Don't forget to replace `USER_JWT` with the JWT generated from the Nexmo CLI in step 1.5.

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

### 2.6 Stubbed Out Login

Next, let's stub out the login workflow.

Create an authenticate struct with a member set as `userJWT`. For now, stub it out to always return the value for `USER_JWT`.

```swift
// a stub for holding the value for private.key
struct Authenticate {

    static let userJWT = ""

}
```

After the user logs in, they'll press the "Chat" button which will take them to the ChatViewController and let them begin chatting in the conversation we've already created.

### 2.5 Navigate to ChatViewController

As we mentioned above, creating a conversation results from a call to the new() method. In the absence of a server we’ll ‘simulate’ the creation of a conversation within the app when the user clicks the chatBtn.

When we construct the segue for `ChatViewController`, we pass the first conversation so that the new controller. Remember that the `CONVERSATION_ID` comes from the id generated in step 1.2.

```swift
    // prepare(for segue:)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // setting up a segue
        let chatVC = segue.destination as? ChatController

        // passing a reference to the conversation
        chatVC?.conversation = client.conversation.conversations.first


    }
```

### 2.6 Create the Chat layout

We'll make a `ChatActivity` with this as the layout. Add an instance of UITextView, UITextField, & UIButton.Set the constraints on UITextView with setting its constraints: .trailing = trailingMargin, .leading = Text Field.leading, .top = Top Layout Guide.bottom, .bottom + 15 = Text Field.top. Set the leading attribute on the Text Field to = leadingMargin and its .bottom attribute + 20 to Bottom Layout Guide's top attribute. Set the Button's .trailing to trailingMargin + 12 and its .bottom attribute + 20 to the Bottom Layout Guide's .top attribute.


### 2.7 Create the ChatActivity

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

### 2.8 - Sending `text` Events

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

### 2.9 - Receiving `text` Events

In `viewDidLoad()` we want to add a handler for handling new events like the TextEvents we create when we press the send button. We can do this like so:

```swift
        // a handler for updating the textView with TextEvents
        conversation?.events.newEventReceived.addHandler { event in
            guard let event = event as? TextEvent, event.isCurrentlyBeingSent == false else { return }
            guard let text = event.text else { return }

            self.textView.insertText("\n \n \(text) \n \n")
        }
```

## Try it out

After this you should be able to run the app and send messages. Try it out [here](https://github.com/Nexmo/stitch-ios-quickstart/tree/master/examples/QuickStartOne). 
