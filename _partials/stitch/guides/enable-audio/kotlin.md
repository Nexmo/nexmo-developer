---
title: Kotlin
language: kotlin
---

# Enable Audio in your Application

In this guide we'll cover adding audio events to the Conversation we have created in the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/kotlin) guide. We'll deal with sending and receiving media events to and from the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Audio Leg** - A server side API term. Legs are a part of a conversation. When audio is enabled on a conversation, a leg is created
- **Media Event** - a `NexmoMediaEvent` event that fires on a Conversation when the media state changes for a member

## Before you begin

Run through the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/kotlin). You will be building on top of this project.

## Add audio permissions

Since enabling audio uses the device microphone, you will need to ask the user for permission. 

Add new entry in the `app/src/AndroidManifest.xml` file (below last `<uses-permission` tag):

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

### Request permission on application start

Add `requestCallPermissions` method inside `LoginFragment` class.

```kotlin
private fun requestCallPermissions() {
    val callsPermissions = arrayOf(Manifest.permission.RECORD_AUDIO)
    val CALL_PERMISSIONS_REQUEST = 123
    ActivityCompat.requestPermissions(requireActivity(), callsPermissions, CALL_PERMISSIONS_REQUEST)
}
```

Call `requestCallPermissions` method inside `onViewCreated` method.

``` kotlin
@Override
override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    // ...

    requestCallPermissions()
}
```

## Add audio UI

You will now need to add two buttons for the user to enable and disable audio. Open `app/src/main/res/layout/fragment_chat.xml` file and add two new buttons (`enableMediaButton` and `disableMediaButton`) just below `sendMessageButton`. 

``` xml
        <!--...-->

        <Button
                android:id="@+id/sendMessageButton"
                android:layout_width="wrap_content"
                android:layout_height="0dp"
                android:text="@string/send"
                app:layout_constraintBottom_toBottomOf="parent"
                app:layout_constraintLeft_toRightOf="@id/messageEditText"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@+id/conversationEventsScrollView" />

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

    </androidx.constraintlayout.widget.ConstraintLayout>

</androidx.constraintlayout.widget.ConstraintLayout>
```

## Enable and disable audio 

Add listeners to the buttons inside `onViewCreated` method of `ChatFragment`:

```kotlin
enableMediaButton.setOnClickListener {
    viewModel.enableMedia()
    enableMediaButton.visibility = View.GONE
    disableMediaButton.visibility = View.VISIBLE
}

disableMediaButton.setOnClickListener {
    viewModel.disableMedia()
    enableMediaButton.visibility = View.VISIBLE
    disableMediaButton.visibility = View.GONE
}
```

Add two methods to `ChatViewModel`:

```kotlin
fun disableMedia() {
    conversation?.disableMedia()
}

@SuppressLint("MissingPermission")
fun enableMedia() {
    conversation?.enableMedia()
}
```

> **NOTE:** When enabling audio in a conversation establishes an audio leg for a member of the conversation. The audio is only streamed to other members of the conversation who have also enabled audio.

## Display audio events

When enabling media, `NexmoMediaEvent` events are sent to the conversation. To display these events you will need to add a `NexmoMediaEventListener`. Replace the whole `getConversation` method in the `ChatViewModel`:

```kotlin
private fun getConversation() {
    client.getConversation(Config.CONVERSATION_ID, object : NexmoRequestListener<NexmoConversation> {
        override fun onSuccess(conversation: NexmoConversation?) {
            this@ChatViewModel.conversation = conversation

            conversation?.let {
                getConversationEvents(it)
                it.addMessageEventListener(messageListener)

                it.addMediaEventListener(object : NexmoMediaEventListener {
                    override fun onMediaEnabled(mediaEvent: NexmoMediaEvent) {
                        updateConversation(mediaEvent)
                    }

                    override fun onMediaDisabled(mediaEvent: NexmoMediaEvent) {
                        updateConversation(mediaEvent)
                    }
                })
            }
        }

        override fun onError(apiError: NexmoApiError) {
            this@ChatViewModel.conversation = null
            _errorMessage.postValue("Error: Unable to load conversation ${apiError.message}")
        }
    })
}
```

The `conversationEvents` observer have to support newly added `NexmoMediaEvent` type. Add new branch to the if statement:

```kotlin
private var conversationEvents = Observer<List<NexmoEvent>?> { events ->
    val events = events?.mapNotNull {
        when (it) {
            is NexmoMemberEvent -> getConversationLine(it)
            is NexmoTextEvent -> getConversationLine(it)
            is NexmoMediaEvent -> getConversationLine(it)
            else -> null
        }
    }

    // ...
```

Now add `getConversationLine` method needs to support `NexmoMediaEvent` type as well:
```
private String getConversationLine(NexmoMediaEvent mediaEvent) {
    String user = mediaEvent.getFromMember().getUser().getName();
    return user + "  media state: " + mediaEvent.getMediaState();
}
```

## Build and run

Press `Cmd + R` to build and run again. Once logged in you can enable or disable audio. To test it out you can run the app on two different devices.

