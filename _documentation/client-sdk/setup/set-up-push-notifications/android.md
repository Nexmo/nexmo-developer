---
title: Android
language: android
---

# How to Set Up Nexmo Push Notifications on Android

On incoming events, such as when a user receives a new message, or an incoming call, the user often expects to receive a push notification, if the app is not active.

This tutorial explains how to configure your Android app to receive push notifications from Nexmo Client SDK.

## Set up Firebase project for your app

In order to enable push notifications for your Android app, you should use the Firebase Cloud Messaging (FCM) API. To do that, start by adding Firebase to your Android project.

In case you have not done that already, more details can be found in the [official Firebase documentation](https://firebase.google.com/docs/android/setup).

## Provision your server key

Obtain a `jwt_dev`, which is a `jwt` without a `sub` claim. More details on how to generate a JWT can be found in the [setup guide](/tutorials/client-sdk-generate-test-credentials#generate-a-user-jwt).

Get your `server_api_key` from Firebase console. Navigate to Firebase console --> project settings --> CloudMessaging Tab --> `Server key`

Get your Nexmo Application ID, `app_id`. It can be obtained from [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).

Run the following Curl command, replacing `jwt_dev`, `server_api_key`, `app_id` with your values:

```sh
curl -v -X PUT \
   -H "Authorization: Bearer $jwt_dev" \
   -H "Content-Type: application/json" \
   -d "{\"token\":\"$server_api_key\"}" \
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

In order for Nexmo to be able to send push notification to a device, the Nexmo server has to know the device token, also known as InstanceID.

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

Use `NexmoClient.get().processPushNotification(message.data, listener)` to process the data received from Firebase Cloud Messaging (FCM) into an easy to use Nexmo object.

For example, in your `MyFirebaseMessagingService`:

```java
 val pushEventListener = object : NexmoPushEventListener {
        override fun onIncomingCall(p0: NexmoCall?, p1: MemberEvent?) {
            TODO("not implemented")
        }

        override fun onNewEvent(p0: NexmoEvent?) {
            TODO("not implemented")
        }

        override fun onError(p0: NexmoApiError?) {
            TODO("not implemented")
        }
    }

    override fun onMessageReceived(message: RemoteMessage?) {
        message?.data?.let {
            if (NexmoClient.isCommsPushNotification(message.data)) {
                NexmoClient.get().processPushNotification(message.data, pushEventListener)
            }

        }
    }
```

> *Note:* in order to apply any methods on Nexmo Client object (for example answer a call, hangup, and so on) Nexmo Client has to be initialized and the user has to be [logged in]((/client-sdk/getting-started/add-sdk-to-your-app/android)) to it.

## Conclusion

In this tutorial you have seen how to set up push notifications.
