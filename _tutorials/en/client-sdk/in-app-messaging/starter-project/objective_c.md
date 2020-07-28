---
title: The starter project
description: In this step you will clone the starter project
---

# The starter project

To make things easier, we are providing a starter project for you. It is a simple Xcode project that contains the following 2 screens:

```screenshot
image: public/screenshots/tutorials/client-sdk/ios-in-app-messaging-chat/screens.png
```

Clone this [GitHub project](https://github.com/nexmo-community/ClientSDK-Get-Started-Messaging-Objective-C).

Using the GitHub project you cloned, in the Start folder, open `GettingStarted.xcworkspace`. Then, within Xcode:


Open `User.h` file and replace the user id and token:

```objective-c
#define kAliceName @"Alice"
#define kAliceUUID @"" //TODO: swap with a user uuid for Alice
#define kAliceJWT @"" //TODO: swap with a token for Alice


#define kBobName @"Bob"
#define kBobUUID @"" //TODO: swap with a user uuid for Bob
#define kBobJWT @"" //TODO: swap with a token for Bob


#define kConversationUUID @"" //TODO: swap with a phone number to call

```
