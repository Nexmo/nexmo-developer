---
title: How to Add the Nexmo Client SDK to your Android App
products: client-sdk
description: This tutorial shows you how to add the Nexmo Client SDK to your Android application.
languages:
    - Java
---

# How to Add the Nexmo Client SDK to your Android App

This tutorial shows you how to add the  Nexmo Client SDK to your Android app.

## Prerequisites

The Nexmo Client SDK requires a minumum Android API level of 16.

## To add the Nexmo Client SDK to your project

### Open you Android project

Open your Android project codebase in your IDE.

### Add dependencies

To add the Nexmo Client SDK dependencies to your project use the following procedure:

1. In your app level `build.gradle` file (usually `app/build.gradle`), add the dependency:

    ```groovy
    dependencies {
        implementation 'com.nexmo.android:client-sdk:0.7.26'
    }

    ```

2. In your project level `build.gradle` file, add the Maven repository:

    ```groovy

    buildscript {
        repositories {
            maven {
                url "https://artifactory.ess-dev.com/artifactory/gradle-dev-local"
            }
        }
        //...
    }

    allprojects {
        repositories {
            ...
            maven {
                url "https://artifactory.ess-dev.com/artifactory/gradle-dev-local"
            }
        }
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
        <uses-permission android:name="android.permission.PROCESS_OUTGOING_CALLS" />
        <uses-permission android:name="android.permission.READ_PHONE_STATE" />

        <application>

        </>
    </>
    ```

2. For devices running Android version M (API level 23) or higher, you should add a request for the permissions required:

    ```java
    android.Manifest.permission.READ_PHONE_STATE, android.Manifest.permission.RECORD_AUDIO, android.Manifest.permission.PROCESS_OUTGOING_CALLS
    ```

    Read more about requesting runtime permissions on Android [here]("https://developer.android.com/training/permissions/requesting")

## Using NexmoClient in your App

### Init NexmoClient

Before being able to use a `NexmoClient` instance, you need to initialize it:

```java
loginListener = object : NexmoLoginListener {
    override fun onLoginStateChange(eLoginState: NexmoLoginListener.ELoginState, eLoginStateReason: NexmoLoginListener.ELoginStateReason) {
        //TODO
    }

    override fun onAvailabilityChange(eAvailability: NexmoLoginListener.EAvailability, nexmoConnectionState: NexmoConnectionState) {
        //TODO
    }
}

NexmoClient.init(context, loginListener)
```

### Login NexmoClient

After initializing `NexmoClient`, you need log in to it, using a `jwt` user token. This is described in the topic on [JWTs and ACLs](/client-sdk/concepts/jwt-acl).

Replace the token so as to authenticate the relevant user:

```java
    NexmoClient.get().login(token, loginListener)
```

After the login succeeds, the logged in user is available via `NexmoClient.get().getUser()`.

## Conclusion

You added the Nexmo Client SDK to your Android app, initialized it, and logged in to a `NexmoClient` instance.

You can now use `NexmoClient.get()` in your app, and then use additional `NexmoClient` functionality.
