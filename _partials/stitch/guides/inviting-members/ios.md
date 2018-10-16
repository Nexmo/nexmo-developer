---
title: iOS
platform: ios
---

# Inviting Members with the Nexmo Stitch iOS SDK

In this getting started guide we'll demonstrate creating a second user and inviting them to the Conversation we created in the [simple conversation](/stitch/in-app-messaging/guides/simple-conversation/ios) getting started guide. From there we'll list the conversations that are available to the user and upon receiving an invite to new conversations we'll automatically join them.

## Concepts

This guide will introduce you to the following concepts:

* **Invites** - How do we invite users to a conversation? By programming a call to `.subscription` on an instance of `ConversationClient` to subscribe to events for new invitations.
* **Application Events** - By programming a call to `.subscription` on an instance of `ConversationClient` to subscribe to events for new members.
* **Conversation Events** - By programming a call to `.subscription` on an instance of `ConversationClient` to check membership to a collection of conversations.


### Before you begin


* Ensure you have run through the [previous guide](/stitch/in-app-messaging/guides/simple-conversation/ios)
* Make sure you have two iOS devices to complete this example. They can be two simulators, one simulator and one physical device, or two physical devices.

> Note: We do not currently support any drag & drop UIs yet so we'll build on the last UI.


## 1 - Setup

> Note: The steps within this section can all be done dynamically via server-side logic. But in order to get the client-side functionality we're going to manually run through the setup.

### 1.1 - Create another User

Create another user who will participate within the conversation:

```bash
$  nexmo user:create name="alice"
```

The output of the above command will be something like this:

```bash
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

That is the User ID. Take a note of it as this is the unique identifier for the user that has been created. We'll refer to this as `SECOND_USER_ID` later.

### 1.2 - Generate a User JWT

Generate a JWT for the user. The JWT will be stored to the `SECOND_USER_JWT` variable. Remember to change the `YOUR_APP_ID` value in the command.

```bash
$ SECOND_USER_JWT="$(nexmo jwt:generate ./private.key sub=alice exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=YOUR_APP_ID)"
```

_Note: The above command sets the expiry of the JWT to one day from now._

You can see the JWT for the user by running the following:

```bash
$ echo $SECOND_USER_JWT
```

## 2 Update the iOS App

We will use the application we already created for [the first getting started guide](/stitch/in-app-messaging/guides/simple-conversation/ios). With the basic setup in place we can now focus on updating the client-side application.

### 2.1 Update the stubbed out Login

Now, let's update the login workflow to accommodate a second user.

Define a variable with a value of the second User JWT that was created earlier and set the value to the `SECOND_USER_JWT` that was generated earlier.

```swift
// a stub for holding the value of private.key
struct Authenticate {

    static let userJWT = "USER_JWT"
    static let anotherUserJWT = "SECOND_USER_JWT"

}
```

Update the authenticate function with an instance of `UIAlertController` with an action for one user, another for another user.


```swift
   // login button
    @IBAction func loginBtn(_ sender: Any) {

        print("DEMO - login button pressed.")

        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("jamie", comment: "First User"), style: .`default`, handler: { _ in
            NSLog("The \"First User\" is here!")

            let token = Authenticate.userJWT

            print("DEMO - login called on client.")

            self.client.login(with: token).subscribe(onSuccess: {

                if let user = self.client.account.user {

                    print("DEMO - login successful and here is our \(user)")

				 }, onError: { [weak self] error in

                self?.statusLbl.isHidden = false

                print(error.localizedDescription)

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

            }).addDisposableTo(self.client.disposeBag) // Rx does not maintain a memory reference; to make sure that reference is still in place; keep a reference of this object while I do an operation.

                }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("alice", comment: "Second User"), style: .default, handler: { (_) in

            NSLog("The \"Second User\" is here!")

            let token = Authenticate.anotherUserJWT

            print("DEMO - login called on client.")

            self.client.login(with: token).subscribe(onSuccess: {

                if let user = self.client.account.user {
                    print("DEMO - login successful and here is our \(user)")

                  }, onError: { [weak self] error in

                self?.statusLbl.isHidden = false

                print(error.localizedDescription)

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

            }).addDisposableTo(self.client.disposeBag) // Rx does not maintain a memory reference; to make sure that reference is still in place; keep a reference of this object while I do an operation.

                }))

        DispatchQueue.main.async {

            self.present(alert, animated: true, completion: nil)
        }

    }
```

We'll be running this device on two different devices (on an iOS simulator and a physical devices), so we'll make sure to log one user on one device, another user on another device. ask which user you're logging in as.

### 2.2 Listening for Conversation invites and accepting them

The next step is to update the login method to listen to changes in conversations' array on the `client.conversation` that we will configure to subscribe to events for users invited to a conversation. Once a user receives an invite, we're going to automatically join the user to that Conversation.

```swift
 // whenever the conversations array is modified
                    self.client.conversation.conversations.asObservable.subscribe(onNext: { (change) in
                        switch change {
                        case .inserted(let conversations, let reason):
                            switch reason {
                            case .invitedBy(let member):
                                conversations.first?.join().subscribe(onSuccess: { _ in
                                    print("You have joined this conversation: \(String(describing:conversations.first?.uuid))")
                                }, onError: { (error) in
                                    print(error.localizedDescription)
                                })
                            default:
                                break
                            }
                        default:
                            break
                        }
                    })
```

As soon as the invite is received, the user subscribes to the conversation.

### 2.3 List the Conversations and handle selecting one

As soon as the user subscribes to a conversation, we check to see whether the user joined the conversation or not.

```swift

		// figure out which conversation a member has joined
		_ = self.client.conversation.conversations.filter({ (conversation) -> Bool in
		conversation.members.contains(where: { (member) -> Bool in
		return member.user.isMe && member.state == .joined
		})
	})
```


We'll loop through the conversations the user is a member to make sure that the user is joined to the desired conversation.

### 2.4 - Run the apps

Run the apps on both the simulator & device. On one of them, login "jamie". On the other login "alice".

### 2.5 - Invite the second user to the conversations

Finally, let's invite the user to the conversation that we created. In your terminal, run the following command and remember to replace `YOUR_APP_ID` and `YOUR_CONVERSATION_ID` ID of the Application and Conversation you created in the first guide and the `SECOND_USER_ID` with the one you got when creating the User for `alice`.

```bash
$ nexmo member:add YOUR_CONVERSATION_ID action=invite channel='{"type":"app"}' user_id=SECOND_USER_ID
```

The output of this command will confirm that the user has been added to the "Nexmo Chat" conversation.

```bash
Member added: MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

You can also check this by running the following request, replacing `YOUR_CONVERSATION_ID`:

```bash
$ nexmo member:list YOUR_CONVERSATION_ID -v
```

Where you should see an output similar to the following:

```bash
name                                     | user_id                                  | user_name | state  
---------------------------------------------------------------------------------------------------------
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | jamie     | JOINED
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | alice     | INVITED

```

Return to your emulators so you can see `alice` has a conversation listed now. You can click the conversation name and proceed to chat between `alice` and `jamie`.

## Try it out

Once you've completed this quickstart, you can run the sample app on two different devices. You'll be able to login as a user, join an existing conversation or receive invites, and chat with users.
