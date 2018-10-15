---
title: Android
platform: android
---

# Call Convenience methods for Stitch and Android

In this getting started guide we'll cover adding call methods to the Conversation we created in the [simple conversation with audio](/stitch/in-app-voice/guides/enable-audio/android) getting started guide. We'll deal with member call events that trigger on the application and call state events that trigger on the Call object.

The main difference between using these Call convenience methods and enabling and disabling the audio in the previous quickstart is that these methods do a lot of the heavy lifting for you. By calling a user directly, a new conversation is created, and users are automatically invited to the new conversation with audio enabled. This can make it easier to start a separate direct call to a user or start a private group call among users.

## Concepts

This guide will introduce you to the following concepts.

- **Calls** - calling an User in your application without creating a Conversation first
- **Call Events** - `CallEvent` event that fires on an `ConversationClient` or `Call`

## Before you begin

- Ensure you have run through the [previous guide](/stitch/in-app-voice/guides/enable-audio/android)

## 1 - Update the Android App

We will use the application we already created for [the first audio getting started guide](/stitch/in-app-voice/guides/enable-audio/android). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.


### 1.1 - Initiating a call

To initiate call we're going to let the user choose to start a call or enter a conversation after they login.

```java
//LoginActivity.java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_login);
    ...
    chatBtn = findViewById(R.id.chat);
    chatBtn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            showCallOrConversationDialog();
        }
    });
    ...
}

private void showCallOrConversationDialog() {
    final AlertDialog.Builder dialog = new AlertDialog.Builder(LoginActivity.this)
            .setTitle("Call a user or enter conversation?")
            .setPositiveButton("Enter Conversation", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    retrieveConversations();
                }
            })
            .setNeutralButton("Call User", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    showCallUserDialog();
                }
            });

    runOnUiThread(new Runnable() {
        @Override
        public void run() {
            dialog.show();
        }
    });
}

private void showCallUserDialog() {
    final EditText input = new EditText(LoginActivity.this);
    final AlertDialog.Builder dialog = new AlertDialog.Builder(LoginActivity.this)
            .setTitle("Which user do you want to call?")
            .setPositiveButton("Call", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    callUser(input.getText().toString());
                }
            });

    LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.MATCH_PARENT);
    input.setLayoutParams(lp);
    dialog.setView(input);

    runOnUiThread(new Runnable() {
        @Override
        public void run() {
            dialog.show();
        }
    });
}

private void callUser(String username) {
    Intent intent = new Intent(LoginActivity.this, CallActivity.class);
    intent.putExtra("USERNAME", username);
    startActivity(intent);
}
```

As you can see, the user will still login with the login button. But now the chat button asks them to start a call or enter a conversation. If they start a call, we'll ask what user they want to call and then start a new activity named `CallActivity` by passing in the user's name in the `Intent`.

### 1.2 - Using the CallActivity

This activity will have only two UI pieces, a `TextView` that tells you who you're in a call with and a "Hang Up" Button. This is what the layout will look like.

```xml
<!--activity_call.xml-->
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    tools:context="com.nexmo.callingusers.CallActivity">

    <TextView
        android:padding="16dp"
        android:textSize="32sp"
        android:gravity="center"
        android:id="@+id/username"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        tools:text="In Call With Jamie"/>

    <Button
        android:id="@+id/hangup"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginBottom="8dp"
        android:text="Hang Up"
        app:layout_constraintBottom_toBottomOf="parent" />

</android.support.constraint.ConstraintLayout>
```

Now that we've added the UI we need to implement the calling functionality and handle hanging up on the call.

```java
//CallActivity.java
public class CallActivity extends AppCompatActivity {
    private static final int PERMISSION_REQUEST_AUDIO = 0;

    private ConversationClient conversationClient;
    private Call currentCall;
    private String username;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_call);

        conversationClient = ((ConversationClientApplication) getApplication()).getConversationClient();
        Intent intent = getIntent();
        username = intent.getStringExtra("USERNAME");
        TextView usernameTxt = findViewById(R.id.username);
        usernameTxt.setText("In call with "+ username);

        if (checkAudioPermissions()) {
            callUser(username);
        } else {
            logAndShow("Check audio permissions");
        }

        Button hangUpBtn = findViewById(R.id.hangup);
        hangUpBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                hangup();
            }
        });
    }


    private void callUser(String username) {
        conversationClient.call(Collections.singletonList(username), new RequestHandler<Call>() {
            @Override
            public void onError(NexmoAPIError apiError) {
                logAndShow(apiError.getMessage());
            }

            @Override
            public void onSuccess(Call result) {
                currentCall = result;
                attachCallListeners(currentCall);
            }
        });
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode) {
            case PERMISSION_REQUEST_AUDIO: {
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    callUser(username);
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

    private boolean checkAudioPermissions() {
        if (ContextCompat.checkSelfPermission(CallActivity.this, RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED) {
            return true;
        } else {
            if (ActivityCompat.shouldShowRequestPermissionRationale(this, RECORD_AUDIO)) {
                logAndShow("Need permissions granted for Audio to work");
            } else {
                ActivityCompat.requestPermissions(CallActivity.this, new String[]{RECORD_AUDIO}, PERMISSION_REQUEST_AUDIO);
            }
        }
        return false;
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
                    finish();
                }
            });

        }
    }
}
```

As you can see the activity starts out with automatically calling the user from the previous `LoginActivity`. We'll also want to handle requesting the correct permissions as we did in the [previous quickstart](/stitch/in-app-voice/guides/enable-audio/android). We'll also want to show any other events in the call. Such as the other user answering, hanging up, or rejecting the call. Our user can also click on the "Hang Up" Button at any time to end the call and finish the activity.


### 2.1 - Listening for a call

We want to listen for call events, the same way that we listened for conversation invites in the [Inviting Members quickstart](/stitch/in-app-messaging/guides/inviting-members). First we'll let the user login and select a conversation. If they're called while they're in the `ChatActivity`, then we'll answer the call in the current activity.

 We can do that by adding a `ResultListener` to `conversationClient.callEvent()`. When a call comes in, the `onSuccess()` callback will be fired. You may want to show a UI that allows the user to accept or reject the call, but in this demo we'll just answer the call by calling `answer()` on the incoming call. Once the call is answered, then we'll attach the call listeners that will listen for incoming member events in a call and show a hang up button that we'll need to implement in the next section.

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

### 2.2 - Let users hang up on a call

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

### 2.3 Receive a PSTN Phone Call via Stitch

After you've set up you're app to handle incoming calls, you can follow the [phone to app calling](/stitch/in-app-voice/guides/inbound-pstn) guide. Now you can make PSTN Phone Calls via the Nexmo Voice API and receive those calls via the Stitch SDK.

### 3 - Open the app on two devices

Now run the app on two devices (make sure they have a working mic and speakers!), making sure to login with the user name `jamie` in one and with `alice` in the other. Call one from the other, accept the call and start talking. You'll also see events being logged Logcat.

## Where next?

- Have a look at the [Nexmo Conversation Android SDK API Reference](https://developer.nexmo.com/sdk/stitch/android/reference/packages.html)
