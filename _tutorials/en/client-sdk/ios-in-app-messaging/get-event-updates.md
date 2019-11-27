---
title: Get event updates
description: In this step you learn how to get event updates.
---

# Get event updates

Get live updates regarding the events in your delegate object.

The following three methods are used to report changes to the members of the conversation:

```objective-c
- (void)nxmConversationEventsControllerWillChangeContent:(NXMConversationEventsController *_Nonnull)controller;
```

Invoked when the controller is about to update events array. A number of changes might occur after the invocation of that method.

```objective-c
- (void)nxmConversationEventsControllerDidChangeContent:(NXMConversationEventsController *_Nonnull)controller;
```

Invoked when the controller is finished updating events array. A number of changes might have occurred before the invocation of that method.

```objective-c
- (void)nxmConversationEventsController:(NXMConversationEventsController *_Nonnull)controller didChangeEvent:(NXMEvent*_Nonnull)anEvent atIndex:(NSUInteger)index forChangeType:(NXMConversationEventsControllerChangeType)type newIndex:(NSUInteger)newIndex;
```

Invoked on each change to an event. The type of change is indicated by the `NXMConversationEventsControllerChangeType` enum.

> **NOTE:** Changes to the events in this controller are done on the main thread, so it is safe to use this controller directly to update the UI.
