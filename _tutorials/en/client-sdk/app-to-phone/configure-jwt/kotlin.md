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
}

data class User(
    val name: String,
    val jwt: String
)
```

Now it's time to fill previously generated JWT. Replace `ALICE_TOKEN` placeholder with real value obtained in a previous step.

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.