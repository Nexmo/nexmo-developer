---
title: Configure JWT
description: In this step you learn how to add JWT to the application.
---

# Configure JWT

Create `User` class in the `com.vonage.tutorial.voice` package to store user data. Right click on `voice` package and select `New` > `Java Class`. Enter `User` and select `Class`.

Replace file content with below code snippet:

```java
package com.vonage.tutorial.voice;

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

Create `Config` class in the `com.vonage.tutorial.voice` package to store the configuration. Right click on `voice` package and select `New` > `Java Class`. Enter `Config` and select `Class`.

Replace file content with below code snippet:

```java
package com.vonage.tutorial.voice;

public class Config {

    public static User getAlice() {
        return new User(
                "Alice",
                "ALICE_TOKEN" // TODO: "set Alice JWT token"
        );
    }
}
```

Now it's time to fill previously generated JWT. Replace `ALICE_TOKEN` placeholder with real value obtained in a previous step.

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.