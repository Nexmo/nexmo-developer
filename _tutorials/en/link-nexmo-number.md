---
title: Link a Vonage number
description: In this step you learn how to link a Vonage number to your application.
---

# Link a Vonage number

## Using the Dashboard

1. Find your application in the [Dashboard](https://dashboard.nexmo.com/voice/your-applications).
2. Click on the application in the Your Applications list. Then click on the Numbers tab.
3. Click the Link button to link a Vonage number with that application.

## Using the Nexmo CLI

Once you have a suitable number you can link it with your Vonage application. Replace `YOUR_NEXMO_NUMBER` with newly generated number, replace `APPLICATION_ID` with your application id and run this command:

```
nexmo link:app YOUR_NEXMO_NUMBER APPLICATION_ID
```
