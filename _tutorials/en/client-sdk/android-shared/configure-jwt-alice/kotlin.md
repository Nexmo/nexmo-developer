---
title: Configure JWT
description: In this step you learn how to add JWT to the application.
---

# Configure JWTs

Create a `Config.kt` file in the `com.vonage.tutorial.voice` package to store the configuration:

1. Right click the `voice` package and select `New` > `Kotlin Class/File`.
2. Enter `Config` as the name, then select `File` and press Enter to confirm.

Replace the file contents with the following code:

```kotlin
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

Now it's time to configure the `Alice` user with the JWT that you generated in an earlier step. Replace the `ALICE_TOKEN` placeholder with the real JWT value.

Notice that these user properties are hardcoded. This makes them easier to use later in this tutorial.
