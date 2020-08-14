---
title: Create a Nexmo Application
description: In this step you learn how to create a Nexmo Application.
---

# Create your Nexmo Application

In this step you will create a Nexmo [Application](/conversation/concepts/application) capable of handling in-app Messaging use cases. Notice that this is not an Android project, but rather Nexmo application project that allows to configure backend for the mobile application that we will create in the following steps.

**1.** Create your project directory if you've not already done so.

``` shell
mkdir nexmo-tutorial
```

**2.** Change into the project directory.

``` shell
cd nexmo-tutorial
```

**3.** Create a Nexmo application [interactively](/application/nexmo-cli#interactive-mode). The following command enters interactive mode:

``` shell
nexmo app:create
```

**4.** Specify your application name. Press Enter to continue.

**5.** You can now select your application capabilities using the arrow keys and then pressing spacebar to select the capabilities your application needs. For the purposes of this example select RTC capabilities only, using the arrow keys and spacebar to select. Once you made your selection, press Enter to continue.

**6.** For "Use the default HTTP methods?" press Enter to select the default.

**7.** For " RTC Event URL" press 'Enter' to accept the default.

**8.**  For "Public Key path" press Enter to select the default. If you want to use your own public-private key pair refer to [this documentation](/application/nexmo-cli#creating-an-application-with-your-own-public-private-key-pair).

**9.**  For "Private Key path" type in `private.key` and press Enter.

A file named `.nexmo-app` is created in your project directory and contains the newly created Nexmo Application ID and the private key. A private key file named `private.key` is also created.

**Please make a note of it as you'll need it in the future.**

```screenshot
image: public/screenshots/tutorials/client-sdk/nexmo-application-created.png
```

> **NOTE:** For more details on how to create an application and various available application capabilities please see our [documentation](/application/overview).

> **NOTE:** You can also obtain information about your application, including the Application ID, in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).