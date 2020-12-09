---
title:  JWTの設定
description:  このステップでは、JWTをアプリケーションに追加する方法を学びます。

---

JWTを設定する
========

今度は、以前に生成された`JWT`トークンを埋めていきます。

`Config.kt`ファイルを開き、`ALICE_TOKEN`プレースホルダを実際の値に置き換えます。

```java
public class Config {

    public static User getAlice() {
        return new User(
                "Alice",
                "ALICE_TOKEN" // TODO: "set Bob JWT token"
        );
    }

    //...
}
```

これらの値はハードコードされていることに注意してください。これにより、これらの値がこのチュートリアルの後半で使用しやすくなりますが、本番アプリケーションでは、外部APIから取得する必要があります。

