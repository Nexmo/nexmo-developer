## Create a Nexmo Application

There are two alternative methods for creating a Messages and Dispatch application:

1. Using the Nexmo CLI
2. Using the Dashboard

Each of these methods is described in the following sections.

### How to create a Messages and Dispatch application using the Nexmo CLI

To create your application using the Nexmo CLI, enter the following command into the shell:

``` shell
nexmo app:create "My Messages App" --capabilities=messages --messages-inbound-url=https://example.com/webhooks/inbound-message --messages-status-url=https://example.com/webhooks/message-status --keyfile=private.key
```

This will create a Nexmo application with messages [capabilities](/application/overview#capabilities), with the webhook URLs configured as specified, and generate a private key file `private.key`.

### How to create a Messages and Dispatch application using the Dashboard

You can create Messages and Dispatch applications in the [Dashboard](https://dashboard.nexmo.com/applications/new).

To create your application using the Dashboard:

1. Under Messages and Dispatch in the Dashboard, click [Create an application](https://dashboard.nexmo.com/applications/new).

2. Under **Name**, enter the Application name. Choose a name for ease of future reference.

3. Click the button **Generate public and private key**. This will create a public/private key pair and the private key will be downloaded by your browser.

4. Under **Capabilities** select the **Messages** button.

5. Enter the URL for your inbound message webhook, for example, `https://example.com/webhooks/inbound-message`.

6. Enter the URL for your message status webhook, for example, `https://example.com/webhooks/message-status`.

7. Click the **Create new application** button. You are now taken to the next step of the Create Application procedure where you can link a Nexmo number to the application, and link external accounts such as Facebook to this application.

8. If there is an external account you want to link this application to, click the corresponding **Link** button.

You have now created your application.

> **NOTE:** Before testing your application ensure that your webhooks are configured and your webhook server is running.
