---
title: Android
language: android
---

# Overview

On incoming events such as a new message, or an incoming call, the user often expects to receive a push notification, if the app is not active (app is in the background).

This guide explains how to configure your Android app to receive push notifications from the Client SDK.

## Set up Firebase project for your app

In order to enable push notifications for your Android app, you need to configure your Android application, create a new Firebase project and connect it to your Nexmo application.

## Configure Android project 

### To add the Client SDK dependency

[Add Nexmo Client SDK](/client-sdk/setup/add-sdk-to-your-app) to your project.

### Add Firebase Cloud Messaging dependency

In your IDE, in your app level `build.gradle` file (usually `app/build.gradle`), add the `firebase-messaging` dependency:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/dependencies'
```

> **NOTE:** The latest version number can be found on the [Firebase website](https://firebase.google.com/docs/cloud-messaging/android/client#add_firebase_sdks_to_your_app).

### Implement a custom service class to receive push notifications

If you do not have one already, create a service that extends `FirebaseMessagingService`. 

In order for Nexmo to be able to send push notifications to a device, the Nexmo server has to know the device `token`, also known as `InstanceID`.

In your class that extends `FirebaseMessagingService`,  override `onNewToken()` method and update the Nexmo and pass new `token` to `NexmoClient`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/firebase-new-token'
```

Make sure your service is declared in your `AndroidManifest.xml` (typically `app/src/main/AndroidManifest.xml`):

```xml
<service android:name=".MyFirebaseMessagingService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

### Receive push notifications

Push notifications are received in your implementation of `MyFirebaseMessagingService`, on `onMessageReceived()` method.

You can use `NexmoClient.isNexmoPushNotification(message.data))` to determine if the message is sent from Nexmo server.

Use `processPushNotification(message.data, listener)` to process the data received from Firebase Cloud Messaging (FCM) into an easy to use Nexmo object:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/firebase-receive-push-notifications'
```

> **NOTE:** In order to apply any methods on Nexmo Client object (for example answer a call, hangup, and so on) Nexmo Client has to be initialized and the user has to be [logged in](/client-sdk/getting-started/add-sdk-to-your-app/android) to it.

## Connect Nexmo Application to Firebase

To connect Nexmo Application with Fiebase you will need the following:

1. Nexmo application id
2. Nexmo user Id
3. JWT token 
4. Firebase project id
5. Firebase Private Key file

### Get Nexmo application Id

Obtain your Nexmo Application ID. You can access existing application in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications). If you don't have Nexmo applicattion already you can create the new Nexmo application via [Nexmo CLI](/client-sdk/setup/create-your-application).

### Create a User

If you don't have user already you can create one using [Nexmo CLI](/client-sdk/setup/create-your-application#create-a-user).


### Generate a User JWT

[JWTs](https://jwt.io) are used to authenticate a user into the Client SDK.

To generate a JWT for a specific user run the following command. Remember to replace the `MY_APP_ID` and `MY_USER_NAME` variables with values that suit your application:

```bash
nexmo jwt:generate ./private.key sub=MY_USER_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
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

Now your Android client is ready to receive push notificaitons. 

Replease `JWT_DEV`, `FIREBASE_PRIVATE_KEY_FILE`, `FIREBASE_PROJECT_ID`, `NEXMO_APP_ID` with previously obtained values to send a push notification.

```sh
curl -v -X PUT \
   -H "Authorization: Bearer $JWT_DEV" \
   -H "Content-Type: application/json" \
   -d "{\"token\":\"$FIREBASE_PRIVATE_KEY_FILE\", \"projectId\":\"$FIREBASE_PROJECT_ID\"}" \
   https://api.nexmo.com/v1/applications/$NEXMO_APP_ID/push_tokens/android  
```

## Conclusion

In this guide you have seen how to set up push notifications.
