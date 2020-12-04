---
title:  ユーザーモデルの構築
description:  このステップでは、ユーザーモデルの構造体を構築します。

---

ユーザーモデルの構築
==========

会話をするには、ユーザーに関するいくつかの情報を保存する必要があります：

* ユーザーの名前
* ユーザーのJWT
* チャットをしている相手
* [conversation ID (カンバセーションID)]

これを行うには、新しいユーザー`Class`を作成します。Xcodeメニューから`File`＞`New`＞`File...`を選択します。`Cocoa Touch Class`を選択し、`NSObject`のサブクラスで`User`と名前を付けます：

![Xcode追加ファイル](/images/client-sdk/ios-messaging/userclass.png)

`User.h`を開き、ユーザーの情報を保存するために必要なプロパティと関数を宣言します。

```objective_c
@interface User : NSObject

@property NSString *name;
@property NSString *jwt;
@property NSString *chatPartnerName;
@property NSString *conversationId;

-(instancetype)initWithName:(NSString *)name jwt:(NSString *)jwt chatPartnerName:(NSString *)chatPartnerName;

+(instancetype)Alice;
+(instancetype)Bob;

@end
```

後で簡単にするために、ユーザーAliceとBobの`User`タイプにいくつかの静的プロパティがあります。`User.m`を開いて、クラスのイニシャライザーと一緒にこれらを実装し、`ALICE_JWT`、`BOB_JWT`、`CONVERSATION_ID`を、前に作成した値に置き換えます。

```objective_c
@implementation User

- (instancetype)initWithName:(NSString *)name jwt:(NSString *)jwt chatPartnerName:(NSString *)chatPartnerName
{
    if (self = [super init])
    {
        _name = name;
        _jwt = jwt;
        _chatPartnerName = chatPartnerName;
        _conversationId = @"CONVERSATION_ID";
    }
    return self;
}

+ (instancetype)Alice
{
    return [[User alloc] initWithName:@"Alice" jwt:@"ALICE_JWT" chatPartnerName:@"Bob"];
}

+ (instancetype)Bob
{
    return [[User alloc] initWithName:@"Bob" jwt:@"BOB_JWT" chatPartnerName:@"Alice"];
}

@end
```

