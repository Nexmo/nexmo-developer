---
title: Configure JWTs and conversation id
description: In this step you learn how to add JWT to the application and set the conversation id.
---

Now it's time to fill previously generated `CONVERSATION_ID` and `JWT` tokens.

Open `Config.kt` file and replace placeholders with real values:

1. `CONVERSATION_ID` - id of the conversation created in the previous step
2. `ALICE_TOKEN` - Alice JWT token
3. `BOB_TOKEN` - Bob JWT token


```kotlin
package com.vonage.tutorial.messaging

public class Config {

    public static String CONVERSATION_ID = ""; // TODO: set conversation Id

    public static User getAlice() {
        return new User(
                "Alice",
                "" // TODO: "set Alice JWT token"
        );
    }

    public static User getBob() {
        return new User(
                "Bob",
                "" // TODO: "set Bob JWT token"
        );
    }
}
```

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.