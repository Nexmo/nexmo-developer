---
title: Android
language: android
---

# Overview

On incoming events such as a new message, or an incoming call, the user often expects to receive a push notification, if the app is not active.

This guide explains how to configure your Android app to receive push notifications from the Nexmo Client SDK.

## Set up Firebase project for your app

In order to enable push notifications for your Android app, you should use the Firebase Cloud Messaging (FCM) API. To do that, start by adding Firebase to your Android project.

In case you have not done that already, more details can be found in the [official Firebase documentation](https://firebase.google.com/docs/android/setup).

## Provision your server key

Obtain a `jwt_dev`, which is a `jwt` without a `sub` claim. More details on how to generate a JWT can be found in the [setup guide](/tutorials/client-sdk-generate-test-credentials#generate-a-user-jwt).

Get your `private_key_file` from the Firebase console. Navigate to `Firebase console, Project settings, Service accounts, Firebase Admin SDK, generate new private key`. You will need to ensure the `private_key_file` is encoded to JSON using a suitable method before you can send it to the push service.

Get your `projectId` from the Firebase console. Navigate to `Firebase console, Project settings, General, projectId`.

Get your Nexmo Application ID, `app_id`. It can be obtained from [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).

Run the following Curl command, replacing `jwt_dev`, `private_key_file`, `projectId`, `app_id` with your values:

```sh
curl -v -X PUT \
   -H "Authorization: Bearer $jwt_dev" \
   -H "Content-Type: application/json" \
   -d "{\"token\":\"$private_key_file\", \"projectId\":\"$projectId\"}" \
   https://api.nexmo.com/v1/applications/$app_id/push_tokens/android  
```

## Add Firebase Cloud Messaging to your Android project

In your IDE, in your app level `build.gradle` file (usually `app/build.gradle`), add the `firebase-messaging` dependency:

```groovy
dependencies{
    implementation 'com.google.firebase:firebase-messaging:x.y.z'
}
```

You need to replace `x.y.z` with the latest Cloud Messaging versions number, which can be found on the [Firebase website](https://firebase.google.com/support/release-notes/android).

## Implement a service to receive push notifications

If you do not have one already, create a service that extends `FirebaseMessagingService`. Make sure your service is declared in your `AndroidManifest.xml`:

```xml
<service android:name=".MyFirebaseMessagingService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

## Enable Nexmo server to send push notifications to your device

In order for Nexmo to be able to send push notifications to a device, the Nexmo server has to know the device token, also known as `InstanceID`.

In your implementation of `FirebaseMessagingService`,  override `onNewToken()` and update the Nexmo servers with it:

```java
override fun onNewToken(token: String?) {
    token?.let {
        NexmoClient.get().enablePushNotifications(token, requestListener)
    }
}
```

## Receive push notifications

Push notifications are received in your implementation of `MyFirebaseMessagingService`, on `onMessageReceived()` method.

You can use `NexmoClient.isNexmoPushNotification(message.data))` to determine if the message is sent from Nexmo server.

Use `processPushNotification(message.data, listener)` to process the data received from Firebase Cloud Messaging (FCM) into an easy to use Nexmo object:

```java
// determine if the message is sent from Nexmo server
if (NexmoClient.isNexmoPushNotification(message!!.data)) {  
    NexmoPushPayload nexmoPushPayload = nexmoClient.processPushPayload(message!!.data, pushListener)
    when(nexmoPushPayload.pushTemplate){
        Custom ->
            nexmoPushEvent.customData //got custom push data 😀
        Default ->
            nexmoPushEvent.eventData // got default push event data
    }
}
```

> **NOTE:** In order to apply any methods on Nexmo Client object (for example answer a call, hangup, and so on) Nexmo Client has to be initialized and the user has to be [logged in](/client-sdk/getting-started/add-sdk-to-your-app/android) to it.

## Conclusion

In this guide you have seen how to set up push notifications.
