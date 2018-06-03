---
title: Android
platform: android
---

# Showing Push Notifications from Stitch in your Android app

The Nexmo Stitch SDK for Android offers the feature of showing push notifications when an event is fired in a conversation. You can get a notification for the following events:

- The logged in user is invited to a conversation.
- The logged in user is invited to an audio enabled conversation.
- A Text Event is sent to a conversation the logged in user is a part of.
- An image is sent to a conversation the logged in user is a part of.

## Prerequisites

## Getting Started

To receive push notifications, you'll have to set up your project with [Firebase Cloud Messaging (FCM)](https://firebase.google.com/docs/cloud-messaging/). You can do so by following their setup instructions for [Adding Firebase to Your Android Project](https://firebase.google.com/docs/android/setup). After FCM is added to the project we'll continue in the ["//TODO"](//TODO$LINK) section.

## Firebase

### Add Firebase Cloud Messaging dependencies to the app

Add This to `build.gradle`

```groovy
//build.gradle
  dependencies {
    ...
    classpath 'com.google.gms:google-services:3.3.1'
  }
```

and this to `app/build.gradle`

```groovy
//app/build.gradle

dependencies {
  ...
  implementation 'com.google.firebase:firebase-messaging:15.0.2'
}

// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

Ensure you downloaded a [`google-services.json` file](https://support.google.com/firebase/answer/7015592) and placed it in your in your project's module folder, typically `app/`.

### Provision your server key with Nexmo Stitch

For this next step we'll need three things. The server key from Firebase, your Nexmo application's ID, and a JWT without a `sub` field- we'll call that your _system token_. We're going to provision your Firebase server key to the Nexmo Stitch API, using your application ID as an identifier and the system token for authentication. First, retrieve your Firebase server key from the [Firebase console](https://console.firebase.google.com/) and click on the project you created, or create a new one if you haven't. Then continue with these steps:

1. click the settings icon/cog wheel next to your project name at the top of the new Firebase Console
2. Click <kbd>Project settings</kbd>
3. Click on the <kbd>Cloud Messaging</kbd> tab
4. The key is right under <kbd>Server Key</kbd>

Let's go to our terminal and store that Firebase server key as a bash variable:

```sh
$ FIREBASE_SERVER_KEY=AAAA...........
```

Now that we have our server key, we can retrieve our Nexmo Application ID from the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications) or by using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli#applications).

```sh
$ nexmo apps:list
```

Alternatively, you can create a new application [follow steps in quickstart 1](//TODO$LINK).

We'll also store the Application ID as a bash variable:

```sh
$ APPLICATION_ID=aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Finally, using our application ID and and private.key that was generated when we first created the Nexmo Application, we can create the system token. You should navigate to the directory the `private.key` file is in and then run the following command:

```sh
$ SYSTEM_TOKEN=$(nexmo jwt:generate private.key application_id=$APPLICATION_ID acl=""paths": {"/v1/users/**": {}, "/v1/conversations/**": {}, "/v1/sessions/**": {}, "/v1/devices/**": {}, "/v1/image/**": {}, "/v3/media/**": {}, "/v1/applications/**": {}"/v1/push/**": {}}")
```

After you've successfully ran the command. Verify for yourself that the JWT generated is correct. You can visit [jwt.io](jwt.io) and paste in your the output of `SYSTEM_TOKEN`. Make sure that the payload has the `application_id` and `acl` properties.

What we've done is create a master JWT that has access to all endpoints for your Nexmo application. Don't share this JWT! We're going to use this JWT to authenticate your request to the Nexmo API endpoint to upload your Firebase server key.

The final set up step is to upload the Firebase server key. Assuming that you still have the previous bash variables in your session you can run the following command:

```sh
curl -v -X PUT \
   -H "Authorization: Bearer $SYSTEM_TOKEN" \
   -H "Content-Type: application/json" \
   -d "{\"token\":\"$FIREBASE_SERVER_KEY\"}" \
   https://api.nexmo.com/v1/applications/$APPLICATION_ID/push_tokens/android
```

If you see `HTTP/2 200` in the response from the curl request then your Firebase server key was successfully uploaded!


### Firebase services

```java
public class StitchFirebaseInstanceIdService extends FirebaseInstanceIdService {

    @Override
    public void onTokenRefresh() {
        // Get updated InstanceID token.
        String refreshedToken = FirebaseInstanceId.getInstance().getToken();
        Log.d(TAG, "Refreshed token: " + refreshedToken);

        final ConversationClientApplication app = (ConversationClientApplication) getApplication();
        ConversationClient client = app.getConversationClient();
        client.setPushDeviceToken(refreshedToken);
    }
}
```

```java
public class StitchFirebaseService extends FirebaseMessagingService {
    public final String TAG = this.getClass().getName();
    private static final String NOTIFICATION_CHANNEL_ID = "misc";
    public static final String ACTION_BROADCAST_CID = "com.nexmo.sdk.core.gcm.BROADCAST_CID";
    public static final String MESSAGE_KEY_CID = "conversation_id";
    public static final String MESSAGE_KEY_TITLE = "title";

    public StitchFirebaseService() {}


    @Override
    public void onMessageReceived(RemoteMessage message){
        Log.d(TAG, message.toString());
        String from = message.getFrom();
        Map data = message.getData();
        Log.d(TAG, data.toString());
        String cid = null;
        if (data.containsKey(MESSAGE_KEY_CID)) {
            cid = (String) data.get(MESSAGE_KEY_CID);
            Log.d(TAG, "cid" + cid);
        }

        //TODO show message text
        showNotification("New notification", "Message text");
        broadcastPayload(cid);
    }

    /**
     * Manually display a notification indicating the user that a message was received.
     * If a notification with the same id has already been posted by your application and
     * has not yet been canceled, it will be replaced by the updated information.
     *
     * @param notificationTitle The notification title.
     * @param payload           The notification message.
     */
    private void showNotification(final String notificationTitle, final String payload) {
        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this, "misc")
                .setContentTitle(notificationTitle)
                .setContentText(payload)
                .setSmallIcon(R.drawable.ic_send_black_24dp)
                .setAutoCancel(true);

        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        // Build and issue the notification. All pending notifications with same id will be canceled.

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && notificationManager != null) {
            NotificationChannel notificationChannel = new NotificationChannel(NOTIFICATION_CHANNEL_ID,
                    "Miscellaneous", NotificationManager.IMPORTANCE_DEFAULT);
            notificationManager.createNotificationChannel(notificationChannel);
        }


        if (notificationManager != null) {
            notificationManager.notify(0, notificationBuilder.build());
        }
    }

    private void broadcastPayload(final String cid) {
        Intent intent = new Intent(ACTION_BROADCAST_CID);
        intent.putExtra(MESSAGE_KEY_CID, cid);
        LocalBroadcastManager.getInstance(getApplicationContext()).sendBroadcast(intent);
    }
}

```

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.nexmo.conversationdemo">
    ...
  <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
  <uses-permission android:name="android.permission.WAKE_LOCK" />
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

   <application
     ...>

    <service android:name=".StitchFirebaseInstanceIdService">
      <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT" />
      </intent-filter>
    </service>

    <service
      android:name=".StitchFirebaseService"
      android:enabled="true"
      android:exported="true">

      <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
      </intent-filter>
    </service>

  </application>
```


## Correctly using Channels for your notifications:
https://developer.android.com/training/notify-user/channels

## LoginActivity


## Try it out
