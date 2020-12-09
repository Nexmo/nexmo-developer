---
title:  Project permissions
description:  In this step you will add the necessary permissions to the project properties.

---

Project permissions
===================

As you'll be using the microphone when making a call, you need to request the permission to use it.

`Info.plist`
------------

Every Xcode project contains an `Info.plist` file containing all the metadata required in each app or bundle  - you will find the file inside the `AppToAppCall` group.

A new entry in the `Info.plist` file is required:

1. Hover your mouse over the last entry in the list and click the little `+` button that appears.

2. From the dropdown list, pick `Privacy - Microphone Usage Description` and add `To make and receive phone calls.` for its value.

Your `Info.plist` should look like this:

![Info.plist](/images/client-sdk/ios-in-app-voice/info-plist.png)

Request permission on application start
---------------------------------------

Open `AppDelegate.h` and import the `AVFoundation` library right after where `UIKit` is included.

```objective_c
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
```

Next, call `requestRecordPermission:` inside `application:didFinishLaunchingWithOptions:`.

```objective_c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AVAudioSession.sharedInstance requestRecordPermission:^(BOOL granted) {
        NSLog(@"Allow microphone use. Response: %d", granted);
    }];
    return YES;
}
```

Build and Run
-------------

You can now build and run the project, by either selecting `Product` > `Run` from the top menu, or pressing `Cmd + R`, and launch it in the simulator.

Notice the prompt asking for permission to use the microphone:

![Simulator microphone permission ask](/images/client-sdk/ios-in-app-voice/permissions.png)

