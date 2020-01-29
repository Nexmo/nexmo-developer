---
title: Objective-C
language: objective_c
menu_weight: 2
---


```objective_c
@interface ConversationViewController () <NXMConversationDelegate>

@property NSError *error;
@property NXMConversation *conversation;

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getConversation];
}

- (void)getConversation {
    [NXMClient.shared getConversationWithUuid:conversationUUID completionHandler:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        self.error = error;
        self.conversation = conversation;
        [conversation setDelegate:self];
    }];
}

- (void)sendCustomEvent {
    [self.conversation sendCustomWithEvent:@"my_custom_event" data:@{@"your": @"data"} completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error sending custom event: %@", error);
            return;
        }
        NSLog(@"Custom event sent.");
    }];
}

//MARK: Conversation Delegate

- (void)conversation:(NXMConversation *)conversation didReceive:(NSError *)error {
    NSLog(@"Conversation error: %@", error.localizedDescription);
}

- (void)conversation:(NXMConversation *)conversation didReceiveCustomEvent:(NXMCustomEvent *)event {
    NSLog(@"Received custome type %@: %@", event.customType, event.data);
}
@end

```