---
title: Objective-C
language: objective_c
---

# Enable Audio in your Application

In this guide we'll cover adding audio events to the Conversation we have created in the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/objective_c) guide. We'll deal with sending and receiving media events to and from the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Audio Leg** - A server side API term. Legs are a part of a conversation. When audio is enabled on a conversation, a leg is created
- **Media Event** - a `NXMMediaEvent` event that fires on a Conversation when the media state changes for a member

## Before you begin

Run through the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/swift). You will be building on top of this project.

## Add audio permissions

Since enabling audio uses the device microphone, you will need to ask the user for permission. 

### `Info.plist`

Every Xcode project contains an `Info.plist` file containing all the metadata required in each app or bundle  - you will find the file inside the `AppToAppChat` group.

A new entry in the `Info.plist` file is required:

1. Hover your mouse over the last entry in the list and click the little `+` button that appears.

2. From the dropdown list, pick `Privacy - Microphone Usage Description` and add `Microphone access required in order to make and receive audio calls.` for its value.

### Request permission on application start

Open `AppDelegate.h` and import the `AVFoundation` library right after where `UIKit` is included.

```objective_c
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
```

Next, call `requestRecordPermission:` inside `application:didFinishLaunchingWithOptions:` within `AppDelegate.m`.

```objective_c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AVAudioSession.sharedInstance requestRecordPermission:^(BOOL granted) {
        NSLog(@"Allow microphone use. Response: %d", granted);
    }];
    return YES;
}
```

## Add audio UI

You will now need to add a button for the user to enable and disable audio. In the `viewDidLoad` function in the `ChatViewController.m` class add a new bar button. 

```objective_c
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Start Audio" style:UIBarButtonItemStyleDone target:self action:@selector(toggleAudio)];
```

## Enable audio 

Next would be to enable audio. Add a property to the `ChatViewController` interface.

```objective_c
@interface ChatViewController () <UITextFieldDelegate, NXMConversationDelegate>
...
@property BOOL audioEnabled;
@end
```

The bar button from the previous step calls a `toggleAudio` function when tapped so add the following function to the `ChatViewController` class.

```objective_c
- (void)toggleAudio {
    if (self.audioEnabled) {
        [self.conversation disableMedia];
        self.navigationItem.rightBarButtonItem.title = @"Start Audio";
        self.audioEnabled = NO;
    } else {
        [self.conversation enableMedia];
        self.navigationItem.rightBarButtonItem.title = @"Stop Audio";
        self.audioEnabled = YES;
    }
}
```

Note that enabling audio in a conversation establishes an audio leg for a member of the conversation. The audio is only streamed to other members of the conversation who have also enabled audio.

## Display audio events

When enabling media, `NXMMediaEvent` events are sent to the conversation. To display these you will need to add a function from the `NXMConversationDelegate` which will append the media events to events array for processing.

```objective_c
- (void)conversation:(NXMConversation *)conversation didReceiveMediaEvent:(NXMMediaEvent *)event {
    [self.events addObject:event];
    [self processEvents];
}
```

In the process events function you will need to add a clause for a `NXMMediaEvent`, which in turn calls `showMediaEvent` to display the audio events.

```objective_c
- (void)processEvents {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.conversationTextView.text = @"";
        for (NXMEvent *event in self.events) {
            if ([event isMemberOfClass:[NXMMemberEvent class]]) {
                [self showMemberEvent:(NXMMemberEvent *)event];
            } else if ([event isMemberOfClass:[NXMTextEvent class]]) {
                [self showTextEvent:(NXMTextEvent *)event];
            } else if ([event isMemberOfClass:[NXMMediaEvent class]]) {
                [self showMediaEvent:(NXMMediaEvent *)event];
            }
        }
    });
}

- (void) showMediaEvent:(NXMMediaEvent *)event {
    if (event.isEnabled) {
        [self addConversationLine:[NSString stringWithFormat:@"%@ enabled audio", event.fromMember.user.name]];
    } else {
        [self addConversationLine:[NSString stringWithFormat:@"%@ disabled audio", event.fromMember.user.name]];
    }
}
```

## Build and run

Press `Cmd + R` to build and run again. Once logged in you can enable or disable audio. To test it out you can run the app on two different simulators/devices.

![Enable media](/images/client-sdk/ios-enable-media.png)
