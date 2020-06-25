---
title: Configure JWTs
description: In this step you learn how to add JWTs to the application.
---

# Configure JWTs

Now it's time to fill previously generated `JWT` tokens.

Open `Config.kt` file and fill tokens:

1. `Alice`'s user JWTs
2. `Bob`'s user JWTs

```kotlin
package com.vonage.tutorial.voice

object Config {

    val alice = User(
        "Alice",
        "" // TODO: "set Alice's JWT token"
    )
    val bob = User(
        "Bob",
        "" // TODO: "set Bob JWT token"
    )
}

```

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.