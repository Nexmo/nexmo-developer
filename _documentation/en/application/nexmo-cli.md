---
title: Nexmo CLI
meta_title: Nexmo Command Line Interface (CLI
Description: The Nexmo CLI can be used to create and manage applications.
navigation_weight: 2
---

# Managing applications with the Nexmo CLI

The Nexmo CLI allows you to create and manage your Nexmo applications. To obtain help simply type `nexmo` once the CLI has been installed.

## Installation

The Nexmo CLI (Beta) can be installed with the following command:

```
npm install -g nexmo-cli@beta
```

The latest Beta includes all the facilities to support Application API V2 on the command line. You can check your installed version with the command:

```
nexmo --version
```

## Listing your applications

To list your current applications use:

```
nexmo app:list
```

This displays a list showing the application ID and name.

## Show application details

To show the details of a specific application (where the `APP_ID` is the application  ID of an application that already exists):

```
nexmo app:show APP_ID
```

Returns something like:

```
[id]
61fd1849-280d-4722-8712-1cc59aa12345

[name]
My Client SDK App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MII...n9efcS+L...
-----END PUBLIC KEY-----

[_links.self.href]
/v2/applications/61fd1849-280d-4722-8712-1cc59aa12345

[voice.webhooks.0.endpoint_type]
event_url

[voice.webhooks.0.endpoint]
https://example.ngrok.io/webhooks/event

[voice.webhooks.0.http_method]
POST

[voice.webhooks.1.endpoint_type]
answer_url

[voice.webhooks.1.endpoint]
https://example.ngrok.io/webhooks/answer

[voice.webhooks.1.http_method]
GET
```

Or to display the results in Application V2 format:

```
nexmo as APP_ID --v2
```

This would return:

```
[id]
61fd1849-280d-4722-8712-1cc59aa12345

[name]
My Client SDK App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MIIB...DAQAB...
-----END PUBLIC KEY-----


[capabilities.voice.webhooks.event_url.address]
https://example.ngrok.io/webhooks/event

[capabilities.voice.webhooks.event_url.http_method]
POST

[capabilities.voice.webhooks.answer_url.address]
https://example.ngrok.io/webhooks/answer

[capabilities.voice.webhooks.answer_url.http_method]
GET

[_links.self.href]
/v2/applications/61fd1849-280d-4722-8712-1cc59aa12345
```

This shows the Application V2 [capabilities](/Application/overview#capabilities).

For a messages application the command might be:
```
nexmo as 43fd399e-0f17-4027-83b9-cc16f4a12345 --v2
```

This would return something similar to:

```
[id]
43fd399e-0f17-4027-83b9-cc16f4a12345

[name]
FaceBook Messenger App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MIIB...AQAB...
-----END PUBLIC KEY-----

[capabilities.messages.webhooks.inbound_url.address]
https://example.ngrok.io/webhooks/inbound

[capabilities.messages.webhooks.inbound_url.http_method]
POST

[capabilities.messages.webhooks.status_url.address]
https://example.ngrok.io/webhooks/status

[capabilities.messages.webhooks.status_url.http_method]
POST

[_links.self.href]
/v2/applications/43fd399e-0f17-4027-83b9-cc16f4a12345
```

Note that in this case the messages [capabilities](/Application/overview#capabilities) are displayed.

## Creating an application

### Interactive mode

First create a new directory for your application and change into it. You can then create an application in **interactive mode** using the command:

```
nexmo app:create
```

You are prompted to select your required application capabilities. You can select as many as you want for your application. You are then prompted to enter your webhook URLs, based on the capabilities you selected. For example, if you requested `rtc` capabilities then you are prompted for the RTC Event webhook URL.

Note that the command you could use to recreate the application in the future is also displayed as part of the output. This is useful for future reference, for example, if you later wanted to create a similar application using a script.

### Script mode

To create the application without the interactive mode (useful for scripts), use a command such as:

```
nexmo app:create "Test Application 1" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent
```

This creates the `.nexmo-app` file in your project directory containing the Application ID and private key. You can also copy and paste the private key displayed into a `private.key` file.

Note that the webhook URLs you are required to set depends on the capabilities you have chosen. This is explained in more detail in the [application webhooks](/application/overview#webhooks) topic.

## Creating an application with your own public/private key pair

You can create an application with your own public key if you have a suitable public/private key pair already.

First you need a suitable public/private key pair. To create one, first enter:

```
ssh-keygen -t rsa -b 4096 -m PEM -f private.key
```

Press enter (twice) to not use a passphrase. This generates your private key, `private.key`.

Then enter the following:

```
openssl rsa -in private.key -pubout -outform PEM -out public.key.pub
```

This generates `public.key.pub`. This is the public key you use in creating or updating your Nexmo application:

```
nexmo app:update asdasdas-asdd-2344-2344-asdasd12345 "Application with Public Key" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent --public-keyfile=public.key.pub
```

## Recreate an application

You can see how an application was created by using the `--recreate` option to `app:show`. For example, the command:

```
nexmo app:show 9a1089f2-3990-4db2-be67-3e7767bd20c9  --recreate
```

Would generate the following output:

```
[id]
9a1089f2-3990-4db2-be67-3e7767bd20c9

[name]
APP_NAME

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MII...EAAQ==
-----END PUBLIC KEY-----


[capabilities.voice.webhooks.event_url.address]
http://example.com/event

[capabilities.voice.webhooks.event_url.http_method]
POST

[capabilities.voice.webhooks.answer_url.address]
http://example.com/answer

[capabilities.voice.webhooks.answer_url.http_method]
GET

[capabilities.voice.webhooks.fallback_answer_url.address]


[capabilities.voice.webhooks.fallback_answer_url.http_method]
GET

[capabilities.rtc.webhooks.event_url.address]
http://example.com/rtcevent

[capabilities.rtc.webhooks.event_url.http_method]
POST

[_links.self.href]
/v2/applications/9a1089f2-3990-4db2-be67-3e7767bd20c9


To recreate a similar application use the following command:

nexmo app:create DELETE ME FOREVER --capabilities=voice,rtc --voice-answer-url=http://example.com --voice-fallback-answer-url= --voice-event-url=http://example.com --rtc-event-url=http://example.com 
```

Note, the command to _recreate_ this application is shown at the end of the output.

## Updating an application

You can update a previously created application with a command similar to:

```
nexmo app:update asdasdas-asdd-2344-2344-asdasda12345 "Updated Application" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent
```

You can change the application name, modify any of the webhooks, or add new capabilities.

## Deleting an application

You can delete an application with the following command:

```
nexmo app:delete APP_ID
```

You will be asked to confirm deletion.

> **NOTE:** Deletion cannot be reversed.

## Reference

* [Nexmo CLI GitHub repository](https://github.com/Nexmo/nexmo-cli)
