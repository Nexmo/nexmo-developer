---
title:  ユーザーモデルの構築
description:  このステップでは、ユーザーモデルの構造体を構築します。

---

ユーザーモデルの構築
==========

会話をするには、ユーザーに関するいくつかの情報を保存する必要があります：

* ユーザーの名前
* ユーザーのJWT
* 通話している相手

これを行うには、新しいユーザー`Class`を作成します。Xcodeメニューから`File`＞`New`＞`File...`を選択します。`Cocoa Touch Class`を選択し、`NSObject`と`Objective-C`のサブクラスを使い、選択した言語で`User` と名前を付けます。

![Xcode追加ファイル](/images/client-sdk/ios-messaging/userclass.png)

`User.h`を開き、ユーザーの情報を保存するために必要なプロパティと関数を宣言します。

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

後で簡単にするために、AliceとBobの`User`タイプにいくつかの静的プロパティがあります。`User.m`を開いて、クラスのイニシャライザーと一緒にこれらを実装し、`ALICE_JWT`と`BOB_JWT`を、前に作成した値に置き換えます。

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

