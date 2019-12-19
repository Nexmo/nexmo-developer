---
title: Swift
language: swift
menu_weight: 1
---


Right below  `getConversation()`, let's add a method to retrieve the events:

```swift
func getEvents() {
    guard let conversation = self.conversation else {
        return
    }
    conversation.getEvents { [weak self] (error, events) in
        self?.error = error
        self?.events = events
        self?.updateInterface()
    }
}
```

Once the events are retrieved (or an error is returned), we're updating the interface to reflect the new data.

Inside `updateInterface()` locate the `// events found - show them based on their type` line - this is where we're going to list our conversation history:

```swift
// events found - show them based on their type

events.forEach { (event) in
    if let memberEvent = event as? NXMMemberEvent {
        self.showMemberEvent(event: memberEvent)
    }
    if let textEvent = event as? NXMTextEvent {
        self.showTextEvent(event: textEvent)
    }
}
```

We're only show text and member related events (member invited, joined or left) for now.

Locate the line `//MARK: Show events` and let's add the `showMemberEvent(event: NXMMemberEvent)` and `showTextEvent(event: NXMTextEvent)` methods:

```swift
//MARK: Show events

func showMemberEvent(event: NXMMemberEvent) {
    switch event.state {
    case .invited:
        addConversationLine("\(event.member.user.name) was invited.")
    case .joined:
        addConversationLine("\(event.member.user.name) joined.")
    case .left:
        addConversationLine("\(event.member.user.name) left.")
    @unknown default:
        fatalError("Unknown member event state.")
    }
}
func showTextEvent(event: NXMTextEvent) {
    if let message = event.text {
        addConversationLine("\(event.fromMember?.user.name ?? "A user") said: '\(message)'")
    }
}

func addConversationLine(_ line: String) {
    if let text = conversationTextView.text, text.lengthOfBytes(using: .utf8) > 0 {
        conversationTextView.text = "\(text)\n\(line)"
    } else {
        conversationTextView.text = line
    }
}
```