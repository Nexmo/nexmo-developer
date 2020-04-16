---
title: Swift
language: swift
menu_weight: 1
---


The `getEventsPageWithSize:order:completionHandler:` method retrieves events that occurred in the context of the conversation via a `NXMEventsPage`:

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
            // show Member event
        }
        if let textEvent = event as? NXMTextEvent {
            // show Text event
        }
    })

    if eventsPage.hasNextPage() {
        eventsPage.nextPage({ (error, nextPage) in
            // process next page of events
        })
    }
    
    if eventsPage.hasPreviousPage() {
        eventsPage.previousPage({ (error, nextPage) in
            // process previous page of events
        })
    }
}
```
