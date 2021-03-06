---
title: Initialize the client
description: In this step you will initialize Client, so it can be used within the application.
---

# Initialize the client

[NexmoClient](https://developer.nexmo.com/sdk/stitch/android/com/nexmo/client/NexmoClient.html) is the main class used to interact with `Android-Client-SDK`. Prior to usage, you have to initialize the client by providing an instance of the Android [Context](https://developer.android.com/reference/android/content/Context) class. 

At the top of the `MainActivity` class define `client` property that will hold reference to the client:

```java
private NexmoClient client;
```

Locate the `onCreate` method in the `MainActivity` class and initialize `NexmoClient` using the builder:

```java
client = new NexmoClient.Builder().build(this);
```

IDE will display a warning about the unresolved reference:

![](/screenshots/tutorials/client-sdk/android-shared/missing-import-java.png)

Put caret on the red text and press `Alt + Enter` to import the reference.

Now below client initialization code add connection listener to monitor connection state:

```java
client.setConnectionListener((connectionStatus, connectionStatusReason) -> {
    runOnUiThread(() -> {
        connectionStatusTextView.setText(connectionStatus.toString());
    });

    if (connectionStatus == ConnectionStatus.CONNECTED) {
        runOnUiThread(() -> {
            startCallButton.setVisibility(View.VISIBLE);
        });
        
        return;
    }
});
```

 The above listener allows to determine that that user has logged in successfully and show the chat UI. 
 
 Finally add the code to login the user. Please make sure to replace `ALICE_JWT` with the JWT you created during a previous step:

```java
client.login("ALICE_JWT");
```

> **NOTE** Expiry time for the token was set to 6 hours so you will need to generate a new one if it is too old.

## Build and Run

Press the `Ctrl + R` keys to build and run the app again. After successful login you will see the `START CALL` button:

![Start call](/screenshots/tutorials/client-sdk/app-to-phone/start-call.png)
