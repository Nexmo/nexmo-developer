---
title:  JWTと[conversation id (カンバセーションID)]の設定
description:  このステップでは、アプリケーションにJWTを追加し、[conversation id (カンバセーションID)]を設定する方法を学習します。

---

今度は、以前に生成された`CONVERSATION_ID`および`JWT`トークンを埋めていきます。

`Config.kt`ファイルを開き、プレースホルダを実際の値に置き換えます：

1. `CONVERSATION_ID` - 前のステップで作成した[conversation (カンバセーション)]のID
2. `ALICE_TOKEN` - Alice JWTトークン
3. `BOB_TOKEN` - Bob JWTトークン

```kotlin
package com.vonage.tutorial.messaging

public class Config {
````
public static String CONVERSATION_ID = ""; // TODO: set conversation Id
````
    public static User getAlice() {
        return new User(
                "Alice",
                "" // TODO: "set Alice JWT token"
        );
    }
````
public static User getBob() {
    return new User(
            "Bob",
            "" // TODO: "set Bob JWT token"
    );
}
}
```
````
これらの定数と値は、ユーザーのプロパティを保存するためにハードコードされていることに注意してください。これにより、このチュートリアルの後半でこれらの値を使用しやすくなります。

