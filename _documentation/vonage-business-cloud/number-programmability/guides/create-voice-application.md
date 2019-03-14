---
title: Create a Voice API application
description: The application stores security and configuration information for your interaction with the API.
navigation_weight: 2
---

# Create a Nexmo Voice API Application

Every Number Programmability service application that you build must be associated with a Nexmo Voice Application.

> **Note**: To avoid confusion, `Application` here refers to the Nexmo Voice Application. The application you are building will be referred to as "application".

A Nexmo Voice Application stores configuration information such as details of the programmable numbers and webhook callback URLs that your application uses.

You can create Nexmo Voice Applications by any of the following methods:

* Using the [Nexmo Developer Dashboard](https://dashboard.nexmo.com/voice/create-application).
* Using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli).
* Programmatically, using the [Nexmo Application API](/api/application.v2).

## Using the Nexmo CLI

In this example, we'll create a Voice Application using the Nexmo CLI:

1. If you don't already have one, [create a Nexmo account](https://dashboard.nexmo.com/sign-up).

2. Use [npm](https://www.npmjs.com/) to install and setup the Nexmo CLI, using the API key and secret from your [Nexmo Developer Dashboard](https://dashboard.nexmo.com/getting-started-guide):

    ```sh
    $ npm install nexmo-cli -g
    $ nexmo setup <api_key> <api_secret>
    ```
3. Execute the following command in your application directory:

    ```sh
    $ nexmo app:create "NumberProgrammabilityApp" http://example.com/webhooks/answer http://example.com/webhooks/event  --keyfile private.key
    ```
    The two URLs you provide refer to the webhook endpoints that your application will expose to Nexmo's servers:
    * The first is the webhook that Nexmo's APIs will make a request to when a call is received on your VBC programmable number.
    * The second is where Nexmo's APIs will post details about events that your application might be interested in - such as a call being answered or terminated.

    You can [change the webhook URLs](https://github.com/Nexmo/nexmo-cli#update-an-application) when you know the exact endpoints, so if you don't have this information yet leave them as `http://example.com`.

    The above command also stores your private key in the file named `private.key` in the directory that you executed it in.

    Make a note of the `application_id` that this command creates. You can also find this in your [Nexmo Developer Dashboard](https://dashboard.nexmo.com/voice/your-applications).

> The next step is to [provision the Number Programmability service](/vonage-business-cloud/number-programmability/guides/provision-nps) using the Nexmo Voice API `application_id`.
