---
title: Configure JWTs and conversation id
description: In this step you learn how to add JWT to the application and set the conversation id.
---

# Configure JWTs and conversation id

Create `Config.kt` file in the `com.vonage.tutorial.messaging` package to store the configuration. Right click on `messaging` package and select `New` > `Kotlin Class/File`. Enter `Config` as name and select `File` and press Enter to confirm.

Replace file content with below code snippet:

```kotlin
package com.vonage.tutorial.messaging

object Config {

    const val CONVERSATION_ID: String = "" // TODO: set conversation Id

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


Now it's time to fill previously generated `CONVERSATION_ID` and `JWT` tokens. Replace placeholders with real values obtained in a previous step:

1. `CONVERSATION_ID` - id of the conversation created in the previous step
2. `ALICE_TOKEN` - Alice JWT token
3. `BOB_TOKEN` - Bob JWT token

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.