---
title: Configure JWTs
description: In this step you learn how to add JWTs to the application.
---

# Configure JWTs

Now it's time to fill previously generated `JWT` tokens.

Open `Config.kt` file and replace `ALICE_TOKEN` and `BOB_TOKEN` placeholders with real values:

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

Notice that these values are hardcoded. This makes it easier to use these values later in this tutorial, however in production application they should be retrieved from external API.