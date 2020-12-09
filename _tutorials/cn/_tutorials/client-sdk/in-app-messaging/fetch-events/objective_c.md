---
title:  Chat events
description:  In this step you will handle chat events.

---

Chat events
===========

Earlier you created a conversation in the Nexmo CLI and added the two users to that conversation. Conversations, modeled as `NXMConversation` objects in the Client SDK, are how the users will communicate. You can learn more about conversations in the [Conversation API documentation](/conversation/concepts/conversation). Chat events, or `NXMEvent` objects, are sent using the conversation that you created, so to get chat event you will first need to fetch the conversation. To implement this, the additions to `ChatViewController.m` shown in the following sections are required.

Add properties for the conversation and events as well as conformance to the `NXMConversationDelegate` in the interface:

```objective_c
@interface ChatViewController () <UITextFieldDelegate, NXMConversationDelegate> 
...
@property NXMConversation *conversation;
@property NSMutableArray<NXMEvent *> *events;
@end
```

Add a function call to `getConversation` at the end of the `viewDidLoad` function:

```swift
- (void)viewDidLoad {
    ...

    [self getConversation];
}
```

Add the functions to get the conversation, events and process those events a the end of the `ChatViewController.m` file:

```objective_c
- (void)getConversation {
    [self.client getConversationWithUuid:self.user.conversationId completionHandler:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        self.conversation = conversation;
        if (conversation) {
            [self getEvents];
        }
        conversation.delegate = self;
    }];
}

- (void)getEvents {
    if (self.conversation) {
        [self.conversation getEventsPageWithSize:100 order:NXMPageOrderAsc completionHandler:^(NSError * _Nullable error, NXMEventsPage * _Nullable events) {
            self.events = [NSMutableArray arrayWithArray:events.events];
            [self processEvents];
        }];
    }
}

- (void)processEvents {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.conversationTextView.text = @"";
        for (NXMEvent *event in self.events) {
            if ([event isMemberOfClass:[NXMMemberEvent class]]) {
                [self showMemberEvent:(NXMMemberEvent *)event];
            } else if ([event isMemberOfClass:[NXMTextEvent class]]) {
                [self showTextEvent:(NXMTextEvent *)event];
            }
        }
    });
}

- (void)showMemberEvent:(NXMMemberEvent *)event {
    switch (event.state) {
        case NXMMemberStateInvited:
            [self addConversationLine:[NSString stringWithFormat:@"%@ was invited", event.member.user.name]];
            break;
        case NXMMemberStateJoined:
            [self addConversationLine:[NSString stringWithFormat:@"%@ joined", event.member.user.name]];
            break;
        case NXMMemberStateLeft:
            [self addConversationLine:[NSString stringWithFormat:@"%@ left", event.member.user.name]];
            break;
    }
}

- (void)showTextEvent:(NXMTextEvent *)event {
    NSString *message = [NSString stringWithFormat:@"%@ said %@", event.fromMember.user.name, event.text];
    [self addConversationLine:message];
}

- (void)addConversationLine:(NSString *)line {
    NSString *currentText = self.conversationTextView.text;
    
    if (currentText.length > 0) {
        self.conversationTextView.text = [NSString stringWithFormat:@"%@\n%@", currentText, line];
    } else {
        self.conversationTextView.text = line;
    }
}
```

`getConversation` uses the conversation ID from the Nexmo CLI to fetch the conversation, if that is successful `getEvents` is called to fetch the chat events. The Client SDK supports pagination so to get the chat events you must specify a page size.

Once the events are fetched they are processed by `processEvents`. In `processEvents` there is type casting to either a `NXMMemberEvent` or a `NXMTextEvent` which get append to the `conversationTextView` by `showMemberEvent` and `showTextEvent` respectively. You can find out more about the supported event types in the [Conversation API documentation](/conversation/concepts/event).

The conversation delegate
-------------------------

The application also needs to react to events in a conversation after loading initially so you need to have implement some functions from the `NXMConversationDelegate`. At the end of the `ChatViewController.m` class add:

```objective_c
@implementation ViewController
    ...

- (void)conversation:(NXMConversation *)conversation didReceiveTextEvent:(NXMTextEvent *)event {
    [self.events addObject:event];
    [self processEvents];
}

- (void)conversation:(NXMConversation *)conversation didReceiveMemberEvent:(NXMMemberEvent *)event {
    [self.events addObject:event];
    [self processEvents];
}

- (void)conversation:(NXMConversation *)conversation didReceive:(NSError *)error {
    NSLog(@"Conversation error: %@", error.localizedDescription);
}
```

When a new event is received it is appended to the `events` array, then the processing of the events start again.

Build and Run
-------------

Press `Cmd + R` to build and run again. After logging in you will see that both users have joined the conversation as expected:

![Chat interface with connection events](/images/client-sdk/ios-messaging/chatevents.png)

