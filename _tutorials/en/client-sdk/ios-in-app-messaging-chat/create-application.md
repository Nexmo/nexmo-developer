---
title: Create a Nexmo Application
description: In this step you learn how to create a Nexmo Application.
---

# Create your Nexmo Application

You now need to create a Nexmo application. In this step you create an application capable of handling in-app Messaging use cases.

1) First create your project directory if you've not already done so.

2) Change into the project directory.

3) Create a Nexmo application [interactively](/application/nexmo-cli#interactive-mode). The following command enters interactive mode:

``` shell
nexmo app:create
```

4) Specify your application name. Press Enter to continue.

5) You can now select your application capabilities using the arrow keys and then pressing spacebar to select the capabilities your application needs. For the purposes of this example select RTC capabilities only, using the arrow keys and spacebar to select. Once you made your selection, press Enter to continue.

6) For "Use the default HTTP methods?" press Enter to select the default.

7) For " RTC Event URL" press 'Enter' to accept the default.

8)  For "Public Key path" press Enter to select the default. If you want to use your own public-private key pair refer to [this documentation](/application/nexmo-cli#creating-an-application-with-your-own-public-private-key-pair).

9)  For "Private Key path" type in `private.key` and press Enter.

The application is then created.

The file `.nexmo-app` is created in your project directory. This file contains the Nexmo Application ID and the private key. A private key file `private.key` is also created.

Creating an application and application capabilities are covered in detail in the [documentation](/application/overview).

**Make a note of the generated Application ID, as you'll need it in the future.**

## Nexmo Dashboard

You can obtain information about your application, including Application ID, in the [Nexmo Dashboard](https://dashboard.nexmo.com/applications).

![Nexmo Developer Dashboard Applications screenshot](/assets/screenshots/tutorials/app-to-phone/nexmo-dashboard-applications.png "Nexmo Developer Dashboard Applications screenshot")
