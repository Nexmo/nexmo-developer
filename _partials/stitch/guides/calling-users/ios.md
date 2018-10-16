---
title: iOS
platform: ios
---

# Call Convenience methods for Stitch and iOS

In this getting started guide we'll cover adding call methods to the Conversation we created in the [simple conversation with audio](/stitch/in-app-voice/guides/enable-audio/ios) getting started guide. We'll deal with member call events that trigger on the application and call state events that trigger on the Call object.

The main difference between using these Call convenience methods and enabling and disabling the audio in the previous quickstart is that these methods do a lot of the heavy lifting for you. By calling a user directly, a new conversation is created, and users are automatically invited to the new conversation with audio enabled. This can make it easier to start a separate direct call to a user or start a private group call among users.

## Concepts

This guide will introduce you to the following concepts.

- **Calls** - calling an User in your application without creating a Conversation first
- **Call Events** - CallEvent event that fires on an `ConversationClient` or `Call`


### Before you begin
- Ensure you have run through the [previous guide](/stitch/in-app-voice/guides/enable-audio/ios) 

### 1.0 - Updating iOS App

We will use the application we already created for [the first audio getting started guide](/stitch/in-app-voice/guides/enable-audio/ios). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 1.1 Modify the ChatController with `.storyboard` files 
To modify the `.storyboard` to accommodate a call convenience method, let's perform the following changes: 

- Inside of the scene for `ChatViewController.swift` add an instance of `UIBarButtonItem` to the upper right hand corner of the `UINavigationController`. 

- Control drag from the instance to the `ChatViewController.swift` to create an action we will program later. 

- Inside of this action simply write the following: `call()`. 

### 1.2 Call Emoji! 📞

With the `UIBarButtonItem` properly laid out in `.storyboard` the next step is to configure its UI with a Call Emoji! 📞

- Under the attributes inspector in the utilities menu change the `UIBarButtonItem`'s System Item to Custom. 
- Inside of the Bar Item's properties, select title. 
- Inside of the Bar Item's title property add a 📞!

### 1.3 ☎️ `call` convenience method 

How will we configure the `UIBarButton`'s action? We will configure it with our `call` convenience method, which is built on top of our existing architecture for the `client. We access call functionality through class called `media`. In the `media` class there is a single method for handling calls, called `call`. There were no puns intended here! ;) 


```swift
do {
    let users = ["user1", "user2"]

    try client.media.call(users, onSuccess: { result in
        // result contains Call object and any errors from requesting invites for users
    }, onError: { networkError in
        // if you would like to work on the networkError, you can here.
    })
} catch let error {
    // if it is some other error, you can catch it here.
}
``` 

The method is really simple. It takes an array of users. It handles connecting with each one of the elements in the user array. Before we program it for real. Let's make sure our UI for chat is setup. 

## 2.0 

To ensure the chat is setup, we will configure an instance of `UITableView` to handle messages in the chat. To implement the `UITableView`, take the following steps: 

- Add an instance of `UITableView` to the scene for `ChatViewController` in `.storyboard`
- Control drag to create an reference in `ChatViewController`
- Inside of `ChatViewController`'s `viewDidLoad(:)` configure both the `dataSource` and `delegate` properties on our reference to `tableView` to `.self`. 
- Last but not least we will add an extension to ensure conformity to the required methods:

```swift
extension ChatController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation!.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithIdentifier", for: indexPath)
        
        let message = conversation?.events[indexPath.row] as? TextEvent
        
        cell.textLabel?.text = message?.text
        
        return cell;
    }

} 
``` 
With our chat set up, we are ready to move onto setting up the call method. 

## 2.0 -  📞 + ☎️ equals a call

Earlier we dropped the following in an action for our call emoji 📞: `call()`. We will program this function with our call convenience method now. Below `viewDidLoad()` declare a private function called `call()` like so: 

```swift 
private func call() {
}
``` 

Inside of this method copy and paste the code snippet from earlier with our actual call method. 

```swift 
private func call() {

   client.media.call(users, onSuccess: { result in
        // result contains Call object and any errors from requesting invites for users
    }, onError: { networkError in
        // if you would like to work on the networkError, you can here.
    })

}
``` 
We no longer need the generic do-try-catch. Inside of the function, however, we will add an instance of `UIAlertController`. We will loop over each member in the a conversation displayed in the `UITableView` with the higher order function `.forEach` so that we add an action for calling each member to the activity sheet:

```swift
    // MARK: - Call Convenience Methods
    private func call() {
        
        let callAlert = UIAlertController(title: "Call", message: "Who would you like to call?", preferredStyle: .sheet)
        
        conversation?.members.forEach{ member in
            callAlert.addAction(UIAlertAction(title: member.user.username, style: .default, handler: {
                
                    ConversationClient.instance.media.call(member.user.username, onSuccess: { result in
                        // if you would like to display a UI for calling...
                    }, onError: { networkError in
                        // if you would like to display a log for error...
                    })
            }))
        }
        
        self.present(callAlert, animated: true, completion: nil)

    }
```
## 3.0 Try it out!

There it is. If a member is present in the chat, then he or she may be called. Open the app on two devices. Now run the app on two devices (make sure they have a working mic and speakers!), making sure to login with one user name in one and with another in the other. Call one from the other, accept the call and start talking. You'll also see events being logged. If you would like, you can compare codebases [here](https://github.com/Nexmo/stitch-ios-quickstart/tree/master/examples/convenience-calling). 

# Calling a Stitch user from a phone

After you've set up you're app to handle incoming calls, you can follow [the PSTN to IP tutorial](https://www.nexmo.com/blog/2018/05/13/connect-phone-call-to-stitch-in-app-voice-dr/) published on our blog to find out how you can connect a phone call to a Stitch user. Now you can make PSTN Phone Calls via the Nexmo Voice API and receive those calls via the Stitch SDK. 

# Where next?

Have a look at the Nexmo [Conversation iOS SDK API Reference](https://developer.nexmo.com/sdk/stitch/ios/). 

