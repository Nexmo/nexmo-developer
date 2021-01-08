---
title: Create an Android project
description: In this step you create an Android project and add the Android Client SDK library.
---

# Create an Android project

## Project overview

You will be building an Android application with single screen:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-phone-to-app/nav-graph.png
```

## New Android Project

Open Android Studio and, from the menu, select `File` > `New` > `New Project...`. Select a `Empty Activity` template type and click `Next`.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/create-project-empty-activity.png
```

Enter `phone-to-app` as project name, `com.vonage.tutorial.voice` as package, select `Kotlin` language and press `Finish` button.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-phone-to-app/configure-your-project-kotlin.png
```

You now have a brand new Android Project.

### Add Nexmo dependency

You need to add a custom Maven URL repository to your Gradle configuration. Add the following `maven` block inside `allprojects` block in the project-level `build.gradle` file:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/project-level-build-gradle-file.png
```

```groovy
allprojects {
    repositories {
        google()
        jcenter()
        
        maven {
            url "https://artifactory.ess-dev.com/artifactory/gradle-dev-local"
        }
    }
}
```

Now add the Client SDK to the project. Add the following dependency in the module level `build.gradle` file:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/module-level-build-gradle-file.png
```

```groovy
dependencies {
    // ...

    implementation 'com.nexmo.android:client-sdk:2.8.0'
}
```

### Add Navigation component dependencies

To navigate between screens you will use [Navigation component](https://developer.android.com/guide/navigation).

To add navigation component dependency define a variable `ext.android_navigation_version` containing version in project-level `build.gradle` file:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/project-level-build-gradle-file.png
```

```groovy
buildscript {
    ext.android_navigation_version = '2.3.2'

    // ...
}
```

Now in the same file add dependency for Gradle `Safe Args` plugin that provides type safety when navigating and passing data between destinations.
Add new `classpath` in the `dependencies` block:

```groovy
dependencies {
    // ...

    classpath "androidx.navigation:navigation-safe-args-gradle-plugin:$android_navigation_version"
}
```

Now in the same file add navigation component dependencies:

```groovy
dependencies {
    // ...

    implementation "androidx.navigation:navigation-fragment-ktx:$android_navigation_version"
    implementation "androidx.navigation:navigation-ui-ktx:$android_navigation_version"
}
```

Click `Sync project with Gradle Files` icon to make sure build scripts have been correctly configured:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/sync-project-wth-gradle-files.png
```