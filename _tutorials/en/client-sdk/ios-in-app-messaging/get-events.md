---
title: Get events
description: In this step you learn how to get events.
---

# Get conversation events  

`EventsController` allows you to monitor the events of a conversation. The controller syncs the data from the server to make sure events are handled in real-time, in order, and with no gaps. It also filters incoming events to hold only the events you need.

`EventsController` starts syncing events from the latest `event_id` the conversation is familiar with onward. The controller invokes delegate methods when the controllers content is changed. If a conversation object knows that the latest event to happen was event #5, and a new event #8 was received, the events controller will make sure to query for events #6, #7, but not for events #1, #2, #3, #4.

To obtain conversation events:

```objective-c
NSSet<NSNumber *> *eventsToPresent = [[NSSet alloc] initWithObjects:@(NXMEventTypeText),@(NXMEventTypeImage),@(NXMEventTypeMessageStatus),@(NXMEventTypeMedia),@(NXMEventTypeMember),@(NXMEventTypeSip),@(NXMEventTypeGeneral), nil];

NXMConversationEventsController *eventsController = [conversation eventsControllerWithTypes:eventsToPresent andDelegate:NXMConversationEventsControllerDelegateImp];
NSArray<NXMEvent *> *events = eventsController.events;
```

Where `NXMConversationEventsControllerDelegateImp` implements the `NXMConversationEventsControllerDelegate` protocol.
