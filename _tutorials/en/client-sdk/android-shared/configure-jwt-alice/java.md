---
title: Configure JWT
description: In this step you learn how to add JWT to the application.
---

# Configure JWTs

Create a `User` class in the `com.vonage.tutorial.voice` package to store user data:

1. Right click on the `messaging` package and select `New` > `Java Class`. Enter `User` and select `Class`.
2. Replace the file contents with the following code:

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

Create a `Config` class in the `com.vonage.tutorial.voice` package to store the configuration:

1. Right click on the `messaging` package and select `New` > `Java Class`.
2. Enter `Config` and select `Class`.

Replace the file contents with the following code:

```java
public class Config {

    public static User getAlice() {
        return new User(
                "Alice",
                "ALICE_TOKEN" // TODO: "set Bob JWT token"
        );
    }
}
```

Now it's time to configure the `Alice` user with the JWT that you generated in an earlier step. Replace the `ALICE_TOKEN` placeholder with the real JWT value.

Notice that these user properties are hardcoded. This makes them easier to use later in this tutorial.
