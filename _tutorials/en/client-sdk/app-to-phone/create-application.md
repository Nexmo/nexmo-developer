---
title: Create a Nexmo Application
description: In this step you learn how to create a Nexmo Application.
---

# Create your Nexmo Application

In this step you will create a Nexmo [Application](/conversation/concepts/application) capable of in-app Voice communication use cases.

> **NOTE:** This is the Nexmo application project that allows client application to use Nexmo backend.

**1.** Create your project directory if you've not already done so.

``` shell
mkdir nexmo-tutorial
```

**2.** Change into the project directory.

``` shell
cd nexmo-tutorial
```

**3.** Create a Nexmo application by copying and pasting the command below into terminal Make sure to change the value of `--voice-answer-url` argument by replacing `GIST-URL` with the gist URL from the previous step.

``` shell
nexmo app:create "App to Phone Tutorial" --capabilities=voice --keyfile=private.key  --voice-event-url=https://example.com/ --voice-answer-url=GIST-URL
```

A file named `.nexmo-app` is created in your project directory and contains the newly created Nexmo Application ID and the private key. A private key file named `private.key` is also created.

**Please make a note of the Application ID as you'll need it in the future.**

```screenshot
image: public/screenshots/tutorials/client-sdk/nexmo-application-created.png
```

> **NOTE:** An application can be also created using the CLI's [interactive mode](/application/nexmo-cli#interactive-mode).

> **NOTE:** For more details on how to create an application and various available application capabilities please see our [documentation](/application/overview).

> **NOTE:** You can also obtain information about your application, including the Application ID, in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).
