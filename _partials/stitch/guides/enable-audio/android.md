---
title: Android
platform: android
---

# Getting Started with Nexmo In-App Voice for Android

In this getting started guide we'll cover adding audio events to the Conversation we created in the previous quickstarts. We'll deal with media events, the ones that come via the conversation, and the ones we send to the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Audio Stream** - The stream that the SDK gives you in your browser to listen to audio and send audio
- **Audio Leg** - A server side API term. Legs are a part of a conversation. When audio is enabled on a conversation, a leg is created
- **MemberMedia** - `MemberMedia` events that fire on a Conversation when media state changes for a member

## Before you begin

- Run through the [previous quickstarts](/stitch/in-app-messaging/guides/utilizing-events/android)
- If you're continuing on from the previous guide you may need to regenerate the users JWTs. See quickstarts 1 and 2 for how to do so.

## 1 - Update the Android App

We will use the application we created for the previous quickstarts. All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 1.1 - Update permissions in `AndroidManifest`

Since we'll be working with audio, we need to add the necessary permissions to the app.

Add the following to your `AndroidManifest`

```xml
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

### 1.2 - Create an audio button

We want our users to be able to enable and disable audio at will. So in the `ChatActivity` we'll add a button in the options menu that will enable and disable audio.

```java
// ChatActivity.java
@Override
public boolean onCreateOptionsMenu(Menu menu) {
    MenuInflater inflater = getMenuInflater();
    inflater.inflate(R.menu.chat_menu, menu);
    return true;
}

@Override
public boolean onOptionsItemSelected(MenuItem item) {
    switch (item.getItemId()) {
        case R.id.audio:
            //TODO: implement
            requestAudio();
            return true;
        default:
            return super.onOptionsItemSelected(item);
    }
}
```

Our `chat_menu` will look like this:

```xml
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto">
    <item android:id="@+id/audio"
        android:title="Audio"
        android:icon="@drawable/ic_record_voice_over_black_24dp"
        app:showAsAction="ifRoom"/>
</menu>
```

I've added an icon using [Vector Assets](https://developer.android.com/studio/write/vector-asset-studio.html) but you don't have to.

### 1.3 - Requesting Audio permissions

Before we can enable In-App Voice in our app we need to check or request the `RECORD_AUDIO` permission. To check that we have permission, we'll call the `ContextCompat.checkSelfPermission()` method. If `ActivityCompat.shouldShowRequestPermissionRationale()` is true, then the user has approved the permission. But if it's false, the permission is denied and we'll show our reasoning to enable it. If we need to request the permission we'll do so with `ActivityCompat.requestPermissions()`. We'll handle this logic in the `requestAudio()` method. We'll also need to create a constant `PERMISSION_REQUEST_AUDIO` to check if the permission was granted or not.

For more info about permissions check out the [Android Developers documentation.](https://developer.android.com/training/permissions/requesting.html)

```java
// ChatActivity.java
private static final int PERMISSION_REQUEST_AUDIO = 0;

//rest of activity...

private void requestAudio() {
    if (ContextCompat.checkSelfPermission(ChatActivity.this, RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED) {
        //TODO: implement
        toggleAudio();
    } else {
        if (ActivityCompat.shouldShowRequestPermissionRationale(this, RECORD_AUDIO)) {
            logAndShow("Need permissions granted for Audio to work");
        } else {
            ActivityCompat.requestPermissions(ChatActivity.this, new String[]{RECORD_AUDIO}, PERMISSION_REQUEST_AUDIO);
        }
    }
}
```

After we ask the user for the `RECORD_AUDIO` permission we'll get the result of their decision in `onRequestPermissionsResult()` If they granted it we'll call `toggleAudio()` to enable/disable audio in the app. If the user didn't grant the permission we'll pop a toast and log out that we need to enable audio permissions to continue.

```java
// ChatActivity.java
@Override
public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    switch (requestCode) {
        case PERMISSION_REQUEST_AUDIO: {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                //TODO: implement
                toggleAudio();
                break;
            } else {
                logAndShow("Enable audio permissions to continue");
                break;
            }
        }
        default: {
            logAndShow("Issue with onRequestPermissionsResult");
            break;
        }
    }
}
```

### 1.4 - Enabling and disabling audio

Now we can implement the `toggleAudio()` method. We'll use a constant `AUDIO_ENABLED` to note if audio is enabled or not and initialize it to false. When we change the state of audio in the app we'll change the boolean.

At this point, enabling and disabling In-App Voice in your app is as simple as calling `conversation.media(Conversation.MEDIA_TYPE.AUDIO).enable()` or  `conversation.media(Conversation.MEDIA_TYPE.AUDIO).disable()`. `.disable()` takes a `RequestHandler` as an argument with `onSuccess()` and `onError()` callbacks.

The `.enable()` methods takes a `AudioCallEventListener` with multiple callbacks that handle the state of audio. The audio will enter a `onRinging()` state, then `onCallConnected()` when the user has joined the audio channel. If the user disables audio `onCallEnded()` will fire. If any kind of error occurs, then the `onGeneralCallError()` callback will fire. `onAudioRouteChange()` is called when the audio manager reports an audio device change, like when switching from the device's in ear speaker to a wired headset.

```java
// ChatActivity.java
private boolean AUDIO_ENABLED = false;

