---
title: Java
language: java
---

# Enable Audio in your Application

In this guide we'll cover adding audio events to the Conversation we have created in the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/java) guide. We'll deal with sending and receiving media events to and from the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Audio Leg** - A server side API term. Legs are a part of a conversation. When audio is enabled on a conversation, a leg is created
- **Media Event** - a `NexmoMediaEvent` event that fires on a Conversation when the media state changes for a member

## Before you begin

Run through the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/java). You will be building on top of this project.

## Add audio permissions

Since enabling audio uses the device microphone, you will need to ask the user for permission. 

Add new entry in the `app/src/AndroidManifest.xml` file (below last `<uses-permission` tag):

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

### Request permission on application start

Request permissions inside the `onViewCreated` method of the `LoginFragment` class:

``` java
@Override
public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
    // ...

    String[] callsPermissions = { Manifest.permission.RECORD_AUDIO };
    ActivityCompat.requestPermissions(this, callsPermissions, 123);
}
```

## Add audio UI

Add two buttons for the user to enable and disable audio. Open `app/src/main/res/layout/fragment_chat.xml` file and add two new buttons (`enableMediaButton` and `disableMediaButton`) inside `chatContainer`:

``` xml
<!--...-->

<androidx.constraintlayout.widget.ConstraintLayout
        android:id="@+id/chatContainer"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:visibility="gone"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintRight_toRightOf="parent"
        app:layout_constraintTop_toBottomOf="parent"
        tools:visibility="visible">

    <Button
            android:id="@+id/enableMediaButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            app:layout_constraintBottom_toTopOf="@id/conversationEventsScrollView"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            android:text="Enable Audio" />

    <Button
            android:id="@+id/disableMediaButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            app:layout_constraintBottom_toTopOf="@id/conversationEventsScrollView"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            android:visibility="gone"
            android:text="Disable Audio"
            tools:visibility="visible"/>
<!--...-->
```

Now you need to make sure that these buttons are accessible in the fragment. Add two new properties in the `ChatFragment` class:

```java
private Button enableMediaButton;
private Button disableMediaButton;
```

retrieve the buttons' reference by adding `findViewById` calls in the `onViewCreated` method:

```java
public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {

    //...
    enableMediaButton = view.findViewById(R.id.enableMediaButton);
    disableMediaButton = view.findViewById(R.id.disableMediaButton);
}
```

Add click event listeners for the buttons, inside the `onViewCreated` method:

```java
enableMediaButton.setOnClickListener(it -> {
    viewModel.enableMedia();
    enableMediaButton.setVisibility(View.GONE);
    disableMediaButton.setVisibility(View.VISIBLE);
});

disableMediaButton.setOnClickListener(it -> {
    viewModel.disableMedia();
    enableMediaButton.setVisibility(View.VISIBLE);
    disableMediaButton.setVisibility(View.GONE);
});
```

Add two methods to `ChatViewModel`:

```java
public void disableMedia() {
    conversation.disableMedia();
}

@SuppressLint("MissingPermission")
public void enableMedia() {
    conversation.enableMedia();
}
```

> **NOTE:** When enabling audio in a conversation establishes an audio leg for a member of the conversation. The audio is only streamed to other members of the conversation who have also enabled audio.

## Display audio events

When enabling media, `NexmoMediaEvent` events are sent to the conversation. To display these events you will need to add a `NexmoMediaEventListener`. Replace the whole `getConversation` method in the `ChatViewModel`:

```java
private void getConversation() {
    client.getConversation(Config.CONVERSATION_ID, new NexmoRequestListener<NexmoConversation>() {
        @Override
        public void onSuccess(@Nullable NexmoConversation conversation) {
            ChatViewModel.this.conversation = conversation;

            if (ChatViewModel.this.conversation != null) {
                getConversationEvents(ChatViewModel.this.conversation);
                ChatViewModel.this.conversation.addMessageEventListener(messageListener);

                ChatViewModel.this.conversation.addMediaEventListener(new NexmoMediaEventListener() {
                    @Override
                    public void onMediaEnabled(@NonNull NexmoMediaEvent nexmoMediaEvent) {
                        updateConversation(nexmoMediaEvent);
                    }

                    @Override
                    public void onMediaDisabled(@NonNull NexmoMediaEvent nexmoMediaEvent) {
                        updateConversation(nexmoMediaEvent);
                    }
                });
            }
        }

        @Override
        public void onError(@NonNull NexmoApiError apiError) {
            ChatViewModel.this.conversation = null;
            _errorMessage.postValue("Error: Unable to load conversation " + apiError.getMessage());
        }
    });
}
```

The `conversationEvents` observer inside `ChatFragment` must support the `NexmoMediaEvent` type. Add a new branch to the if statement:

```java
private Observer<ArrayList<NexmoEvent>> conversationEvents = events -> {

        //...

        if (event instanceof NexmoMemberEvent) {
            line = getConversationLine((NexmoMemberEvent) event);
        } else if (event instanceof NexmoTextEvent) {
            line = getConversationLine((NexmoTextEvent) event);
        } else if (event instanceof NexmoMediaEvent) {
            line = getConversationLine((NexmoMediaEvent) event);
        }

        //...
    };
```

Now add `getConversationLine` method needs to support `NexmoMediaEvent` type as well:

```java
private String getConversationLine(NexmoMediaEvent mediaEvent) {
    String user = mediaEvent.getFromMember().getUser().getName();
    return user + " media state: " + mediaEvent.getMediaState();
}
```

## Build and run

Press `Cmd + R` to build and run again. Once logged in you can enable or disable audio. To test it out you can run the app on two different devices.
