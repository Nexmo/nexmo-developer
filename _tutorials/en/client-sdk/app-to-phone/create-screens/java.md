---
title: Create screens
description: In this step you create screens.
---

# Create empty screens

You will now create placeholders for screens in the application (we will define layouts and the functionality in following steps of this tutorial). You will create few files for each screen:

- Layout
- Fragment (view)
- `ViewModel` (manages the view)

We will define layouts and functionality in following steps of this tutorial.

## Login screen

To create layout right click on `res/layout` folder, select `New` > `Layout Resource File`, enter `fragment_login` as file name and press `OK`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

To create fragment right click on `com.vonage.tutorial.voice` package, select `New` > `Java Class`, enter `LoginFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```java
package com.vonage.tutorial.voice;

import androidx.fragment.app.Fragment;

public class LoginFragment extends Fragment {
}
```

> **NOTE** You can also create a new class by selecting `voice` package, and pasting code snippet.

To create view model right click on `com.vonage.tutorial.voice` package, select `New` > `Java Class`, enter `LoginViewModel` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```java
package com.vonage.tutorial.voice;

import androidx.lifecycle.ViewModel;

public class LoginViewModel extends ViewModel {

}
```

## Main screen

To create layout right click on `res/layout` folder, select `New` > `Layout Resource File`, enter `fragment_main` as file name and press `OK`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

To create fragment right click on `com.vonage.tutorial.voice` package, select `New` > `Java Class`, enter `MainFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```java
package com.vonage.tutorial.voice;

import androidx.fragment.app.Fragment;

public class MainFragment extends Fragment {
}
```

To create view model right click on `com.vonage.tutorial.voice` package, select `New` > `Java Class`, enter `MainViewModel` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```java
package com.vonage.tutorial.voice;

import androidx.lifecycle.ViewModel;

public class MainViewModel extends ViewModel {

}
```

## `OnCall` screen 

To create layout right click on `res/layout` folder, select `New` > `Layout Resource File`, enter `fragment_on_call` as file name and press `OK`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

To create fragment right click on `com.vonage.tutorial.voice` package, select `New` > `Java Class`, enter `OnCallFragment` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```java
package com.vonage.tutorial.voice;

import androidx.fragment.app.Fragment;

public class OnCallFragment extends Fragment {
}
```

To create view model right click on `com.vonage.tutorial.voice` package, select `New` > `Java Class`, enter `OnCallViewModel` as file name and select `Class`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/voice-package.png
```

Replace file content with below snippet:

```java
package com.vonage.tutorial.voice;

import androidx.lifecycle.ViewModel;

public class OnCallViewModel extends ViewModel {

}
```

Run `Build` > `Make project` to make sure project is compiling.
