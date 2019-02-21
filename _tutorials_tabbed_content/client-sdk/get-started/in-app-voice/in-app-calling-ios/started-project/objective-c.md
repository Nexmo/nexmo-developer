---
title: Objective-C
language: objective_c
menu_weight: 2
---

Clone this [Github project](https://github.com/Nexmo/Client-Get-Started-InApp-Voice-ObjectiveC).

Using the Github project you cloned, in the Starter app, with XCode:
    
1. Open `IAVAppDefine.h` file and replace the user IDs and tokens:

    ```objective-c
        #define kInAppVoiceJaneUserId @"JANE_USER_ID" //TODO: replace with a userId for Jane
        #define kInAppVoiceJaneToken @"JANE_TOKEN" //TODO: replace with a token for Jane
        #define kInAppVoiceJoeUserId @"JOE_USER_ID" //TODO: replace with a userId for Joe
        #define kInAppVoiceJoeToken @"JOE_TOKEN" //TODO: replace with a token for Joe
    ```

2. Open `MainViewController.m` file and make sure the following lines exist:

 * `#import <NexmoClient/NexmoClient.h>` - imports the sdk
 * `@property NXMClient *nexmoClient;` - property for the client instance
 * `@property NXMCall *ongoingCall;` - property for the call instance
