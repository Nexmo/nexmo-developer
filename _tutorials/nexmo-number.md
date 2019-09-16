---
title: Obtain a Nexmo number and associate it with your Client SDK Application
description: In this step you learn how to purchase and associate a Nexmo number with your Client SDK Application.
---

# Purchase and associate a Nexmo number with your application

## Using the Nexmo Dashboard

The simplest way to associate a number with your application is using the Dashboard.

First you can [browse your existing numbers](https://dashboard.nexmo.com/your-numbers).

If you have no spare numbers you can [buy one](https://dashboard.nexmo.com/buy-numbers).

[Find your application](https://dashboard.nexmo.com/voice/your-applications) in the Dashboard.

Click on the application in the Your Applications list. Then click on the Numbers tab.

Click the `Link` button to link a Nexmo number with that application.

## Using the Nexmo CLI

First search for a suitable number:

```
nexmo number:search GB
```

You can change the country code to suit your requirements. For example if you are in the US you could use:

```
nexmo number:search US
```

Choose a suitable number and then buy it using a command similar to:

```
nexmo number:buy 442039051952
```

> **NOTE:** You will need to confirm your purchase.

You now need to associate your Nexmo number with your Nexmo application:

```
nexmo link:app YOUR_NEXMO_NUMBER APPLICATION_ID
```
