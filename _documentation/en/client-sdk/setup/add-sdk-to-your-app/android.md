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

First, you need to add a custom Maven URL repository to your Gradle configuration. Add the following URL in your top-level `build.gradle` file:

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/maven'
``` 

Now to add the Nexmo Client SDK to your project, add the following dependency in your app level `build.gradle` file (typically `app/build.gradle`):

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/dependencies'
``` 



### Add permissions

To use the In-App Voice features, add audio permissions using the following procedure:

1. Add required permissions to `AndroidManifest.xml` file (typically `app/src/main/AndroidManifest.xml`):

    ```xml
    <manifest ...>
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
        <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
        <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
        <uses-permission android:name="android.permission.RECORD_AUDIO" />
    </manifest>
    ```

2. For devices running Android version M (API level 23) or higher, you should request for the `RECORD_AUDIO` permission at runtime:

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/request-permissions'
``` 

    Read more about requesting runtime permissions on Android [here](https://developer.android.com/training/permissions/requesting). 

## Using `NexmoClient` in your App

### Building `NexmoClient`

Make sure to build the NexmoClient instance before using it. The default build being:

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/build-client'
``` 

### Setting `NexmoConnectionListener`

Set `NexmoConnectionListener` that will notify you on any changes on the connection to the SDK and the availability of its functionality:

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/connection-listener'
``` 

### Login `NexmoClient`

After initializing `NexmoClient`, you need log in to it, using a `jwt` user token. This is described in the topic on [JWTs and ACLs](/client-sdk/concepts/jwt-acl).

Replace the token so as to authenticate the relevant user:

 ```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/login'
``` 

After the login succeeds, the logged in user is available via `NexmoClient.get().getUser()`.

## Conclusion

You added the Nexmo Client SDK to your Android app, initialized it, and logged in to a `NexmoClient` instance. 

In production application good place to initialize `NexmoClient` is custom Android [Application](https://developer.android.com/reference/android/app/Application) class. You can later retrieve `NexmoClient` instance using `NexmoClient.get()` method and use additional `NexmoClient` functionality.

## See also

* [Data Center Configuration](/client-sdk/setup/configure-data-center) - this is an advanced optional configuration you can carry out after adding the SDK to your application.
