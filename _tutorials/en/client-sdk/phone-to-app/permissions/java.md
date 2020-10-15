---
title: Project permissions
description: In this step you will add the necessary permissions to the project properties.
---

# Project permissions

As you'll be using the microphone when making a call, you need to request the permission to use it.

1. Add required permissions to `AndroidManifest.xml` file (typically `app/src/main/AndroidManifest.xml`):

    ```xml
    <manifest ...>
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.RECORD_AUDIO" />
    </manifest>
    ```

2. For devices running Android version M (API level 23) or higher, you should request for the `RECORD_AUDIO` permission at runtime. Add permission request in the `MainActivity` class inside `onCreate` method:


```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    // this is the current activity
    if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.RECORD_AUDIO}, 123);
    }
}
```

## Build and Run

Press `Cmd + R` to build and run the app.