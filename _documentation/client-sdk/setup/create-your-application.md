---
title: Create your application
description: This topic shows you how to create a Nexmo application, users and tokens.
navigation_weight: 1
---

# Create your application, users and tokens

In order to use the Nexmo Client SDK, there are three things you need to set up before getting started:

* [Nexmo Application](/application/overview) - an Application which contains configuration for the app that you are building.

* [Users](/conversation/concepts/user) - Users who are associated with the Nexmo Application. It is expected that Users will have a one-to-one mapping with your own authentication system.

* [JSON Web Tokens, JWTs](https://jwt.io/) - Nexmo Client SDK uses JWTs for authentication. In order for a user to log in and use the SDK functionality, you need to provide a JWT per user. JWTs contain all the information the Nexmo platform needs to authenticate requests, as well as information such as the associated Applications, Users and permissions.

All of these may be [created by your backend](/conversation/overview). 
If you wish to get started and experience using the SDK without any implementation of your backend, this tutorial will show you how to do so, using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli).

## Prerequisites

Make sure you have the following:

* A Nexmo account - [sign up](https://dashboard.nexmo.com)
* [Node.JS](https://nodejs.org/en/download/) and NPM installed
* Install the Nexmo CLI.

To install the Nexmo CLI, run the following command in a terminal:

```bash
npm install -g nexmo-cli@beta
```

Set up the Nexmo CLI to use your Nexmo API Key and API Secret. You can get these from the [settings page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.

Run the following command in a terminal, while replacing `api_key` and `api_secret` with your Nexmo API key and secret:

```bash
nexmo setup api_key api_secret
```

This adds this authentication information to the `.nexmorc` file in your home directory.

## Create a Nexmo Application

You now need to create a Nexmo application. In this example you create an application capable of handling both in-app Voice and in-app Messaging use cases.

1) First create your project directory if you've not already done so.

2) Change into the project directory you've just created.

3) Create a Nexmo application [interactively](/application/nexmo-cli#interactive-mode). The following command enters interactive mode:

``` shell
nexmo app:create
```

4) Specify your application name. Press Enter to continue.

5) You can now select you application capabilities using the arrow keys and then pressing spacebar to select the capabilities your application needs. For the purposes of this example select both Voice and RTC capabilities using the arrow keys and spacebar to select and then press Enter to continue.

> **NOTE:** If your app will be Voice-only you can just select Voice capabilities. If you want in-app messaging only select RTC capabilities. If your app will have both in-app voice and messaging select both capabilities.

6) For "Use the default HTTP methods?" press Enter to select the default.

7) For "Voice Answer URL" enter `https://example.ngrok.io/webhooks/answer` or other suitable URL (this depends on how you are testing).

8) You are next prompted for the "Voice Fallback Answer URL". This is an optional fallback URL should your main Voice answer URL fail for some reason. In this case just press Enter. If later you need it you can always add this in the [Dashboard](https://dashboard.nexmo.com/sign-in) or using the Nexmo CLI.

9) You are now required to enter the "Voice Event URL". Enter `https://example.ngrok.io/webhooks/event`.

10) For " RTC Event URL" enter `https://example.ngrok.io/webhooks/rtc`.

11) For "Public Key path" press Enter to select the default. If you want to use your own public-private key pair refer to [this documentation](/application/nexmo-cli#creating-an-application-with-your-own-public-private-key-pair).

12) For "Private Key path" enter `private.key` and press Enter.

The application is then created.

The file `.nexmo-app` is created in your project directory. This file contains the Nexmo Application ID and the private key. A private key file `private.key` is also created.

Creating an application and application capabilities are covered in detail in the [documentation](/application/overview).

## Create a User

Create a User who will log in to Nexmo Client and participate in the SDK functionality: Conversations, Calls and so on.

Replace `MY_USER_NAME` with your desired user name, and run the following command on a terminal:

```bash
nexmo user:create name="MY_USER_NAME"
```

The output with the user ID, is similar to:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

The user ID is used to perform tasks by the SDK, such as login, starting a call and more.

## Generate a User JWT

[JWTs](https://jwt.io) are used to authenticate a user into the Client SDK.

To generate a JWT for a specific user run the following command, remembering to replace the `MY_APP_ID` and `MY_USER_NAME` variables with values that suit your application:

```bash
nexmo jwt:generate ./private.key sub=MY_USER_NAME exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=MY_APP_ID
```

The above command sets the expiry of the JWT to one day from now, which is the maximum amount of time. You may change the expiration to a shortened amount of time, or regenerate a JWT for the user after the current JWT has expired.

> **NOTE**: In production apps, it is expected that your backend will expose an endpoint that generates JWT per your client request.

## Further information

* [More about JWTs and ACLs](/conversation/guides/jwt-acl)
* [In-app Voice tutorial](/client-sdk/tutorials/app-to-phone/introduction)
* [In-app Messaging tutorial](/client-sdk/tutorials/in-app-messaging/introduction)
