---
title: The starter project
description: In this step you will clone the starter project
---

# The starter project

To make things easier, a starter project is provided for you.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/login-screen.png
```

1. Clone this [GitHub repository](https://github.com/nexmo-community/client-sdk-android-tutorial-messaging) (Android Studio `New project from version control` feature can’t be used, because repository contains two projects `kotlin-start` and `kotlin-complted`).

2. Open the `kotlin-start` project in the Android Studio:
   
   1. Navigate to the menu `File -> Open` 
   2. Select the `kotlin-start` folder from cloned repository

3. Make project `Build -> Make Project`

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/make-project.png
```

All files that will be modified during this tutorial are located in the `app/src/main/java/com/vonage/tutorial/messaging/chat` directory:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/project-files.png
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
