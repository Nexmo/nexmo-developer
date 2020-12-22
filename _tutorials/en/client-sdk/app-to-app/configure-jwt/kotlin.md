---
title: Configure JWTs
description: In this step you learn how to add JWT to the application.
---

# Configure JWTs and conversation id

Create `Config.kt` file in the `com.vonage.tutorial.voice` package to store the configuration. Right click on `voice` package and select `New` > `Kotlin Class/File`.  Enter `Config` as name and select `File` and press Enter to confirm.

Replace file content with below code snippet:

```kotlin
package com.vonage.tutorial.voice

object Config {

    val alice = User(
        "Alice",
        "ALICE_TOKEN" // TODO: "set Alice's JWT token"
    )
    val bob = User(
        "Bob",
        "BOB_TOKEN" // TODO: "set Bob's JWT token"
    )
}

data class User(
    val name: String,
    val jwt: String
)
```

Now it's time to fill previously generated JWT. Replace `ALICE_TOKEN` and `BOB_TOKEN` placeholders with real values obtained in a previous step:

Notice that these values are hardcoded. This makes it easier to use these values later in this tutorial, however in production application they should be retrieved from external API.

Run `Build` > `Make project` to make sure project is compiling.