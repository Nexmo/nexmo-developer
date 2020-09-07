---
title: Receive a call
description: In this step you will receive the call.
---

# Receive a call

At the top of the `MainActivity` class, just below the view declarations, add a `call` property to hold a reference to any call in progress and `incomingCall` property to hold information about currently incoming call.

```java
private NexmoCall call;
private Boolean incomingCall = false;
```

At the bottom of the `onCreate` method in the `MainActivity` class add incoming call listener to be notified about incoming call.

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    // ...
    client.addIncomingCallListener(it -> {
        call = it;

        incomingCall = true;
        updateUI();
    });
}
```

When the application receives a call we want to give the option to accept or reject the call. Add the `updateUI` function to the `MainActivity` class.

```java
class MainActivity : AppCompatActivity() {

    // ...
    private void updateUI() {
        answerCallButton.setVisibility(View.GONE);
        rejectCallButton.setVisibility(View.GONE);
        endCallButton.setVisibility(View.GONE);

        if (incomingCall) {
            answerCallButton.setVisibility(View.VISIBLE);
            rejectCallButton.setVisibility(View.VISIBLE);
        } else if (call != null) {
            endCallButton.setVisibility(View.VISIBLE);
        }
    }
}
```

Now you need to add listeners, to wire UI with the client SDK. Add this code at the bottom of the `onCreate` method in the `MainActivity` class:

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    // ...
    answerCallButton.setOnClickListener(view -> {
        in`comingCall = false;
        updateUI();
        call.answer(null);

    });

    rejectCallButton.setOnClickListener(view -> {
        incomingCall = false;
        call = null;
        updateUI();

        call.hangup(null);
    });

    endCallButton.setOnClickListener(view -> {
        call.hangup(null);

        call = null;
        updateUI();
    });
}
```

## Build and Run

Press `Cmd + R` to build and run again, when you call the number linked with your application from earlier you will be presented with `Answer` and `Reject` buttons.
