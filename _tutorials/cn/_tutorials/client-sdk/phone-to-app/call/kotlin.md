---
title:  Receive a call
description:  In this step you will receive the call.

---

Receive a call
==============

At the top of the `MainActivity` class, just below the view declarations, add a `call` property to hold a reference to any call in progress and `incomingCall` property to hold information about currently incoming call.

```kotlin
private var call: NexmoCall? = null
private var incomingCall = false
```

At the bottom of the `onCreate` method in the `MainActivity` class add incoming call listener to be notified about incoming call.

```java
override fun onCreate(savedInstanceState: Bundle?) {
    // ...
    client.addIncomingCallListener { it ->
        call = it
        incomingCall = true
        updateUI()
    }
}
```

When the application receives a call we want to give the option to accept or reject the call. Add the `updateUI` function to the `MainActivity` class.

```kotlin
class MainActivity : AppCompatActivity() {
    
    // ...
    private fun updateUI() {
        answerCallButton.visibility = View.GONE
        rejectCallButton.visibility = View.GONE
        endCallButton.visibility = View.GONE
        if (incomingCall) {
            answerCallButton.visibility = View.VISIBLE
            rejectCallButton.visibility = View.VISIBLE
        } else if (call != null) {
            endCallButton.visibility = View.VISIBLE
        }
    }
}
```

Now you need to add listeners, to wire UI with the client SDK. Add this code at the bottom of the `onCreate` method in the `MainActivity` class:

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
        
    // ...
    answerCallButton.setOnClickListener {
        incomingCall = false
        updateUI()
        call?.answer(object : NexmoRequestListener<NexmoCall> {
            override fun onError(p0: NexmoApiError) {
            }

            override fun onSuccess(p0: NexmoCall?) {
            }
        })
    }

    rejectCallButton.setOnClickListener {
        incomingCall = false
        call = null
        updateUI()

        call?.hangup(object : NexmoRequestListener<NexmoCall> {
            override fun onError(p0: NexmoApiError) {
            }

            override fun onSuccess(p0: NexmoCall?) {
            }
        })
    }

    endCallButton.setOnClickListener {
        call?.hangup(object : NexmoRequestListener<NexmoCall> {
            override fun onError(p0: NexmoApiError) {
            }

            override fun onSuccess(p0: NexmoCall?) {
            }
        })
        call = null
        updateUI()
    }
}      
```

Build and Run
-------------

Press `Cmd + R` to build and run again, when you call the number linked with your application from earlier you will be presented with `Answer` and `Reject` buttons.

