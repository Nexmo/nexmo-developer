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

data class User(
    val name: String,
    val jwt: String
)

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

```

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.