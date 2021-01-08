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

To create fragment right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `LoginFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```kotlin
package com.vonage.tutorial.voice

import androidx.fragment.app.Fragment

class LoginFragment : Fragment()
```

To create view model right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `LoginViewModel` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```kotlin
package com.vonage.tutorial.voice

import androidx.lifecycle.ViewModel

public class LoginViewModel : ViewModel()
```

## Main screen

To create layout right click on `res/layout` folder, select `New` > `Layout Resource File`, enter `fragment_main` as file name and press `OK`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

To create fragment right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `MainFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```kotlin
package com.vonage.tutorial.voice

import androidx.fragment.app.Fragment

class MainFragment : Fragment()
```

To create view model right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `MainViewModel` as file name and select `Class`.

```kotlin
package com.vonage.tutorial.voice

import androidx.lifecycle.ViewModel

public class MainViewModel : ViewModel()
```

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

## `OnCall` screen 

To create layout right click on `res/layout` folder, select `New` > `Layout Resource File`, enter `fragment_on_call` as file name and press `OK`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

To create fragment right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `OnCallFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```kotlin
package com.vonage.tutorial.voice

import androidx.fragment.app.Fragment

class OnCallFragment : Fragment()
```

To create view model right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `OnCallViewModel` as file name and select `Class`.

```kotlin
package com.vonage.tutorial.voice

import androidx.lifecycle.ViewModel

public class OnCallViewModel : ViewModel()
```

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Run `Build` > `Make project` to make sure project is compiling.
