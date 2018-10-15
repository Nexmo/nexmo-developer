---
title: Android
platform: android
---

# Outbound PSTN Calling guide for Android

In this getting started guide we'll cover how to make an outbound PSTN call from your Android app using the Nexmo Stitch SDK.

## Concepts

This guide will cover the following concepts:

- **Calls** - calling a PSTN number in your application without creating a Conversation first
- **Call State** - A state a call can be in. Either `STARTED`, `RINGING`, or `ANSWERED`

## Before you begin

You should read the [NCCO guide for calling](/stitch/in-app-voice/guides/ncco-guide) before completing this quickstart. In order to make an outbound PSTN call, you'll have to correctly link your application to an answer url with an NCCO. The NCCO guide goes into further detail.

# Setting up an Android Project.

First you'll need the latest version of the Nexmo Stitch SDK in your `app/build.gradle`

```groovy
implementation 'com.nexmo:stitch:3.0.0'
```

Now that you have the SDK included in your project, you'll need to create a new instance on the `ConversationClient`. You can do this in a new Activity where you'll be making the outbound PSTN call. For this purpose let's create a `CallActivity` with and its layout:

```java
class CallActivity : BaseActivity() {
    private var currentCall: Call? = null
    private lateinit var client: ConversationClient

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_call)

        conversationClient = ConversationClient.ConversationClientBuilder()
                .context(context.applicationContext)
                .logLevel(Log.DEBUG)
                .onMainThread(true)
                .build()
    }
}
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="com.nexmo.stitchoutboundpstncalling.CallActivity">

    <TextView
        android:id="@+id/callStatus"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        tools:text="Calling +18675309"/>

    <EditText
        android:id="@+id/phoneNumberInput"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:inputType="phone"/>

    <Button
        android:id="@+id/callControlBtn"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginBottom="8dp"
        android:text="Call"
        app:layout_constraintBottom_toBottomOf="parent" />

</android.support.constraint.ConstraintLayout>
```

In this example we're assuming the user has already logged in with the `conversationClient.login()` method. For more details about how to implement that read the [simple conversation quickstart](/stitch/in-app-messaging/guides/simple-conversation/android) or view the `LoginActivity` in the [source code for this quickstart](https://github.com/Nexmo/stitch-android-quickstart/blob/master/examples/StitchOutboundPSTNCalling/app/src/main/java/com/nexmo/stitchoutboundpstncalling/LoginActivity.kt)


## Making an outbound PSTN call

Now that we've set up our `CallActivity` we can add the PSTN calling functionality. To do this we'll need to make some changes to the Activity. First in the `onCreate` method let's set the click listener for the `callControlBtn`.

```java
override fun onCreate(savedInstanceState: Bundle?) {
  ...
  callControlBtn.setOnClickListener { callPhone() }
}
```

Now that we've set up the click listener, we need to implement the `callPhone()` and `endCall()` methods:

```java
fun callPhone() {
    val phoneNumber = phoneNumberInput.text.toString()

    conversationClient.callPhone(phoneNumber, object : RequestHandler<Call> {
        override fun onError(apiError: NexmoAPIError) {
            logAndShow("Cannot initiate call: " + apiError.message)
        }

        override fun onSuccess(result: Call) {
            currentCall = result
            callControlBtn.text = "Hangup"
            callControlBtn.setOnClickListener { endCall() }

            when (result.callState) {
                Call.CALL_STATE.STARTED -> logAndShow("Started")
                Call.CALL_STATE.RINGING -> logAndShow("Ringing")
                Call.CALL_STATE.ANSWERED -> logAndShow("Answered")
                else -> logAndShow("Error attaching call listener")
            }

        }
    })
}

private fun endCall() {
    currentCall?.hangup(object : RequestHandler<Void> {
        override fun onError(apiError: NexmoAPIError) {
            logAndShow("Cannot hangup: " + apiError.toString())
        }

        override fun onSuccess(result: Void) {
            logAndShow("Call completed.")
            runOnUiThread {
                callControlBtn.text = "Call"
                callControlBtn.setOnClickListener { callPhone() }
            }
        }
    })
}
```

To initiate the PSTN call, we can use the `conversationClient.callPhone()` method, passing in the phone number of that we want to call and handling the `onSuccess` and `onError` callbacks. If the call is successfully made we can check the `Call.CALL_STATE` to know when the call has been started, is ringing, or has been answered.

Hanging up on the call requires hanging on to a reference to the `Call` object created in the `onSuccess` callback of `conversationClient.callPhone()`. By using `currentCall?.hangup` the call will  hung up for both the IP and PSTN user. If the call is successfully hung up, we'll set up the activity to make a new call if the user chooses.

## Trying it out

After you've followed along with this quickstart, you will be able to make a call to a PSTN phone. Don't forget to include the country code when you make a call! For example if you're calling a phone number in the USA, the phone number will need to begin with a 1. When calling a phone number in Great Britain the phone number will need to be prefixed with 44.

## Where next?

You can view the source code for this [quickstart on GitHub](https://github.com/Nexmo/stitch-android-quickstart/tree/master/examples/StitchOutboundPSTNCalling)
