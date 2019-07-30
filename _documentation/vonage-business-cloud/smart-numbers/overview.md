---
title: Overview
meta_title: Smart Numbers
---

# Overview

> **Note** Smart Numbers is for [Vonage Business Cloud Customers](https://www.vonage.com/business/) only.

Vonage Business Cloud (VBC) Smart Numbers enable you to:

* Forward a VBC call to a Nexmo [Voice API](/voice/voice-api/api-reference) application
* Connect calls to a VBC extension from a Voice API [NCCO](/voice/voice-api/guides/ncco)

## What can you do with it?
You can use all the power and flexibility of the Nexmo Voice API together with the supporting VBC [Account](/vonage-business-cloud/vbc-apis/account-api/overview), [Extension](/vonage-business-cloud/vbc-apis/extension-api/overview) and [User](/vonage-business-cloud/vbc-apis/user-api/overview) APIs to create fully customized call experiences for your customers, including:

* Interactive voice response (IVR) systems that link to your CRM system to personalize the menu options to your customers' needs
* Voicebots that use natural language processing and/or AI to answer simple questions spoken by your customers
* Automatic proxying of local numbers based on the area code dialled
* Voice broadcasts to alert customers to important news or events
* Real-time sentiment analysis to gauge the "mood" of a call
* Calendar integration to check the free/busy status of a call recipient and react accordingly

## Getting Started
To use Smart Numbers, you need:

* A Vonage Business Cloud account
* A Nexmo account

You must then:

1. [Enable the Smart Number add-on](/vonage-business-cloud/smart-numbers/guides/enable-addon) - to add the capability to your VBC account
2. [Create a Nexmo Voice API Application](/vonage-business-cloud/smart-numbers/guides/create-voice-application) - to store security and configuration information
3. [Provision Smart Numbers](/vonage-business-cloud/smart-numbers/guides/provision-smart-numbers) - configure one or more VBC numbers as Smart Numbers and link those numbers to your Nexmo Voice API Application

## Using Smart Numbers

You will use the [Nexmo Voice API](/voice/voice-api/api-reference) to build interactive and customized call experiences for your users. We provide [client libraries](https://github.com/Nexmo/) in various languages that take make it easier to work with the Voice API.

To forward an inbound call on one of your linked VBC numbers to your Nexmo Voice API Application, you create a [webhook](/concepts/guides/webhooks) endpoint in your code and configure the URL in your Nexmo account. This is so that Nexmo's APIs can alert your application when a call is received and ask for instructions on how to process the call.

You provide these instructions in the form of a [Nexmo Call Control Object (NCCO)](/voice/voice-api/guides/ncco) that defines the list of actions that the call must perform, such as reading a message to your caller using text-to-speech, or collecting input as part of an interactive voice response (IVR) system. Another type of action (`connect`) in the NCCO can route the call to a VBC extension.

You can use the [VBC APIs](/vonage-business-cloud/vbc-apis/overview) in your application to retrieve information about your VBC accounts, extensions and users.

> **Getting help**: For a comprehensive list of resources to help you build your application, see [here](/vonage-business-cloud/smart-numbers/guides/vbc-resources).
