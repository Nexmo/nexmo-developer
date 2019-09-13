---
title: Objective-C
language: objective_c
menu_weight: 2
---

Clone this [Github project](https://github.com/Nexmo/ClientSDK-Get-Started-Voice-Objective-C).

Using the Github project you cloned, in the Start folder, open `GettingStarted.xcworkspace`. Then, within XCode:
    
1. Open `User.h` file and replace the user IDs and tokens:

```objective-c
#define kJaneName @"Jane"

#define kJaneUUID @"" //TODO: swap with a user uuid for Jane

#define kJaneJWT @"" //TODO: swap with a token for Jane



#define kJoeName @"Joe"

#define kJoeUUID @"" //TODO: swap with a userId for Joe

#define kJoeJWT @"" //TODO: swap with a token for Joe


```

2. From the `App-to-App` group, open `AppToAppCallViewController.m` file and make sure the following lines exist:

 * `#import <NexmoClient/NexmoClient.h>` - imports the sdk
 * `@property NXMClient *client;` - property for the client instance
 * `@property NXMCall *call;` - property for the call instance
