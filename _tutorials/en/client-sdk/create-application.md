---
title: Create a Nexmo Application
description: In this step you learn how to create a Nexmo Application.
---

# Create your Nexmo Application

You now need to create a Nexmo application. In this step you create an application capable of handling both in-app Voice and in-app Messaging use cases.

> **NOTE:** In the following procedure you need to change the webhook URLs to suit your local setup. For more information on using Ngrok for local testing please see [testing with Ngrok](/tools/ngrok). Any requests that Nexmo makes to the webhook URLs *must* be acknowledged by returning a HTTP `200` or `204` response.

1) First create your project directory if you've not already done so.

2) Change into the project directory.

3) Create a Nexmo application [interactively](/application/nexmo-cli#interactive-mode). The following command enters interactive mode:

``` shell
nexmo app:create
```

4) Specify your application name. Press Enter to continue.

5) You can now select your application capabilities using the arrow keys and then pressing spacebar to select the capabilities your application needs. For the purposes of this example select both Voice and RTC capabilities using the arrow keys and spacebar to select. Once you have selected both Voice and RTC capabilities press Enter to continue.

> **NOTE:** If your application will be in-app voice only you can just select Voice capabilities. If you want in-app messaging select only RTC capabilities. If your app will have both in-app voice and in-app messaging select both capabilities.

6) For "Use the default HTTP methods?" press Enter to select the default.

7) For "Voice Answer URL" enter `https://example.ngrok.io/webhooks/answer` or other suitable URL (this depends on how you are testing).

8) You are next prompted for the "Voice Fallback Answer URL". This is an optional fallback URL should your main Voice Answer URL fail for some reason. In this case just press Enter. If later you need the fallback URL you can add it in the [Dashboard](https://dashboard.nexmo.com/sign-in), or using the Nexmo CLI.

9) You are now required to enter the "Voice Event URL". Enter `https://example.ngrok.io/webhooks/event`.

10) For " RTC Event URL" enter `https://example.ngrok.io/webhooks/rtc`.

11) For "Public Key path" press Enter to select the default. If you want to use your own public-private key pair refer to [this documentation](/application/nexmo-cli#creating-an-application-with-your-own-public-private-key-pair).

12) For "Private Key path" type in `private.key` and press Enter.

The application is then created.

The file `.nexmo-app` is created in your project directory. This file contains the Nexmo Application ID and the private key. A private key file `private.key` is also created.

Creating an application and application capabilities are covered in detail in the [documentation](/application/overview).

Make a note of the generated Application ID, as you'll need it in the future. 

## Nexmo Dashboard

You can obtain information about your application, including Application ID, in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).

![Nexmo Developer Dashboard Applications screenshot](/assets/screenshots/tutorials/app-to-phone/nexmo-dashboard-applications.png "Nexmo Developer Dashboard Applications screenshot")