//rest of activity...

private void toggleAudio() {
    if(AUDIO_ENABLED) {
        conversation.media(Conversation.MEDIA_TYPE.AUDIO).disable(new RequestHandler<Void>() {
            @Override
            public void onError(NexmoAPIError apiError) {
                logAndShow(apiError.getMessage());
            }

            @Override
            public void onSuccess(Void result) {
                AUDIO_ENABLED = false;
                logAndShow("Audio is disabled");
            }
        });
    } else {
        conversation.media(Conversation.MEDIA_TYPE.AUDIO).enable(new AudioCallEventListener() {
            @Override
            public void onRinging() {
                logAndShow("Ringing");
            }

            @Override
            public void onCallConnected() {
                logAndShow("Connected");
                AUDIO_ENABLED = true;
            }

            @Override
            public void onCallEnded() {
                logAndShow("Call Ended");
                AUDIO_ENABLED = false;
            }

            @Override
            public void onGeneralCallError(NexmoAPIError apiError) {
                logAndShow(apiError.getMessage());
                AUDIO_ENABLED = false;
            }

            @Override
            public void onAudioRouteChange(AppRTCAudioManager.AudioDevice device) {
                logAndShow("Audio Route changed");
            }
        });
    }
}
```

Now we could try out In-App Voice right now by launching the app on two devices and pressing the audio button, but we wouldn't know if the other user enabled audio on their device! In order to know that we need to make some changes to `ChatAdapter.java`

Note that enabling audio in a conversation establishes an audio leg for a member of the conversation. The audio is only streamed to other members of the conversation who have also enabled audio.

## 2 - Showing `MemberMedia` events

In the previous quickstart we added a `RecyclerView` to our app and showed the chat history by adding `ChatAdapter.java`. As a refresher, to observe events that happens in a conversation we've tapped into `conversation.messageEvent()` and added a `ResultListener` that's fired whenever there's new event. Up until now, the only events we've dealt with are `Text`. Now we're going to handle any `MemberMedia` events that get sent to a conversation.

### 2.1 - Handling `MemberMedia` events in `ChatAdapter.java`

We're going to make some changes to the `onBindViewHolder()` method. Currently we check for `Text` events like so: `if (events.get(position).getType().equals(EventType.TEXT))`.

Now we need to add a check for `MemberMedia` events with an `else if`.

```java
// ChatAdapter.java

@Override
    public void onBindViewHolder(ChatAdapter.ViewHolder holder, int position) {
        if (events.get(position).getType().equals(EventType.TEXT)) {
          // the current logic for handling Text events
          ...
        } else if (events.get(position).getType().equals(EventType.MEMBER_MEDIA)) {
            final MemberMedia mediaMessage = (MemberMedia) events.get(position);
            holder.text.setText(mediaMessage.getMember().getName() + (mediaMessage.isAudioEnabled() ? " enabled" : " disabled") + " audio.");
            holder.seenIcon.setVisibility(View.INVISIBLE);
        }
```

After we check that the event `equals(EventType.MEMBER_MEDIA)` we'll show a message in the adapter that tells who enabled or disabled audio. Don't forget to set the visibility of the `seenIcon`! We'll just always set it to invisible in this case.

## Try it out!

After this you should be able to run the app in two different android devices or emulators. Try enabling or disabling audio and speaking to yourself or a friend!

_Note: Don't forget to generate new JWTs for you users if it's been over 24 hours since you last generated the user JWTs._

The [next guide](/stitch/in-app-voice/guides/calling-users) covers how to easily call users with the convenience method `call()`. This method offers an easy to use alternative for creating a conversation, inviting users and manually enabling their audio streams.

[View the source code for this example.](https://github.com/Nexmo/conversation-android-quickstart)
