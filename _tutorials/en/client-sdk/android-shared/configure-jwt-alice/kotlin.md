---
title: Configure JWT
description: In this step you learn how to add JWT to the application.
---

# Configure JWTs

Now it's time to fill previously generated `JWT` token.

Open `Config.kt` file and fill JWT token for `Alice` user:

```kotlin
object Config {

    val alice = User(
        "Alice",
        "ALICE_TOKEN" // TODO: "set Alice's JWT token"
    )
}

```

Notice that these values are hardcoded. This makes it easier to use these values later in this tutorial, however in production application they should be retrieved from external API.