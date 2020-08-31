---
title: Building the user model
description: In this step you will build the user model struct.
---

# Building the user model

To be have a conversation you need to store some information about a user: 

* A user's name
* A user's JWT
* Who they are calling

To do this you will create a new User `Class`. From the Xcode menu, select `File` > `New` > `File...`. Select `Cocoa Touch Class`, name it `User` with a subclass of `NSObject` and `Objective-C` as the selected language:

![Xcode adding file](/images/client-sdk/ios-messaging/userclass.png)

Open `User.h` declare the properties and functions needed to store the user's information.

```objective_c
@interface User : NSObject

@property NSString *name;
@property NSString *jwt;
@property NSString *callPartnerName;

-(instancetype)initWithName:(NSString *)name jwt:(NSString *)jwt callPartnerName:(NSString *)chatPartnerName;

+(instancetype)Alice;
+(instancetype)Bob;

@end
```

To make things easier for later on there are some static properties on the `User` type for the users Alice and Bob. Open `User.m` to implement these alongside the initializer for the class, Replacing `ALICE_JWT` and `BOB_JWT` with the values you created earlier.

```objective_c
@implementation User

- (instancetype)initWithName:(NSString *)name jwt:(NSString *)jwt callPartnerName:(NSString *)callPartnerName {
    if (self = [super init])
    {
        _name = name;
        _jwt = jwt;
        _callPartnerName = callPartnerName;
    }
    return self;
}

+ (instancetype)Alice {
    return [[User alloc] initWithName:@"Alice" jwt:@"ALICE_JWT" callPartnerName:@"Bob"];
}

+ (instancetype)Bob {
    return [[User alloc] initWithName:@"Bob" jwt:@"BOB_JWT" callPartnerName:@"Alice"];
}

@end
```