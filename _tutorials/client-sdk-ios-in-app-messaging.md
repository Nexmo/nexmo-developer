---
title: How to Add In-App Messaging to your iOS App
products: client-sdk
description: This tutorial shows you how to add in-app messaging to your iOS application using the Nexmo Client SDK.
languages:
    - Objective_C 
    - Swift
---

# How to Add In-App Messaging to your iOS App

This tutorial provides an overview of the basic functionality of Nexmo Client In-App Messaging on iOS.

## Prerequisites

Make sure to add Nexmo Client SDK to your app. Find the details on how to do it in this [guide](/client-sdk/setup/add-sdk-to-your-app/ios).

## Conversation

A [Conversation](/conversation/concepts/conversation) is a shared core component that Nexmo APIs rely on. It connects [Users](/conversation/concepts/user) and allows them to communicate.

### Create a new conversation

Use the `NXMClient` to create a new conversation:

```objective-c
[client createConversationWithName:@"conversation name" completion:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        if(error) {
            //Handle error
            return;
        }
    //Do Something with the conversation
}];
```

Note that `"conversation name"` should be *unique* with regards to the scope of your `application_id`. At the end of this Async request, the completion block is invoked with an `NXMConversation` object if the conversation was created, or an error object if something went wrong. 

The conversation identifier, is needed to query this conversation at a later time:

```objective-c
NSString* conv_id = conversation.conversationId;
```

### Get existing conversation

Getting an existing conversation using a conversation identifier:

```objective-c
[client getConversationWithId:@"conversation identifier" completion:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        if(error) {
            //Handle error
            return;
        }
    //Do Something with the conversation
}];
```

At the end of this Async request, the completion block is invoked with an `NXMConversation` object if the conversation was created, or an error object if something went wrong.

### Join a conversation

Join a conversation to be a member of the conversation and have the ability to send and receive messages and other conversation-related information:

```objective-c
[conversation joinWithCompletion:^(NSError * _Nullable error, NXMMember * _Nullable member) {
        if(error) {
            //Handle error
            return;
        }
    //You are now a member of this conversation
}];
```

### Add a user to a conversation

Add other users as members of this conversation for them to send and receive messages:

```objective-c
[conversation addMemberWithUserId:@"user id" completion:^(NSError * _Nullable error, NXMMember * _Nullable member) {
        if(error) {
            //Handle error
            return;
        }
    //user was added to this conversation
}];
```

### Get conversation members

* Get current user's member:

```objective-c
NXMMember *myMember = conversation.myMember;
```

* Get other members of this conversation:

```objective-c
NSSet<NXMMember *> *otherMembers = conversation.otherMembers;
```

### Send a text message

Use the conversation object to send a text message:

```objective-c
[conversartion sendText:@"text" completion:^(NSError * _Nullable error) {
    if(error) {
        //handle error in sending text
    }
    //text arrived at server
}];
```

### Send an attachment message

You can use the conversation object to send attachments. The following example shows how to send an attachment in a conversation:

```objective-c
[conversation sendAttachmentOfType:NXMAttachmentTypeImage WithName:filename data:data completion:^(NSError * _Nullable error) {
    if(error) {
        //Handle error sending image
        return;
    }
    //image sent to server
}];
```

## Events Controller

`EventsController` allows you to monitor the events of a conversation. The controller syncs the data from the server to make sure events are handled in realtime, in order, and with no gaps. It also filters incoming events to hold only the events you need.

`EventsController` starts syncing events from the latest `event_id` the conversation is familiar with and onwards. The controller invokes delegate methods when the controllers content is changed. If a conversation object knows that the latest event to happen was event #5, and a new event #8 was received, the events controller will make sure to query for events #6,#7, but not for events #1,#2,#3,#4.

### Get conversation events  

To obtain conversation events:

```objective-c
NSSet<NSNumber *> *eventsToPresent = [[NSSet alloc] initWithObjects:@(NXMEventTypeText),@(NXMEventTypeImage),@(NXMEventTypeMessageStatus),@(NXMEventTypeMedia),@(NXMEventTypeMember),@(NXMEventTypeSip),@(NXMEventTypeGeneral), nil];

NXMConversationEventsController *eventsController = [conversation eventsControllerWithTypes:eventsToPresent andDelegate:NXMConversationEventsControllerDelegateImp];
NSArray<NXMEvent *> *events = eventsController.events;
```

Where `NXMConversationEventsControllerDelegateImp` implements the `NXMConversationEventsControllerDelegate` protocol.

### Get event updates

Get live updates regarding the events in your delegate object.

The following three methods are used to report changes to the members of the conversation:

```objective-c
- (void)nxmConversationEventsControllerWillChangeContent:(NXMConversationEventsController *_Nonnull)controller;
```

Invoked when the controller is about to update events array. A number of changes might occur after the invocation of that method.

```objective-c
- (void)nxmConversationEventsControllerDidChangeContent:(NXMConversationEventsController *_Nonnull)controller;
```

Invoked when the controller is finished updating events array. A number of changes might have occured before the invocation of that method.

```objective-c
- (void)nxmConversationEventsController:(NXMConversationEventsController *_Nonnull)controller didChangeEvent:(NXMEvent*_Nonnull)anEvent atIndex:(NSUInteger)index forChangeType:(NXMConversationEventsControllerChangeType)type newIndex:(NSUInteger)newIndex;
```

Invoked on each change to an event. The type of change is indicated by the `NXMConversationEventsControllerChangeType` enum.

> **NOTE:** Changes to the events in this controller are done on the main thread, so it is safe to use this controller directly to update the UI.

### Load past events

Events Controller syncs events forward. Loading past events is done on demand:

```objective-c
[eventsController loadEarlierEventsWithMaxAmount:AMOUNT_OF_EVENTS_TO_LOAD_MORE completion:^(NSError * _Nullable error) {
        if (error) {
            //error loading more events
            return;
        }

        //more events loaded, update
    }];
```

Note that completion is not guaranteed to be invoked on the main thread, so beware of directly calling UI methods here.

Also note that `AMOUNT_OF_EVENTS_TO_LOAD_MORE` is the maximum number of events to load. Filtered or deleted events will reduce the number of events loaded.
