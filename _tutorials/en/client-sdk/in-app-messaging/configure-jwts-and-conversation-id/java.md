---
title: Configure JWTs
description: In this step you learn how to add JWT to the application.
---

# Configure JWTs and conversation id

Create `User` class in the `com.vonage.tutorial.messaging` package to store user data. Right click on `messaging` package and select `New` > `Java Class`. Enter `User` and select `Class`.

Replace file content with below code snippet:

```java
package com.vonage.tutorial.messaging;

public class User {

    public String jwt;
    String name;

    public User(String name, String jwt) {
        this.name = name;
        this.jwt = jwt;
    }

    public String getName() {
        return name;
    }

    public String getId() {
        return jwt;
    }
}
```

Create `Config` class in the `com.vonage.tutorial.messaging` package to store the configuration. Right click on `messaging` package and select `New` > `Java Class`. Enter `Config` and select `Class`.

Replace file content with below code snippet:

```java
package com.vonage.tutorial.messaging;

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

Now it's time to fill previously generated `CONVERSATION_ID` and `JWT` tokens. Replace placeholders with real values obtained in a previous step:

1. `CONVERSATION_ID` - id of the conversation created in the previous step
2. `ALICE_TOKEN` - Alice JWT token
3. `BOB_TOKEN` - Bob JWT token

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.