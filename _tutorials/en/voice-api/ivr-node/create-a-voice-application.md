---
title: Create a Voice Application
description: Create a Voice Application using nexmo cli
---

## Create a Voice Application

A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products. You make calls to a Nexmo product using the security information in the application. When the call connects, Nexmo communicates with your webhook endpoints so you can manage your call.

You can use Nexmo CLI to create an application for Voice API by using the following command and replacing the `YOUR_URL` segments with the URL of your own application:

```bash
nexmo app:create phone-menu YOUR_URL/answer YOUR_URL/event
Application created: 5555f9df-05bb-4a99-9427-6e43c83849b8
```

This command uses the `app:create` command to create a new app. The parameters are:

* `phone-menu` - the name you give to this application
* `YOUR_URL/answer` - when you receive an inbound call to your Nexmo number, Nexmo makes a [GET] request and retrieves the NCCO that controls the call flow from this webhook endpoint
* `YOUR_URL/event` - as the call status changes, Nexmo sends status updates to this webhook endpoint

The command returns the UUID (Universally Unique Identifier) that identifies your application - you might like to copy and paste this as we will need it later.