---
title: How to Make and Receive Voice calls with the Nexmo Client SDK on Android
products: client-sdk
description: This tutorial shows you how to create a Nexmo Client SDK application that can make and receive voice calls on Android.
languages:
    - Java
---

# How to Make and Receive Voice calls with the Nexmo Client SDK on Android

In this tutorial you learn how to use the Nexmo Client SDK for Android, in order to perform an in-app (IP to IP) voice call.

You create a simple app that can make a call and receive a call.

The app has two buttons, to login as two different users: Jane and Joe. After logging in, the user can call the other user, or to call a Public Switched Telephone Network (PSTN) phone number.

## Prerequisites

- [Create a Nexmo Application](/tutorials/client-sdk-generate-test-credentials).

- Make sure you have at least [two users for your Nexmo Application, with valid JWTs](/tutorials/client-sdk-generate-test-credentials).

- [Add Nexmo Client SDK to your project](/tutorials/client-sdk-android-add-sdk-to-your-app).

- Clone either the [Java](https://github.com/Nexmo/Client-Get-Started-InApp-Voice-Android-Java) or [Kotlin](https://github.com/Nexmo/Client-Get-Started-InApp-Voice-Android-Kotlin) GitHub project.

Open the `NexmoHelper` class and replace the users ID and tokens:

```java
    String USER_ID_JANE = "USR-XXX"; //TODO: replace with the UserId you generated for Jane
    String USER_ID_JOE = "USR-XXX"; //TODO: replace with the UserId you generated for Joe
    String JWT_JANE = "PLACEHOLDER";//TODO: replace with the JWT you generated for Jane
    String JWT_JOE = "PLACEHOLDER"; //TODO: replace with the JWT you generated for Joe
```

## Login

To start using the Nexmo Client SDK you need to log in to `NexmoClient`, using a JWT user token.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

Open `LoginActivity`. It already has two button handlers:`onLoginJaneClick(...)` and `onLoginJoeClick(...)`. Each calls the `loginToSdk(...)` method, with a different parameter - the corresponding `jwt`. When the login is successful, the logged in `NexmoUser` returns. For convenience, save a reference to `NexmoUser` on `NexmoHelper`, and then, start `CreateCallActivity`.

Complete the `loginToSdk()` method implementation:

```java
   void loginToSdk(String token) {
        NexmoClient.get().login(token, new NexmoRequestListener<NexmoUser>() {

            @Override
            public void onError(NexmoApiError nexmoApiError) {}

            @Override
            public void onSuccess(NexmoUser user) {
                NexmoHelper.user = user;

                Intent intent = new Intent(getBaseContext(), CreateCallActivity.class);
                startActivity(intent);
                finish();
            }
        });
    }
```

## Start a Call

You can now make a simple In-App call. If you logged in as Jane, you can call Joe, and if you logged in as Joe you can call Jane.

Open `CreateCallActivity` and complete the prepared `onInAppCallClick()` handler:

```java
public void onInAppCallClick(View view) {
    List<String> callee = new ArrayList<>();
    callee.add(getOtherUserName());

    NexmoClient.get().call(callee, NexmoCallHandler.IN_APP, callListener);
}

String getOtherUserName() {
    return NexmoHelper.user.getName().equals(NexmoHelper.USER_NAME_JANE) ? NexmoHelper.USER_NAME_JOE : NexmoHelper.USER_NAME_JANE;
}
```

When the call creation is successful, save the `NexmoCall` on `NexmoHelper`, for convenience, and start `OnCallActivity`:

```java
NexmoRequestListener<NexmoCall> callListener = new NexmoRequestListener<NexmoCall>() {
        @Override
        public void onError(NexmoApiError nexmoApiError) { }

        @Override
        public void onSuccess(NexmoCall call) {
            NexmoHelper.currentCall = call;

            Intent intent = new Intent(CreateCallActivity.this, OnCallActivity.class);
            startActivity(intent);
        }
    };
```

You can also start a call with customized logic [using an NCCO](/client-sdk/in-app-voice/concepts/ncco-guide), by choosing `NexmoCallHandler.SERVER` as the `CallHandler`:

```java
NexmoCient.call(callees, NexmoCallHandler.SERVER, listener)
```

This allows you to start a PSTN phone call, by adding a phone number to the `callees` list.

## Register for incoming events

When Jane calls Joe, Joe should be notified. Joe can then answer the call. Joe should register for incoming events, and implement `onIncomingCall()`. Whenever Joe is called, `onIncomingCall()` is invoked with the incoming Call object.

For simplicity in this example, you will accept incoming calls only on `CreateCallActivity`. Open `CreateCallActivity` and create the `NexmoIncomingCallListener` to save the reference to the incoming call on `NexmoHelper`, and start `IncomingCallActivity`:

```java
NexmoIncomingCallListener incomingCallListener = new NexmoIncomingCallListener() {
        @Override
        public void onIncomingCall(NexmoCall call) {

            NexmoHelper.currentCall = call;
            startActivity(new Intent(CreateCallActivity.this, IncomingCallActivity.class));
        }
    };
```

You need to register and unregister the listener in `onCreate()` and `onDestroy()`:

```java
@Override
protected void onCreate(@Nullable Bundle savedInstanceState) {
    //...

    NexmoClient.get().addIncomingCallListener(incomingCallListener);
}

@Override
protected void onDestroy() {
    NexmoClient.get().removeIncomingCallListeners();
    super.onDestroy();
}
```

## Answer a call

Once Joe receives the incoming call it can be answered. Open `IncomingCallActivity`, and complete the prepared `onAnswer()` button handler, to start `OnCallActivity` after a successful answer:

```java
 public void onAnswer(View view) {
        NexmoHelper.currentCall.answer(new NexmoRequestListener<NexmoCall>() {
            @Override
            public void onError(NexmoApiError nexmoApiError) { }

            @Override
            public void onSuccess(NexmoCall call) {
                startActivity(new Intent(IncomingCallActivity.this, OnCallActivity.class));
                finish();
            }
        });
    }


```

## Hangup

The `onHangup()` handler allows Joe to reject the call. Complete the implementation in `IncomingCallActivity` to finish the activity:

```java
 public void onHangup(View view) {
        NexmoHelper.currentCall.hangup(new NexmoRequestListener<NexmoCall>() {
            @Override
            public void onError(NexmoApiError nexmoApiError) { }

            @Override
            public void onSuccess(NexmoCall call) {
                finish();
            }
        });
    }
```

## Register to call status

If Joe hangs up the call, Jane should be notified, and finish `OnCallActivity`. The same way, if Jane decides to hangup before Joe answers, Joe should be notified and finish `IncomingCallActivity`.

To be notified on the different call statuses, you should register to `CallEvents`. The `FinishOnCallEnd` is a simple `NexmoCallEventListener` that finishes the current activity if the call is completed or canceled.

Register to its instance, to address the use cases mentioned previously.

On both `OnCallActivity` and `IncomingCallActivity`, add:

```java
    NexmoCallEventListener callEventListener = new FinishOnCallEnd(this);

@Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        //...

        NexmoHelper.currentCall.addCallEventListener(callEventListener);
    }


    @Override
    protected void onDestroy() {
        NexmoHelper.currentCall.removeCallEventListener(callEventListener);
        super.onDestroy();
    }
```

## Handle permissions

For devices running Android 6.0 (API level 23) and higher, creation and operation of calls requires requesting runtime permissions. To simplify the implementation in this tutorial, `BaseActivity` checks the permissions in every Activity's `onStart()` and `onStop()`.

To read more about the permissions required, [see the setup tutorial](/tutorials/client-sdk-android-add-sdk-to-your-app#add-permissions).

# Conclusion

You have implemented your first In-App Voice application with Nexmo Client SDK for Android.

You can now run the app on two devices, log in as two different users, and start an in-app voice call between the users.
