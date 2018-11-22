## Create a Nexmo Application

There are two alternative methods for creating a Messages and Dispatch application:

1. Using the Dashboard
2. Using the Nexmo CLI

Each of these methods is described in the following sections.

### How to create a Messages and Dispatch application using the Dashboard

You can now create Messages and Dispatch applications in the [Dashboard](https://dashboard.nexmo.com/messages/create-application). This allows you to set webhooks for each application created - this is important for receiving inbound messages and message status updates.

To create your application using the Dashboard:

1. Under Messages and Dispatch in the Dashboard, click [Create an application](https://dashboard.nexmo.com/messages/create-application).

2. Enter the Application name, which can be anything you like.

3. Enter the URL for your message status webhook, for example, `https://example.com/webhooks/message-status`.

4. Enter the URL for your inbound message webhook, for example, `https://example.com/webhooks/inbound-message`.

5. Click the link *Generate public/private key pair* just below the public key text area. This will create a public/private key pair and the private key will be downloaded by your browser.

6. Click the *Create Application* button. You will be taken to phase 2 of the Create Application procedure where you can link external accounts such as Facebook to this application. If you do not have any external accounts listed here, or do not want to link one of those accounts to this application you can click *Done*.

7. If there is an external account you want to link this application to, click the corresponding *Link* button and then click *Done*.

### How to create a Messages and Dispatch application using the Nexmo CLI

To create your application using the Nexmo CLI, enter the following command into the shell:

``` shell
nexmo app:create "My Messages App" https://example.com/webhooks/inbound-message https://example.com/webhooks/message-status --keyfile=private.key --type=messages
```
