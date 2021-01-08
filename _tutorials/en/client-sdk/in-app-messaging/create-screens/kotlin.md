---
title: Create screens
description: In this step you create screens.
---

# Create empty screens

You will now create placeholders for screens in the application (we will define layouts and the functionality in following steps of this tutorial). You will create few files for each screen:

- Layout
- Fragment (view)
- `ViewModel` (manages the view)

## Login screen

To create layout right click on `res/layout` folder, select `New` > `Layout Resource File`, enter `fragment_login` as file name and press `OK`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

To create fragment right click on `com.vonage.tutorial.messaging` package, select `New` > `Kotlin Class/File`, enter `LoginFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/messaging-package.png
```

Replace file content with below snippet:

```kotlin
package com.vonage.tutorial.messaging

import androidx.fragment.app.Fragment

class LoginFragment : Fragment()
```

To create view model right click on `com.vonage.tutorial.messaging` package, select `New` > `Kotlin Class/File`, enter `LoginViewModel` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/messaging-package.png
```

Replace file content with below snippet:

```kotlin
package com.vonage.tutorial.messaging

import androidx.lifecycle.ViewModel

public class LoginViewModel : ViewModel() {

}
```

## Chat screen

To create layout right click on `res/layout` folder, select `New` > `Layout Resource File`, enter `fragment_chat` as file name and press `OK`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

To create fragment right click on `com.vonage.tutorial.messaging` package, select `New` > `Kotlin Class/File`, enter `ChatFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/messaging-package.png
```

Replace file content with below snippet:

```kotlin
package com.vonage.tutorial.messaging

import androidx.fragment.app.Fragment

class ChatFragment : Fragment()
```

To create view model right click on `com.vonage.tutorial.messaging` package, select `New` > `Kotlin Class/File`, enter `ChatViewModel` as file name and select `Class`.

```kotlin
package com.vonage.tutorial.messaging

import androidx.lifecycle.ViewModel

public class ChatViewModel : ViewModel() {

}
```

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/messaging-package.png
```

Run `Build` > `Make project` to make sure project is compiling.
