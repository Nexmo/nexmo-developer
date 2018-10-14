---
title: iOS
platform: ios
---

# Using more Event Listeners with the Nexmo Stitch In-App Messaging iOS SDK

In this getting started guide we'll demonstrate how to show previous history of a Conversation we created in the [simple conversation](/stitch/in-app-messaging/guides/simple-conversation/ios) getting started guide. From there we'll cover how to show when a member is typing.

## 1 - Setup

* Ensure you have run through the [the first](/stitch/in-app-messaging/guides/simple-conversation/ios) and [second](/stitch/in-app-messaging/guides/inviting-members/ios) quickstarts.
* Make sure you have two iOS devices to complete this example. They can be two simulators, one simulator and one physical device, or two physical devices.

## 2 Update the iOS App

We will use the application we already created for quickstarts [1](/stitch/in-app-messaging/guides/simple-conversation/ios) and [2](/stitch/in-app-messaging/guides/inviting-members/ios). With the basic setup in place we can now focus on updating the client-side application. We can leave `LoginViewController.swift` alone. For this demo, we'll solely focus on the `ChatViewController.swift`.

### 2.1 Updating the app layout

We're going to be adding some new elements to our chat app so let's update our layout to reflect them.

#### 2.1.1 `UITableView`

Let us start with an instance of `UITableView` whose cells we will use to display messages from the chat. In our `.xcodeproj` navigate to `ChatViewController` scene in `Main.storyboard`. Let us now delete the instance of `textView`.

Let us control drag an instance of `UITableView` onto the  scene in the `textView`'s spot. After adding the `UITableView` to storyboards, let us constrain its leading, trailing and top guides to the surrounding Safe Area respectively. We want to set the leading and trailing space to the Safe Area at 16 points. Let us set the constraint for the top layout guide to the top of the Safe Area layout at zero points.  

Do not forget to add a prototype cell. Control drag from the object library to add a prototype cell to the top of our instance of `UITableView`. To finalize the addition let us name the cell: `messageCell` because the reusable cells will house messages!

#### 2.1.2 UILabel

Add an instance of `UILabel` just below our instance of `UITableView` but above our instance of `TextField`. Later we will call it `typingIndicator` so that we show a message in the `typingIndicator` when a user is typing.


### 2.2 Adding the new UI to the `ChatViewController`

In the previous quick starts we showed messages by adding to a TextView. For this example we'll show you how to use the iOS SDK with an instance of `UITableView`. Let's add our new UI outlets to from the view to their controller `ChatViewController`.

To create a connection from our instance of `UITableView` to its controller in `ChatViewController.swift` we set the `delegate` or `dataSource` properties referentially. With `Main.storyboard` open while simultaneously holding shift option command, click on `ChatViewController.swift` so that it appears in the assistant editor. Control drag from within the body of `UITableView` to `ChatViewController.swift` to declare `tableView` as an outlet as such:

```swift
class ChatViewController: UIViewController {
    // tableView for displaying chat
    @IBOutlet weak var tableView: UITableView!
}
```

Similarly, let us do the same for our instance of `UILabel` in the following way:

```swift
class ChatViewController: UIViewController {
	// typingIndicatorLabel for typing indications
	@IBOutlet weak var typyingIndicatorLabel: UILabel!
}
```

### 2.3 Wiring up the Delegate and Datasource

Our instance of `UITableView` will need a `delegate` and `dataSource`. In `viewDidLoad(:)` we can use this:

```swift
// assignment of delegate to our ChatViewController
tableView.delegate = self
// assignment of dataSource to our ChatViewController
tableView.dataSource = self
```

Designating `ChatViewController` as delegate for the `UITableView` means that the `ChatViewController` agrees to act on behalf of the `UITableView` to take care of whatever delegate methods are required for our instance of `UITableView`. Similarly, designating `ChatViewController` as the dataSource means that the `ChatViewController` agrees to act on behalf of the `UITableView` to handle methods required for funneling data into the UITableView. Accordingly, we must now program these methods. This is called 'conforming'.

### 2.3.1 Programming Delegate and Datasource

