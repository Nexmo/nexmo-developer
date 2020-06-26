---
title: The Starter Project
description: In this step you will clone the starter project
---

# The Starter Project

To make things easier, a `Starter` project is provided for you. It is a simple Android Studio project that contains an application with the following two screens:

```screenshot
image: public/assets/images/tutorials/client-sdk/android-in-app-messaging-chat/login_screen.png
```

1. Clone this [GitHub project](https://github.com/nexmo-community/client-sdk-android-tutorial-messaging).
2. Open the project in the `Android Studio` - navigate to menu `File -> Open` and select the `kotlin-start` folder from cloned repository.

All files that will be modified during this tutorial are located in the `app/src/main/java/com/vonage/tutorial/messaging/chat` directory:

```screenshot
image: public/assets/images/client-sdk/android-in-app-messaging-chat/project-files.png
```

Now it's time to fill previously generated `CONVERSATION_ID` and `JWT` tokens.

Open `Config.kt` file and fill:

1. `USER1`'s user Id and JWTs
2. `USER2`'s user Id and JWTs
3. `CONVERSATION_ID` you've created on the previous steps:

```kotlin
package com.vonage.tutorial.messaging

data class User(
    val name: String,
    val jwt: String
)

object Config {

    const val CONVERSATION_ID: String = "" // TODO: set conversation Id

    val user1 = User(
        "USER1",
        "" // TODO: "set USER1's JWT token"
    )
    val user2 = User(
        "USER1",
        "" // TODO: set USER2's JWT token"
    )
}

```

Notice that these constants and values are hardcoded to store the properties of users. This makes it easier to use these values later in this tutorial.
