---
title: Configure JWTs
description: In this step you learn how to add JWTs to the application.
---

# Configure JWTs

Open the `Config.kt` file and replace the `ALICE_TOKEN` and `BOB_TOKEN` placeholders with the real JWTs that you generated earlier:

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

Notice that these values are hardcoded to keep the tutorial code straightforward. However, in a production application they should be retrieved from an external API.