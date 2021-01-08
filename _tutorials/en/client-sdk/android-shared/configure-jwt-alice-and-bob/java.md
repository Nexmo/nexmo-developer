---
title: Configure JWTs
description: In this step you learn how to add JWTs to the application.
---

# Configure JWTs

Open the `Config.kt` file and replace the `ALICE_TOKEN` and `BOB_TOKEN` placeholders with the real JWTs that you generated earlier:

```java
public class Config {

    public static User getAlice() {
        return new User(
                "Alice",
                "ALICE_TOKEN" // TODO: "set Bob JWT token"
        );
    }

    public static User getBob() {
        return new User(
                "Bob",
                "BOB_TOKEN" // TODO: "set Bob JWT token"
        );
    }

    //...
}
```

Notice that these values are hardcoded to keep the tutorial code straightforward. However, in a production application they should be retrieved from an external API.