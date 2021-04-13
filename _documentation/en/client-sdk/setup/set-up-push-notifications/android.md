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

[Add Client SDK](/client-sdk/setup/add-sdk-to-your-app/android) to your project.

### Add Firebase Cloud Messaging dependency

In your IDE, in your app level `build.gradle` file (usually `app/build.gradle`), add the `firebase-messaging` dependency:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/dependencies'
```

> **NOTE:** The latest version number can be found on the [Firebase website](https://firebase.google.com/docs/cloud-messaging/android/client#add_firebase_sdks_to_your_app).

### Implement a custom service class to receive push notifications

If you do not have one already, create a class (service) that extends `FirebaseMessagingService`. 

In order for Vonage API application to be able to send push notifications to a device, the Vonage server has to know the device `InstanceID`.

In your class that extends [`FirebaseMessagingService`](https://firebase.google.com/docs/reference/android/com/google/firebase/messaging/FirebaseMessagingService),  override `onNewToken()` method and update the `NexmoClient` by passing a new `token`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/firebase-new-token'
```

Make sure your service is declared in your `AndroidManifest.xml` (typically `app/src/main/AndroidManifest.xml`) by adding `service` tag inside `application` tag:

![](/screenshots/tutorials/client-sdk/android-shared/android-manifest-file.png)

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

Use `processPushNotification(message.data, listener)` to process the data received from Firebase Cloud Messaging (FCM) into a ready to use object:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/android/firebase-receive-push-notifications'
```

> **NOTE:** In order to apply any methods on the `NexmoClient` object (for example answer a call, hangup, and so on), the `NexmoClient` has to be initialized and the user has to be [logged in](/client-sdk/getting-started/add-sdk-to-your-app/android) to it.

## Connect Vonage backend push service to Firebase

To connect Vonage backend push service with Firebase you will need the following:

1. Vonage API Application id
1. Vonage Application private key (upload tool method) or Vonage developer JWT (terminal method)
3. Firebase project id
4. Firebase token

### Get Vonage application Id

Obtain your Vonage API Application id. You can access the existing applications in the [dashboard](https://dashboard.nexmo.com/voice/your-applications). If you don't have an application already you can create the new application via [Nexmo CLI](/client-sdk/setup/create-your-application).

### Get Firebase project Id

Get your Firebase project id from the [Firebase console](https://console.firebase.google.com/). Navigate to `Firebase console -> Project settings -> General`.

![](/screenshots/setup/client-sdk/set-up-push-notifications/firebase-project-settings.png)

![](/screenshots/setup/client-sdk/set-up-push-notifications/firebase-project-id.png)

### Get Firebase Server Key

Get your Firebase Server Key from the [Firebase console](https://console.firebase.google.com/). Navigate to `Firebase console ->  Project settings -> Service accounts` and generate a new private key. 

![](/screenshots/setup/client-sdk/set-up-push-notifications/firebase-project-settings.png)

![](/screenshots/setup/client-sdk/set-up-push-notifications/firebase-token.png)

## Connect Vonage API application to Firebase

You connect Vonage backend push service with the Firebase application by making a POST request. You can to this request using the Upload Tool or making a POST request directly.

### Using the Upload Tool

The Android Push Certificate Uploading Tool, available on [GitHub](https://github.com/nexmo-community/android-push-uploader), allows you to upload with a user interface.

To use the tool you will need to run it locally or deploy it. You can follow the the instructions in the GitHub project's [README](https://github.com/nexmo-community/android-push-uploader#running-the-project). You will also need the private key for your Vonage Application. 

Once you have the tool running, enter your Vonage Application ID, private key file, Firebase project id, Firebase Server Key and click upload. The status of your upload will be shown on the page once it is complete:

![Android Push Certificate Uploading Tool success](/images/client-sdk/push-notifications/android-push-uploader-success.png)

### Using the Terminal

To connect the Vonage backend push service with the Firebase application you need to make a single POST request. Before making request you will have to generate Vonage developer JWT (above upload tool generates this JWT under the hood).

> **NOTE** [JWTs](https://jwt.io) are used to authenticate a user into the Client SDK.

To generate a Vonage developer JWT run the following command. Remember to replace the `VONAGE_APP_ID` with id of your Vonage application:

```bash
nexmo jwt:generate ./private.key exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{},"/*/legs/**":{}}}' application_id=VONAGE_APP_ID
```

> **NOTE** The above commands set the expiry of the JWT to one day from now, which is the maximum.

> **NOTE** A `VONAGE_DEV_JWT` is a JWT without a sub claim. 

> **NOTE:** More details on how to generate a JWT can be found in the [setup guide](/tutorials/client-sdk-generate-test-credentials#generate-a-user-jwt).

Fill `VONAGE_APP_ID`, `VONAGE_DEV_JWT`, `FIREBASE_PROJECT_ID` and `FIREBASE_SERVER_KEY` with previously obtained values and run the below command to fire the request:

```sh
VONAGE_APP_ID=
VONAGE_DEV_JWT=
FIREBASE_PROJECT_ID=
FIREBASE_SERVER_KEY=

curl -v -X PUT \
   -H "Authorization: Bearer $VONAGE_DEV_JWT" \
   -H "Content-Type: application/json" \
   -d "{\"token\":\"$FIREBASE_SERVER_KEY\", \"projectId\":\"$FIREBASE_PROJECT_ID\"}" \
   https://api.nexmo.com/v1/applications/$VONAGE_APP_ID/push_tokens/android  
```

> **NOTE** There is no validation at this endpoint. The `200` return code means that Vonage got the data and stored it but hasn't checked that values are valid.

If all the values are correct you should see `200` response code in the terminal.

## Putting it all together

Now you can test your push notification setup by calling any user. Incoming call will trigger `onIncomingCall` callback presented above.

## Conclusion

In this guide you have seen how to set up push notifications.
