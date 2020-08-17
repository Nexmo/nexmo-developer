---
title: Create a Nexmo Application
description: In this step you learn how to create a Nexmo Application.
---

# Create your Nexmo Application

You now need to create a Nexmo [Application](/conversation/concepts/application). In this step you create an application capable of handling both in-app Voice and in-app Messaging use cases.

**1.** Create your project directory if you've not already done so.

``` shell
mkdir nexmo-tutorial
```

**2.** Change into the project directory.

``` shell
cd nexmo-tutorial
```

**3.** Create a Nexmo application [interactively](/application/nexmo-cli#interactive-mode). Make sure to change the value of `--voice-answer-url` argument by replacing `GIST-URL` with the gist URL from the previous step. The following command enters interactive mode:

``` shell
nexmo app:create "Phone To App Tutorial" --capabilities=voice --keyfile=private.key  --voice-event-url=https://example.com/ --voice-answer-url=GIST-URL 
```

A file named `.nexmo-app` is created in your project directory and contains the newly created Nexmo Application ID and the private key. A private key file named `private.key` is also created.

**Please make a note of it as you'll need it in the future.**

```screenshot
image: public/screenshots/tutorials/client-sdk/nexmo-application-created.png
```

> **NOTE:** For more details on how to create an application and various available application capabilities please see our [documentation](/application/overview).

> **NOTE:** You can also obtain information about your application, including the Application ID, in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).