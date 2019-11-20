---
title: Objective-C
language: objective_c
menu_weight: 2
---

Clone this [Github project](https://github.com/Nexmo/ClientSDK-Get-Started-Voice-Objective-C).

Using the Github project you cloned, in the Start folder, open `GettingStarted.xcworkspace`. Then, within XCode:


1. Open `User.h` file and replace the user id and token:

```objective-c
#define kJaneUUID @"" //TODO: swap with a user uuid for Jane

#define kJaneJWT @"" //TODO: swap with a token for Jane
```

2. From the `Make-phone-call` group, open `MakePhoneCallViewController.m` file and make sure the following lines exist:

* imports the SDK
    ```objective-c
    #import <NexmoClient/NexmoClient.h>
    ```

* Sets the user that places the call
    ```objective-c
    @property User *user;
    ```

* Property for the client instance
    ```objective-c
    @property NXMClient *client;
    ```

* Property for the call instance
    ```objective-c
    @property NXMCall *call;
    ```
