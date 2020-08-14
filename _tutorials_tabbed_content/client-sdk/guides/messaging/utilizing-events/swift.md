---
title: Swift
language: swift
menu_weight: 1
---

The `getEventsPageWithSize:order:completionHandler:` method on `NXMConversation` retrieves all the events that occurred in the context of the conversation. It returns a subset or _page_ of events with each invocation - the number of events it returns is based on the page_size parameter (the default is 10 results, the maximum is 100).

Below is an example of using the function to retrieve member and text events followed by using the conversation to send a text event. You can find out more about the supported event types in the [Conversation API documentation](/conversation/concepts/event).

```swift
conversation.getEventsPage(withSize: 20, order: .asc) { (error, eventsPage) in
    if let error = error {
        NSLog("Error retrieving events: \(error.localizedDescription)")
        return
    }
    guard let eventsPage = eventsPage else {
        return
    }

    // // events found - process them based on their type
    eventsPage.events.forEach({ (event) in
        if let memberEvent = event as? NXMMemberEvent {
            showMemberEvent(event: memberEvent)
        }
        if let textEvent = event as? NXMTextEvent {
            showTextEvent(event: textEvent)
        }
    })
}

func showMemberEvent(event: NXMMemberEvent) {
    switch event.state {
    case .invited:
        print("\(event.member.user.name) was invited.")
    case .joined:
        print("\(event.member.user.name) joined.")
    case .left:
        print("\(event.member.user.name) left.")
    @unknown default:
        fatalError("Unknown member event state.")
    }
}
    
func showTextEvent(event: NXMTextEvent) {
    if let message = event.text {
        print("\(event.fromMember?.user.name ?? "A user") said: '\(message)'")
    }
}
```

```swift
conversation?.sendText(message, completionHandler: { [weak self] (error) in
    if let error = error {
        print(error)
    }
}
```
