---
title: The Starter Project
description: In this step you will clone the starter project
---

# The Starter Project

To make things easier, we are providing a `Starter` project for you. It is a simple Xcode project that contains the following 2 screens:

```screenshot
image: public/assets/images/tutorials/client-sdk/ios-in-app-messaging-chat/screens.png
```

Clone this [Github project](https://github.com/Nexmo/ClientSDK-Get-Started-Messaging-Objective-C).

Using the Github project you cloned, in the Start folder, open `GettingStarted.xcworkspace`. Then, within XCode:


Open `User.h` file and replace the user id and token:

```objective-c
#define kJaneName @"Jane"
#define kJaneUUID @"" //TODO: swap with a user uuid for Jane
#define kJaneJWT @"" //TODO: swap with a token for Jane


#define kJoeName @"Joe"
#define kJoeUUID @"" //TODO: swap with a user uuid for Joe
#define kJoeJWT @"" //TODO: swap with a token for Joe


#define kConversationUUID @"" //TODO: swap with a phone number to call

```
