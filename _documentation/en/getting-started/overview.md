---
title: Read this first!
meta_title: What you need to know and have to start working with our APIs
navigation_weight: 1
---

# Getting Started

Welcome to the Vonage API platform! Vonage provides a suite of APIs that enable you to communicate with your customers using your preferred channels. 

This site provides comprehensive documentation for all of our APIs and you’ll find everything you need to know about working with a particular API in the corresponding section.

However, there are some fundamental concepts that you need to understand and tools that might help you that apply across all our APIs. Here, we'll give you this information and get you up and running as quickly as possible.

**What you will learn**:

- [Signing up for an account](#signing-up-for-an-account)
- [Accessing the Developer Dashboard](#accessing-the-developer-dashboard)
- [Using the Nexmo CLI](#using-the-nexmo-cli)
- [Experimenting with our APIs](#experimenting-with-our-apis)
- [Using a Server SDK](#using-a-server-sdk)
- [Working with Webhooks](#working-with-webhooks)
- [What to do next](#what-to-do-next)

## Signing up for an account

To work with our APIs, you will need to [sign up for an account](/account/guides/dashboard-management#create-and-configure-a-nexmo-account). This will give you an API key and secret that you can use to access our APIs.

## Accessing the Developer Dashboard

Once you have an account, you can log into the [Developer Dashboard](/account/guides/dashboard-management#using-the-nexmo-dashboard-for-account-management). The Developer Dashboard is a GUI-based approach to managing your account, where you can:

* **View your API key and secret**. You will need these to authenticate your requests to our APIs
* **Manage your account balance**. Access to our APIs is charged on a  per-request basis. We’ll give you some free credit when you first open your account and you can [top up](/numbers/guides/payments) when you run low.
* **Rent virtual numbers**. You can use [virtual numbers](/concepts/guides/glossary#virtual-number) provided by Vonage to send and receive calls and messages. See [rent a virtual number](/numbers/guides/number-management#rent-a-virtual-number).
* **Manage applications**. Some of our APIs (such as Voice and Messages) require you to create an [Application](/application/overview), which acts as a container for security and configuration information. You can create and manage these applications in the Developer Dashboard.
* **Manage your account**. You can perform [other administration tasks](/account/guides/dashboard-management) here.

## Using the Nexmo CLI

You can optionally perform many of the Dashboard tasks from the command line, using the Nexmo CLI. This is often quicker and also allows you to script these operations.

The Nexmo CLI is written in Node.js and installed using the Node Package Manager (`npm`). The `README` in the [Nexmo CLI GitHub repo](https://github.com/Nexmo/nexmo-cli) shows you how to install and work with the Nexmo CLI.

## Authentication

When using the Vonage APIs your requests need to be [authenticated](/concepts/authentication). Typically this is done using [Basic Authentication](/concepts/authentication#basic-authentication) or [JWTs](/concepts/authentication#jwts). You can generate a suitable JWT using the Nexmo CLI, or our [online tool](/jwt).

## Experimenting with our APIs

Ultimately, you’re going to want to build an app in your [chosen programming language](#using-a-server-sdk). But to start with, you might want to make some sample requests to our APIs to check that you have provided the correct parameters and that you are getting back the responses you want.

If you are familiar with the command-line tool [Curl](https://curl.haxx.se/), you will find Curl snippets for each of our APIs that you can copy, paste and modify.

### Postman

Various GUI tools exist that are easier to use than Curl. A popular one is [Postman](https://www.postman.com/). Read our guide on [using Postman to work with our APIs](/tools/postman). Vonage also provides a set of [Postman collections](/concepts/guides/openapi#postman-collections), which provides a way to start using the APIs immediately.

### OpenAPI

Each of our APIs has its own [OpenAPI specification](/api). You can read more about OpenAPI in our [documentation](/concepts/guides/openapi). Our specifications conform to OpenAPI specification version 3, also known as OAS3.

## Using a Server SDK

When you are ready to start building your app, you’ll want to use one of our Server SDKs instead of coding each request by hand. We have SDKs for the following programming languages:

- [Node.js](https://github.com/nexmo/nexmo-node)
- [Java](https://github.com/nexmo/nexmo-java)
- [.NET](https://github.com/nexmo/nexmo-dotnet)
- [PHP](https://github.com/nexmo/nexmo-php)
- [Python](https://github.com/nexmo/nexmo-python)
- [Ruby](https://github.com/nexmo/nexmo-ruby)

Click on the link for your chosen language to visit that SDK’s GitHub repo page, where you can learn how to install and use it.

## Working with Webhooks

Once you have learned how to make requests to our APIs to place calls, send messages and so on you will want to learn how to receive inbound communications on your virtual number.

When our APIs want to notify your app about something - whether that is an inbound call or message or a status update - they require your app to expose a URL endpoint that our platform can make a request to. These must be accessible over the public Internet.

These endpoints are called Webhooks. [Find out more about webhooks](/concepts/guides/webhooks). Once you have created your web hook, you must tell our API platform to use it. The process for doing this depends on which API you are using and full instructions can be found in the documentation for that API.

Making these webhooks publicly-accessible during development can be tricky, so we recommend a tool called [Ngrok](https://ngrok.com/).

Visit our guide on [testing with Ngrok](https://developer.nexmo.com/tools/ngrok) to learn how to use it.

## What to do next

This guide introduced you to some of the fundamental concepts and tools that you should know about when working with our APIs.

> Learn more in our [Concepts](/concepts/overview) and [Tools](https://developer.nexmo.com/tools) sections.

Once you understand these fundamental concepts and have installed the tools you intend to use, you are ready to start building! View the documentation for your chosen API to get started, or try out some of the following simple tasks:

* SMS API: [Send an SMS](/messaging/sms/code-snippets/send-an-sms)
* Voice API: [Make an outbound call with an NCCO](/voice/voice-api/code-snippets/make-an-outbound-call-with-ncco)
* Verify API: [Send](/verify/code-snippets/send-verify-request) and then [check](/verify/code-snippets/check-verify-request) a verification request.
* Messages API: [Send a message using Facebook Messenger](/messages/code-snippets/messenger/send-text)

> If you encounter any difficulties, check out our knowledge base and reach out for assistance if necessary at [our support site](https://help.nexmo.com/).

We take pride in our documentation, but are always looking to make it better. So if you find anything that is unclear or lacking the information you require, then please submit feedback for the topic in question. If we’ve done a good job on a particular section then please let us know!
