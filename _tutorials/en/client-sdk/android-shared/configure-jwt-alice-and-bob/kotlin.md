---
title: Configure JWTs
description: In this step you learn how to add JWTs to the application.
---

# Configure JWTs

Open `Config.kt` file and replace placeholders with real values:

1. `ALICE_TOKEN` - Alice JWT token
2. `BOB_TOKEN` - Bob JWT token

```kotlin
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

```

Notice that these values are hardcoded. This makes it easier to use these values later in this tutorial, however in production application they should be retrieved from external API.