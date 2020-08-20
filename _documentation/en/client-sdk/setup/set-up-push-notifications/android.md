---
title: Android
language: android
---

# Overview

On incoming events such as a new message, or an incoming call, the user often expects to receive a push notification or the app itself. If the app is not active (is in the background), push notifications are the only way to notify app about new events.

This guide explains how to configure your Android app to receive push notifications from the Client SDK.

## Set up Firebase project for your Android application

In order to enable push notifications for your Android application, you need to configure your Android application, create a new Firebase project and connect it to your Vonage API application.

## Configure Android project 

Let's start with setting up Android project.

### To add the Client SDK dependency

[Add Client SDK](/client-sdk/setup/add-sdk-to-your-app) to your project.

### Add Firebase Cloud Messaging dependency

In your IDE, in your app level `build.gradle` file (usually `app/build.gradle`), add the `firebase-messaging` dependency:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/dependencies'
```

> **NOTE:** The latest version number can be found on the [Firebase website](https://firebase.google.com/docs/cloud-messaging/android/client#add_firebase_sdks_to_your_app).

### Implement a custom service class to receive push notifications

If you do not have one already, create a class (service) that extends `FirebaseMessagingService`. 

In order for Vonage API application to be able to send push notifications to a device, the Vonage server has to know the device `token`, also known as `InstanceID`.

In your class that extends `FirebaseMessagingService`,  override `onNewToken()` method and update the `NexmoClient` by passing new `token`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/firebase-new-token'
```

Make sure your service is declared in your `AndroidManifest.xml` (typically `app/src/main/AndroidManifest.xml`) by adding `service` tag inside `application` tag:

```xml
<service android:name=".MyFirebaseMessagingService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

### Receive push notifications

Push notifications are received in your implementation of `MyFirebaseMessagingService`, on `onMessageReceived()` method.

You can use `NexmoClient.isNexmoPushNotification(message.data))` to determine if the message is sent from Vonage server.

Use `processPushNotification(message.data, listener)` to process the data received from Firebase Cloud Messaging (FCM) into an easy to use Nexmo object:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/firebase-receive-push-notifications'
```

> **NOTE:** In order to apply any methods on Nexmo Client object (for example answer a call, hangup, and so on) Nexmo Client has to be initialized and the user has to be [logged in](/client-sdk/getting-started/add-sdk-to-your-app/android) to it.

## Connect Vonage API application to Firebase

To connect Vonage API Application with Firebase you will need the following:

1. Vonage API Application id
2. Vonage User name
3. Vonage JWT token 
4. Firebase project id
5. Firebase Private Key file

### Get Vonage application Id

Obtain your `VONAGE_APP_ID`. You can access existing application in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications). If you don't have an application already you can create the new application via [Nexmo CLI](/client-sdk/setup/create-your-application).

### Create a Vonage User

Get your `VONAGE_USER_NAME`. If you don't have user already you can create one using [Nexmo CLI](/client-sdk/setup/create-your-application#create-a-user).

### Generate a Vonage User JWT

[JWTs](https://jwt.io) are used to authenticate a user into the Client SDK.

To generate a `VONAGE_JWT` for a specific user run the following command. Remember to replace the `APP_ID` and `USER_NAME` variables with values that suit your application:

```bash
nexmo jwt:generate ./private.key sub=VONAGE_USER_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=VONAGE_APP_ID
```

> **NOTE:** More details on how to generate a JWT can be found in the [setup guide](/tutorials/client-sdk-generate-test-credentials#generate-a-user-jwt).

### Get Firebase project Id

Get your `FIREBASE_PROJECT_ID` from the [Firebase console](https://console.firebase.google.com/). Navigate to `Firebase console -> Project settings -> General`.

```screenshot
image: public/screenshots/setup/client-sdk/set-up-push-notifications/firebase-project-settings.png
```

```screenshot
image: public/screenshots/setup/client-sdk/set-up-push-notifications/firebase-project-id.png
```

### Get Firebase private key file

Get your `FIREBASE_PRIVATE_KEY_FILE` from the Firebase console. Navigate to `Firebase console ->  Project settings -> Service accounts` and generate a new private key. 

```screenshot
image: public/screenshots/setup/client-sdk/set-up-push-notifications/firebase-project-settings.png
```

```screenshot
image: public/screenshots/setup/client-sdk/set-up-push-notifications/firebase-generate-new-private-key.png
```

## Putting it all together

Now your Android client is ready to receive push notifications. 

Replace `VONAGE_JWT`, `FIREBASE_PRIVATE_KEY_FILE`, `FIREBASE_PROJECT_ID`, `VONAGE_APP_ID` with previously obtained values to send a push notification.

```sh
curl -v -X PUT \
   -H "Authorization: Bearer $VONAGE_JWT" \
   -H "Content-Type: application/json" \
   -d "{\"token\":\"$FIREBASE_PRIVATE_KEY_FILE\", \"projectId\":\"$FIREBASE_PROJECT_ID\"}" \
   https://api.nexmo.com/v1/applications/$VONAGE_APP_ID/push_tokens/android  
```

## Conclusion

In this guide you have seen how to set up push notifications.