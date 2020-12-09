---
title:  Initialize client
description:  In this step you will authenticate to the Vonage servers.

---

Initialize client
=================

Before you can place a call, you need to initialize Client SDK. Add this line at the end of `onCreate` method of `MainActivity` class:

```java
NexmoClient client = new NexmoClient.Builder().build(this);
```

Set connection listener
=======================

You have to listen for the st

```java
client.setConnectionListener((connectionStatus, connectionStatusReason) -> runOnUiThread(() -> connectionStatusTextView.setText(connectionStatus.toString())));
```

Now client needs to authenticate to the Vonage servers. The following additions are required to `onCreate` method inside `MainActivity`. Replace `ALICE_TOKEN` with JWT generated in previous step:

```java
client.login("ALICE_TOKEN");
```

Build and Run
-------------

Press `Cmd + R` to build and run the app.

