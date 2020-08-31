---
title: Building the user model
description: In this step you will build the user model struct.
---

# Building the user model

To be have a conversation you need to store some information about a user: 

* A user's name
* A user's ID
* A user's JWT
* Who they are chatting with
* The conversation ID

To do this you will create a new User `Class`. From the Xcode menu, select `File` > `New` > `File...`. Select `Cocoa Touch Class`, name it `User` with a subclass of `NSObject`:

![Xcode adding file](/images/client-sdk/ios-messaging/userclass.png)

Open `User.h` declare the properties and functions needed to store the user's information.

```objective_c
@interface User : NSObject

@property NSString *name;
@property NSString *uuid;
@property NSString *jwt;
@property NSString *chatPartnerName;
@property NSString *conversationId;

-(instancetype)initWithName:(NSString *)name uuid:(NSString *)uuid jwt:(NSString *)jwt chatPartnerName:(NSString *)chatPartnerName;

+(instancetype)Alice;
+(instancetype)Bob;

@end
```

To make things easier for later on there are some static properties on the `User` type for the users Alice and Bob. Open `User.m` to implement these alongside the initializer for the class, Replacing `ALICE_USERID`, `ALICE_JWT`, `BOB_USERID`, `BOB_JWT` and `CONVERSATION_ID` with the values you created earlier.

```objective_c
@implementation User

- (instancetype)initWithName:(NSString *)name uuid:(NSString *)uuid jwt:(NSString *)jwt chatPartnerName:(NSString *)chatPartnerName
{
    if (self = [super init])
    {
        _name = name;
        _uuid = uuid;
        _jwt = jwt;
        _chatPartnerName = chatPartnerName;
        _conversationId = @"CONVERSATION_ID";
    }
    return self;
}

+ (instancetype)Alice
{
    return [[User alloc] initWithName:@"Alice" uuid:@"ALICE_USERID" jwt:@"ALICE_JWT" chatPartnerName:@"Bob"];
}

+ (instancetype)Bob
{
    return [[User alloc] initWithName:@"Bob" uuid:@"BOB_USERID" jwt:@"BOB_JWT" chatPartnerName:@"Alice"];
}

@end
```