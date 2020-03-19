---
title: Android
language: android
---

# Overview

In this guide you learn how to add the Nexmo Client SDK to your Android app.

## Prerequisites

The Nexmo Client SDK requires a minimum Android API level of 23.

## To add the Nexmo Client SDK to your project

### Open you Android project

Open your Android project codebase in your IDE.

### Add dependencies

To add the Nexmo Client SDK to your project, add the following dependency in your app level `build.gradle` file (usually `app/build.gradle`):

```groovy
dependencies {
    implementation 'com.nexmo.android:client-sdk:2.1.2'
}
```

### Add permissions

To use the In-App Voice features, add audio permissions using the following procedure:

1. On your `AndroidManifest.xml` add the required permissions:

    ```xml
    <manifest ...>

        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
        <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />

        <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
        <uses-permission android:name="android.permission.RECORD_AUDIO" />

        <application>

        </>
    </>
    ```

2. For devices running Android version M (API level 23) or higher, you should request for the `RECORD_AUDIO` permission at runtime:

    ```java
    // Here, thisActivity is the current activity
    if (ContextCompat.checkSelfPermission(thisActivity, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {

        // Permission is not granted, so we will request it
        int MY_PERMISSIONS_REQUEST_READ_CONTACTS = 123;

        ActivityCompat.requestPermissions(thisActivity, 
                                            new String[]{Manifest.permission.RECORD_AUDIO}, 
                                            MY_PERMISSIONS_REQUEST_READ_CONTACTS);
    }
    ```

    Read more about requesting runtime permissions on Android [here](https://developer.android.com/training/permissions/requesting). 

## Using `NexmoClient` in your App

### Building `NexmoClient`

Make sure to build the NexmoClient instance before using it. The default build being:

```java
NexmoClient.Builder().build(context)
```

### Setting `NexmoConnectionListener`

Set `NexmoConnectionListener` that will notify you on any changes on the connection to the SDK and the availability of its functionality:

```java
NexmoClient.get().setConnectionListener(new NexmoConnectionListener() {
    @Override
    public void onConnectionStatusChange(ConnectionStatus status, ConnectionStatusReason reason) {
        //...
        }
    });
```

### Login `NexmoClient`

After initializing `NexmoClient`, you need log in to it, using a `jwt` user token. This is described in the topic on [JWTs and ACLs](/client-sdk/concepts/jwt-acl).

Replace the token so as to authenticate the relevant user:

```java
    NexmoClient.get().login(token, requestListener)
```

After the login succeeds, the logged in user is available via `NexmoClient.get().getUser()`.

## Conclusion

You added the Nexmo Client SDK to your Android app, initialized it, and logged in to a `NexmoClient` instance.

You can now use `NexmoClient.get()` in your app, and then use additional `NexmoClient` functionality.

## See also

* [Data Center Configuration](/client-sdk/setup/configure-data-center) - this is an advanced optional configuration you can carry out after adding the SDK to your application.
