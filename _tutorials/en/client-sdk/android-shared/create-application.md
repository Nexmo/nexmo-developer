---
title: Create a Nexmo Application
description: In this step you learn how to create a Nexmo Application.
---

# Create your Nexmo Application

In this step you will create a Nexmo [Application](/conversation/concepts/application) capable of handling both in-app Voice and in-app Messaging use cases. Notice that this is not an Android project, but rather Nexmo application project that allows to configure backend for the mobile application that we will create in the following steps.

1) First create your project directory if you've not already done so.

2) Change into the project directory.

3) Create a Nexmo application by copying and pasting the command below. Make sure to change the value of `--voice-answer-url` argument by replacing `GIST-URL` with the gist URL from the previous step.

``` shell
nexmo app:create "App to Phone Tutorial" --capabilities=voice --keyfile=private.key  --voice-event-url=https://example.com/ --voice-answer-url=GIST-URL
```

> **NOTE:** An application can be also created using the CLI's [interactive mode](/application/nexmo-cli#interactive-mode).

A file named `.nexmo-app` is created in your project directory and contains the Nexmo Application ID and the private key. A private key file named `private.key` is also created.

For more details on how to create an application and various available application capabilities please see our [documentation](/application/overview).

The command will also output some details including the generated Application ID. Please make a note of it as you'll need it in the future. 

## Nexmo Dashboard

You can also obtain information about your application, including the Application ID, in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).

![Nexmo Developer Dashboard Applications screenshot](/screenshots/tutorials/app-to-phone/nexmo-dashboard-applications.png "Nexmo Developer Dashboard Applications screenshot")