If you followed the steps in 2.3, then you should immediately receive a warning saying that "Type `ChatViewController.swift` does not conform to the protocol `UITableViewDataSource`". If you do, great! It means our instance of `tableView` is configured to its controller. Let's make it conform to the protocol now!

In order to make it conform to the `UITableViewDataSource` protocol we will make use of one of Swift's powerful features: an `extension`. Down below the class's closing bracket for its declaration, declare an extension for `ChatViewController`.

Since this extension conforms to `UITableViewDelegate`, we program it thus:

```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	return 0
}
```

Since the last remaining required method for conforming to the protocol for `UITableViewDataSource` is `cellForRowAt`, we will add the method in the following way:

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithIdentifier", for: indexPath)
	return cell;
}

```
Implementing these two methods should remedy the error mentioned earlier. Both methods--`numberOfRowsInSection` and `cellForRowAt`, however, are boilerplate. In the next section we configure these methods to interact directly with our instance of `ConversationClient` to show chat history.

### 2.4 - Show a chat's history

Let us reconfigure the boilerplate code with properties from our instance of the conversation client.

#### 2.4.1 `numberOfRowsInSection`

Let's start `numberOfRowsInSection`. We access the `conversations` property on `conversation` that we passed through `performSegue(withIdentifier:sender)` from the `LoginViewController.swift`. On the `events` property, which conforms to Swift's `CollectionType`, there is a property for `.count`, which returns the number of messages in a chat's history. It happens like so:

```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	return conversation!.events.count
}
```

Our instance of `tableView` ought to return as many rows now as there are events in our instance of `conversation`, whereas earlier it returned none. If it does, we are halfway there! The next step is to configure `cellForRowAt` to display the events as messages in the prototype cell's `textLabel.text` property. We do it by downcasting an event per the row in `indexPath` as `TextEvent` that is assigned to the value of constant called `message`. With `message` containing the value for each row's messages, we assign it to the value for `cell.textLabel?.text`. It happens like so:


```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithIdentifier", for: indexPath)

	let message = conversation?.events[indexPath.row] as? TextEvent

	cell.textLabel?.text = message?.text

	return cell;
}

```

The next step is to ensure that our instance of `tableView` updates so in `sendBtn(:)` we call `tableView.reload()`.

Calling `tableView.reload()` on a conversation retrieves the event history. Now when we trigger a segue and open the `ChatViewController.swift`, we'll have the history of the chat loaded in our instance of `UITableView`.

### 2.5 - Adding Typing and Seen Listeners

We can add other listeners just like we added our other for subscribing to text events. Our next listener follows from the `.members` property as opposed to the `events` property on `conversation`. Whereas the latter is a collection of events, the former is a collection of members so we can loop through each one of the members with one of Swift's higher order functions like `.forEach` to subscribe to make a call to a handler. The handler then takes care of who is or is not typing.

```swift
conversation!.members.forEach { member in
	member.typing
	    .mainThread
	    .subscribe(onSuccess: { [weak self] in self?.handleTypingChangedEvent(member: member, isTyping: $0) })
}
```

With our listener configured, we will `programhandleTypingChangedEvent(member:, isTyping:)` to figure out whether a member is typing, determine how many members are typing, as well as provide text to be displayed in our instance of `UILabel` for displaying the typing indications. It happens like so:

```swift
func refreshTypingIndicatorLabel(){
    if !whoIsTyping.isEmpty {
        var caption = whoIsTyping.joined(separator: ", ")

        if whoIsTyping.count == 1 {
            caption += " is typing..."
        } else {
            caption += " are typing..."
        }

        typyingIndicatorLabel.text = caption

    } else {
        typyingIndicatorLabel.text = ""

    }
}        
```

The last step is to add a property called `whoIsTyping` to our `ChatViewController.swift` file. We will declare to be of type `Set<>` whose elements, all of whom are unique, will be of type `String` so that no member may be duplicated by virtue of the strong typing on the data structure itself:

```swift
// a set of unique members typing
private var whoIsTyping = Set<String>()
```

With these three sets of code in place, the typing indicator updates who is typing when!

# Trying it out

Once you've completed this quickstart, you can run the sample app on two different devices. You'll be able to login as a user, join an existing conversation, chat with users, and show a typing indicator.
