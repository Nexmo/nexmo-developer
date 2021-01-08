---
title: Setup navigation
description: In this step you will setup navigation component.
---

# Setup navigation

## Create application nav graph

Right click at `res` folder, select `New` > `Android resource file`:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/new-android-resource-file.png
```

Enter `app_nav_graph` as file name, select `Navigation` as resource type and press `OK` button.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/new-app-nav-graph.png
```

Click `Code` button in top right corner and Replace it's content with below code snippet to set navigation graph for the application:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/show-code-view.png
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<navigation xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        xmlns:tools="http://schemas.android.com/tools"
        android:id="@+id/app_navigation_graph"
        app:startDestination="@id/loginFragment">
    <fragment
            android:id="@+id/loginFragment"
            android:name="com.vonage.tutorial.voice.LoginFragment"
            tools:layout="@layout/fragment_login">
        <action
                android:id="@+id/action_loginFragment_to_mainFragment"
                app:destination="@id/mainFragment" />
    </fragment>
    <fragment
            android:id="@+id/mainFragment"
            android:name="com.vonage.tutorial.voice.MainFragment"
            tools:layout="@layout/fragment_main">
        <action
                android:id="@+id/action_mainFragment_to_onCallFragment"
                app:destination="@id/onCallFragment" />
    </fragment>

    <fragment
            android:id="@+id/onCallFragment"
            android:name="com.vonage.tutorial.voice.OnCallFragment"
            tools:layout="@layout/fragment_on_call" />

</navigation>

```

Navigation graph defines navigation directions between fragments in the application. Notice that now `LoginFragment` is now start fragment in the application

## Add `NavHostFragment`

Set `app_nav_graph` as main navigation graph of the application. Open `activity_main.xml`, click `Code` button in top right corner file and Replace XML layout code:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/activity-main-layout-file.png
```

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/show-code-view.png
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        tools:context=".MainActivity">

    <fragment
            android:id="@+id/navHostFragment"
            android:name="androidx.navigation.fragment.NavHostFragment"
            android:layout_width="0dp"
            android:layout_height="0dp"
            app:defaultNavHost="true"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:navGraph="@navigation/app_nav_graph" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

Now `NavHostFragment` with navigation graph (`@navigation/app_nav_graph`) will serve as main navigation mechanism within this application.

## Configure navigation in the `MainActivity`

Define two helpers - `BackPressHandler` and `NavManager` to simplify the navigation

### Create `BackPressHandler` interface

`BackPressHandler` interface will help with handling pressing of the back button. Right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `BackPressHandler` as file name, select `Interface`. Add `onBackPressed` method to the `BackPressHandler` interface:

```kotlin
package com.vonage.tutorial.voice

interface BackPressHandler {
    fun onBackPressed()
}
```

### Create `NavManager` object

`NavManager` object will allow to navigate directly from `ViewModel` by storing reference to navigation controller.

Right click on `com.vonage.tutorial.voice` package, select `New` > `Kotlin Class/File`, enter `NavManager` as file name, select `Object`. Replace file content with below code snippet:

```kotlin
package com.vonage.tutorial.voice

import androidx.navigation.NavController
import androidx.navigation.NavDirections

object NavManager {
    private lateinit var navController: NavController

    fun init(navController: NavController) {
        NavManager.navController = navController
    }

    fun navigate(navDirections: NavDirections) {
        navController.navigate(navDirections)
    }

    fun popBackStack(@IdRes destinationId: Int, inclusive: Boolean) {
        navController.popBackStack(destinationId, inclusive);
    }
}
```

### Update `MainActivity`

Add `onBackPressed` method to the `MainActivity`:

```kotlin
class MainActivity : AppCompatActivity(R.layout.activity_main) {

    // ...

    override fun onBackPressed() {
        val childFragmentManager = supportFragmentManager.primaryNavigationFragment?.childFragmentManager
        val currentNavigationFragment = childFragmentManager?.fragments?.first()

        if(currentNavigationFragment is BackPressHandler) {
            currentNavigationFragment.onBackPressed()
        }

        super.onBackPressed()
    }
}
```

To initialize `NavManager` call it's `init` method from `MainActivity.onCreate` method:

```kotlin
class MainActivity : AppCompatActivity(R.layout.activity_main) {

    override fun onCreate(savedInstanceState: Bundle?) {
        
        // ...

        val navController = Navigation.findNavController(this, R.id.navHostFragment)
        NavManager.init(navController)
    }

    // ...
}

```

Run `Build` > `Make project` to make sure project is compiling.