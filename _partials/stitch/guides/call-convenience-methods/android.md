---
title: Android
platform: android
---

# Call Convenience methods for Stitch and Android

In this getting started guide we'll cover adding call methods to the Conversation we created in the [simple conversation with audio](//TODO$LINK) getting started guide. We'll deal with member call events that trigger on the application and call state events that trigger on the Call object.

The main difference between using these Call convenience methods and enabling and disabling the audio in the previous quickstart is that these methods do a lot of the heavy lifting for you. By calling a user directly, a new conversation is created, and users are automatically invited to the new conversation with audio enabled. This can make it easier to start a separate direct call to a user or start a private group call among users.

## Concepts

This guide will introduce you to the following concepts.

- **Calls** - calling an User in your application without creating a Conversation first
//TODO Android Equivalent?
- **Call Events** - `member:call` event that fires on an Application
//TODO Android Equivalent?
- **Call State Events** - `call:member:state` event that fires on a Call

## Before you begin

- Ensure you have run through the [previous guide](//TODO$LINK)

## 1 - Update the Android App

We will use the application we already created for [the first audio getting started guide](//TODO$LINK). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.


### 1.XX - Initiating a call

//TODO
//What's the best way to add this to QS4?


### 1.XX - Listening for a call

We want to listen for call events, the same way that we listened for conversation invites in the [Inviting Members quickstart](/stitch/in-app-messaging/guides/2-inviting-members). We can do that by adding a `ResultListener` to `conversationClient.callEvent()`. When a call comes in, the `onSuccess()` callback will be fired. You may want to show a UI that allows the user to accept or reject the call, but in this demo we'll just answer the call by calling `answer()` on the incoming call. Once the call is answered, then we'll attach the call listeners that will listen for incoming member events in a call and show a hang up button that we'll need to implement in the next section.

```java
private void attachListeners() {
    //Listen for incoming calls
    conversationClient.callEvent().add(new ResultListener<Call>() {
        @Override
        public void onSuccess(final Call incomingCall) {
            logAndShow("answering Call");
            //Answer an incoming call
            incomingCall.answer(new RequestHandler<Void>() {
                @Override
                public void onError(NexmoAPIError apiError) {
                    logAndShow("Error answer: " + apiError.getMessage());
                }

                @Override
                public void onSuccess(Void result) {
                    //save the call as a member variable so we can reference it outside of this method.
                    currentCall = incomingCall;
                    attachCallListeners(incomingCall);
                    //TODO implement
                    showHangUpButton(true);
                }
            });
        }
    });
}

private void attachCallListeners(Call incomingCall) {
    //Listen for incoming member events in a call
    ResultListener<CallEvent> callEventListener = new ResultListener<CallEvent>() {
        @Override
        public void onSuccess(CallEvent message) {
            Log.d(TAG, "callEvent : state: " + message.getState() + " .content:" + message.toString());
        }
    };
    incomingCall.event().add(callEventListener);
}
```

### 1.XX - Let users hang up on a call

Let's add the UI for a user to call another user, and then be able to hang up. We'll hide the `Hang Up Button` with `android:visible="false"` until the user is in a call. Let's add the UI in the Options Menu

```xml
//app/src/main/res/menu/chat_menu.xml
<item android:id="@+id/hangup"
    android:title="Hang Up Call"
    android:visible="false"
    app:showAsAction="ifRoom"/>
```

Now we need to handle the user clicking on the "Hang Up Call" button.

```java
//ChatActivity.java
@Override
public boolean onPrepareOptionsMenu(Menu menu) {
    //hold a reference to the optionsMenu so we can change the visibility of `hangup`
    optionsMenu = menu;
    return super.onPrepareOptionsMenu(menu);
}

@Override
public boolean onOptionsItemSelected(MenuItem item) {
    switch (item.getItemId()) {
        case R.id.audio:
            requestAudio();
            return true;
        case R.id.hangup:
            //TODO implement
            hangup();
            return true;
        default:
            return super.onOptionsItemSelected(item);
    }
}

private void hangup() {
    if (currentCall != null) {
        currentCall.hangup(new RequestHandler<Void>() {
            @Override
            public void onError(NexmoAPIError apiError) {
                logAndShow("Cannot hangup: " + apiError.toString());
            }

            @Override
            public void onSuccess(Void result) {
                logAndShow("Call completed.");
                //Hide the Hang Up button after the user hangs up
                showHangUpButton(false);
            }
        });

    }
}

private void showHangUpButton(boolean visible) {
    if (optionsMenu != null) {
        optionsMenu.findItem(R.id.hangup).setVisible(visible);
    }
}
```

### 1.XX Receive a PSTN Phone Call via Stitch

After you've set up you're app to handle incoming calls, you can follow the [PSTN to IP tutorial] published on our blog. Now you can make PSTN Phone Calls via the Nexmo Voice API and receive those calls via the Stitch SDK.

### 1.5 - Open the app on two devices

//TODO

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and with `alice` in the other. Call one from the other, accept the call and start talking. You'll also see events being logged in the browser console.

Thats's it! Your page should now look something like [this](https://github.com/Nexmo/conversation-js-quickstart/blob/master/examples/6-calling-users/index.html).

## Where next?

//TODO
- Have a look at the [Nexmo Conversation JS SDK API Reference](https://developer.nexmo.com/sdk/stitch/javascript/)
