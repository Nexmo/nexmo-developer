---
title:  Chat events
description:  In this step you will handle chat events.

---

Chat events
===========

Earlier you created a conversation in the Nexmo CLI and added the two users to that conversation. Conversations, modeled as `NXMConversation` objects in the Client SDK, are how the users will communicate. You can learn more about conversations in the [Conversation API documentation](/conversation/concepts/conversation). Chat events, or `NXMEvent` objects, are sent using the conversation that you created, so to get chat event you will first need to fetch the conversation. To implement this, the additions to `ChatViewController.swift` shown in the following sections are required.

Add properties for the conversation and events, below the `conversationTextView`:

```swift
class ChatViewController: UIViewController {
    ...
    let conversationTextView = UITextView()

    var conversation: NXMConversation?
    var events: [NXMEvent]? {
        didSet {
            processEvents()
        }
    }
    ...
}
```

Add a function call to `getConversation` at the end of the `viewDidLoad` function:

```swift
override func viewDidLoad() {
    ...

    getConversation()
}
```

Add the functions to get the conversation, events and process those events a the end of the `ChatViewController.swift` file:

```swift
class ChatViewController: UIViewController {
    ...
    func getConversation() {
        client.getConversationWithUuid(user.conversationId) { [weak self] (error, conversation) in
            self?.conversation = conversation
            if conversation != nil {
                self?.getEvents()
            }
            conversation?.delegate = self
        }
    }
    
    func getEvents() {
        guard let conversation = self.conversation else { return }
        conversation.getEventsPage(withSize: 100, order: .asc) { (error, page) in
            self.events = page?.events
        }
    }
    
    func processEvents() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.conversationTextView.text = ""
            self.events?.forEach { event in
                if let memberEvent = event as? NXMMemberEvent {
                    self.showMemberEvent(event: memberEvent)
                }
                if let textEvent = event as? NXMTextEvent {
                    self.showTextEvent(event: textEvent)
                }
            }
        }
    }
    
    func showMemberEvent(event: NXMMemberEvent) {
        switch event.state {
        case .invited:
            addConversationLine("(event.member.user.name) was invited.")
        case .joined:
            addConversationLine("(event.member.user.name) joined.")
        case .left:
            addConversationLine("(event.member.user.name) left.")
        @unknown default:
            fatalError("Unknown member event state.")
        }
    }

    func showTextEvent(event: NXMTextEvent) {
        if let message = event.text {
            addConversationLine("(event.fromMember?.user.name ?? "A user") said: '(message)'")
        }
    }

    func addConversationLine(_ line: String) {
        if let text = conversationTextView.text, text.count > 0 {
            conversationTextView.text = "(text)\n(line)"
        } else {
            conversationTextView.text = line
        }
    }
}
```

`getConversation` uses the conversation ID from the Nexmo CLI to fetch the conversation, if that is successful `getEvents` is called to fetch the chat events. The Client SDK supports pagination so to get the chat events you must specify a page size.

Once the events are fetched they are processed by `processEvents`. In `processEvents` there is type casting to either a `NXMMemberEvent` or a `NXMTextEvent` which get append to the `conversationTextView` by `showMemberEvent` and `showTextEvent` respectively. You can find out more about the supported event types in the [Conversation API documentation](/conversation/concepts/event).

The Conversation Delegate
-------------------------

The application also needs to react to events in a conversation after loading initially so you need to have `ChatViewController` conform to `NXMConversationDelegate`. At the end of the file, add:

```swift
extension ChatViewController: NXMConversationDelegate {
    func conversation(_ conversation: NXMConversation, didReceive error: Error) {
        NSLog("Conversation error: (error.localizedDescription)")
    }

    func conversation(_ conversation: NXMConversation, didReceive event: NXMTextEvent) {
        self.events?.append(event)
    }
}
```

When a new event is received it is appended to the `events` array which in turn starts the processing of the events again.

Build and Run
-------------

Press `Cmd + R` to build and run again. After logging in you will see that both users have joined the conversation as expected:

![Chat interface with connection events](/images/client-sdk/ios-messaging/chatevents.png)

