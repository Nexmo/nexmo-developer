---
title: Create new Android project
description: In this step you create an Android project and add the Android Client SDK library.
---

## Create an Android Project

* Open Android Studio and, from the menu, select `File` > `New` > `New Project...`.

* Select a `Empty Activity` template type and click `Next`.

* Type `Project Name` and select `Java` language.

* Click `Finish`

* You now have a brand new Android Project.

### Add dependencies

You need to add a custom Maven URL repository to your Gradle configuration. Add the following URL in your top-level `build.gradle` file:

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/maven'
``` 

Now add the Client SDK to your project. Add the following dependency in your app level `build.gradle` file (typically `app/build.gradle`):

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/dependencies'
``` 

### Set Java 1.8

Set Java 1.8 in your app level `build.gradle` file (typically `app/build.gradle`):

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/gradlejava18'
``` 
