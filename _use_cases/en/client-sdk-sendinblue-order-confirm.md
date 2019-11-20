---
title: Order support system 
products: client-sdk
description: How to build a product order confirmation and support system with Nexmo Client SDK and Sendinblue.
languages: 
    - Node
---

# Order support system

## Before you begin

It is assumed you have both a [Nexmo account](https://dashboard.nexmo.com/sign-in) and a [Sendinblue account](https://app.sendinblue.com/account/register), and associated API keys and secrets.

## Overview

In this use case you will learn how to build an order confirmation and support system using the Nexmo Client SDK and Sendinblue. This use case features two-way chatting with a support agent, and also the sending of an order confirmation email via Sendinblue.

The scenario is as follows:

1. A user creates an order. An order confirmation email is sent to the user via [Sendinblue](https://www.sendinblue.com). The order email contains a link the user can click to chat with a support agent about the order.

2. A [custom event](/client-sdk/custom-events) is created when the confirmation email goes out. This is retained in the Conversation for that user.

3. A chat screen is loaded that contains the current order data, order history, and message history. The order and message histories are stored in a Conversation associated with the user.

4. Two way chat can then take place between the customer and a support agent.

## Installation

The following procedure assumes you have the `git` and `npm` commands available on the command line.

**1.** Install the Nexmo CLI:

``` bash
npm install nexmo-cli@beta -g
```

> **NOTE:** The Beta version of the Nexmo CLI is required for this demo.

**2.** Initialize your credentials for use with the Nexmo CLI:

``` bash
nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```

This will update your `~/.nexmorc` file on Linux or macOS. On Windows this file is stored in your User directory, for example, `C:\Users\James\.nexmorc`.

**3.** Clone the GitHub repo for this use case:

``` bash
git clone https://github.com/nexmo-community/sendinblue-use-case.git
```

**4.** Change into the cloned project directory.

**5.** Install the required NPM modules:

``` bash
npm install
```

This installs required modules based on the `package.json` file.

**6.** Copy `example.env` to `.env` in the project directory. You will edit `.env` in a later step to specify your credentials and other configuration information.

**7.** Create a Nexmo application [interactively](/application/nexmo-cli#interactive-mode). The following command enters interactive mode:

``` bash
nexmo app:create
```

a. Specify your application name. Press Enter to continue.

b. Specify RTC capabilities with the arrow keys and press spacebar to select. Press Enter to continue.

c. For "Use the default HTTP methods?" press Enter to select the default.

d. For " RTC Event URL" enter `https://example.ngrok.io/webhooks/rtc` or other suitable URL (depends on how you are testing).

e. For "Public Key path" press Enter to select the default.

f. For "Private Key path" enter `private.key` and press Enter.

The application is then created.

The file `.nexmo-app` is created in the project directory containing the Application ID and the private key.

**8.** Open the `.env` file in your project directory with an editor.

**9.** Add the Nexmo Application ID to your `.env` file (`NEXMO_APPLICATION_ID`).

## Configuration

Set the following information:

``` text
NEXMO_APPLICATION_ID=App ID for the application you just created
NEXMO_API_KEY=
NEXMO_API_SECRET=
NEXMO_APPLICATION_PRIVATE_KEY_PATH=private.key
CONVERSATION_ID=
PORT=3000
SENDINBLUE_API_KEY=
SENDINBLUE_FROM_NAME=
SENDINBLUE_FROM_EMAIL=
SENDINBLUE_TO_NAME=
SENDINBLUE_TO_EMAIL=
SENDINBLUE_TEMPLATE_ID=
```

1. Set Nexmo API key and secret. You can obtain your Nexmo API key and Nexmo API secret from the [Nexmo Dashboard](https://dashboard.nexmo.com).
2. Set the port number. The example shown assumes you are using port 3000, but you can use any convenient free port.

> **NOTE:** The Conversation ID is only used for testing purposes. You do not need to configure it at this stage.

You will now continue to Sendinblue configuration.

### Sendinblue configuration

You must have a [Sendinblue API key](https://account.sendinblue.com/advanced/api).

For testing this use case it is assumed you have Sendinblue "sender" information. This is the email address and name you are sending emails **from**.

You should also specify a user name and email address that will receive the order confirmation emails. Usually this information would be available on a per-customer basis in the user database, but in this use case it is set in the environment file for testing convenience. This is the email address and name you are sending emails **to**.

You also need the ID of the [email template](https://account.sendinblue.com/camp/lists/template) you are using. The template is created in the Sendinblue UI. When you have created a template and activated it you can make a note of the ID as specified in the UI. This is the number that is used here.

A sample template that can be used with this demo is given here:

```
ORDER CONFIRMATION

Dear {{params.name}},

Thank you for your order!

ORDER_ID

{{params.order_id}}

ORDER_TEXT

{{params.order_text}}

If you would like to discuss this order with an agent please click the link below:

{{params.url}}

Thanks again!
```

You can use this sample to create a template in Sendinblue.

See [Sendinblue on creating templates](https://help.sendinblue.com/hc/en-us/articles/209465345-Where-do-I-create-and-edit-the-email-templates-used-in-SendinBlue-Automation-) for information on creating your own template.

> **IMPORTANT:** Make sure that once you have created your template you add the Template ID (an integer available from the Sendinblue UI) to the `.env` file before you continue.

## Running the code

There are several steps to running the demo.

**1.** In the project directory start the server:

``` bash
npm start
```

This starts up the server using `node.js`.

**2.** Create the support agent user with the following Curl command:

```
curl -d "username=agent" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/user
```

Check the server console logging which will respond with something similar to:

```
Creating user agent
User agent and Conversation CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd created.
```

This creates the user 'agent'. In the case of the 'agent' the conversation is not used in this demo.

> **IMPORTANT:** It is necessary to create the support agent before any other user in this simple demo. In this use case the agent must have the username `agent`.

**3.** Create a customer user:

```
curl -d "username=user-123" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/user
```

This creates the user 'user-123'. You can specify any username here. Make a note of the username you specified.

You will notice from the server console logging that a conversation is also created for the user:

```
Creating user user-123
User user-123 and Conversation CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd created.
```

**4.** Create a customer order:

```
curl -d "username=user-123" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/order
```

This creates an order for user 'user-123'. For simplicity, this is a simple pre-defined static order, rather than a full-fledged shopping cart. Check the server console logging, you will see something similar to:

``` text
Creating order...
Order URL: http://localhost:9000/chat/user-1234/CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd/1234
Sending order email user-1234, 1234, Dear user-1234, You purchased a widget for $4.99! Thanks for your order!, http://localhost:9000/chat/user-1234/CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd/1234
API called successfully. Returned data: [object Object]
```

This step also generates a custom event of type `custom:order-confirm-event` containing the order details.

In addition, a confirmation email is sent via Sendinblue. This email contains a link the user would select to chat if they wanted support with order.

**5.** Check you have received the order email. Go to the inbox defined in your configuration to read the confirmation email.

**6.** Click the link in the email to log the customer into the chat screen.

**7.** Log the agent into the chat. For this step it is recommended you additionally start an 'incognito' tab in your browser (or use a new browser instance).

For simplicity, the support agent logs into the chat using a method similar to the customer. You can just copy the link the client clicked on in the email, and change the username in the link to `agent`:

```
localhost:3000/chat/agent/CON-ID/ORDER-ID
```

The user and support agent can now engage in a two-way chat messaging session to discuss the order.

## Exploring the code

The main code files are `client.js` and `server.js`.

The **server** implements a simple REST API for creating users and orders:

1. `POST` on `/user` - creates a user. Username is passed in the body.
2. `POST` on `/order` - creates an order. Username of the person creating an order is passed in the body.
3. `GET` on `/chat/:username/:conversation_id/:order_id` - logs user or agent into chat room based on `username`.

The **client** uses the Nexmo Client SDK. It performs the following main functions:

1. Creates a `NexmoClient` instance.
2. Logs the user into the Conversation based on a JWT generated by the server.
3. Obtains the Conversation object.
4. Registers event handlers for the message send button and `text` events.
5. Provides a basic UI for displaying current order, order history and message history, as well as the ongoing chat.

## Summary

In this use case you have learned how to build an order confirmation and support system. The user receives an order confirmation email via Sendinblue. The user can then engage in two-way messaging with the support agent to discuss the order if required.

## What's next?

Some suggestions for improving the demo:

* Improve the UI using CSS.
* Add a more sophisticated ordering system. Perhaps each order would be a JSON snippet.
* Add ability to [Click to call](/client-sdk/tutorials/app-to-phone/introduction) the support agent.
* Send an SMS notification to the agent when the user joins the chat room.

## Reference

* [Demo code repository on GitHub](https://github.com/nexmo-community/sendinblue-use-case)
* [Sendinblue client library for Node](https://github.com/sendinblue/APIv3-nodejs-library)
* [Sendinblue send transactional email](https://developers.sendinblue.com/docs/send-a-transactional-email)
* [Client SDK docs](/client-sdk/overview)
* [Conversation API docs](/conversation/overview)
* [Conversation API Reference](/api/conversation)
