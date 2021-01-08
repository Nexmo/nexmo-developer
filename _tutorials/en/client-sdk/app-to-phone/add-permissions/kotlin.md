---
title: Add permissions
description: In this step you add permissions
---

# Add permissions

## Declare permissions in Android Manifest

Add the required permissions to the `AndroidManifest.xml` file:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/android-manifest-file.png
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.vonage.tutorial">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    ...
```

## Request permissions at runtime

To request permissions, add the following code to the `onCreate` method of the `MainActivity` class:

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    
    // ...

    val callsPermissions = arrayOf(Manifest.permission.RECORD_AUDIO)
    ActivityCompat.requestPermissions(this, callsPermissions, 123)
}
```

> **NOTE** To simplify the tutorial, the permissions are requested each time application runs.