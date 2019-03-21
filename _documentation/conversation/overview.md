---
title: Overview
---

# Conversation API

The Conversation API is a low-level API that allows you to create various objects such as Users, Members, and Conversations.

Conversations are the fundamental concept the API revolves around. Conversations are containers of communications exchanged between two or more Users which could be a single interaction or the history of all interactions between them.

The API also allows you to create Events and Legs to enable text, voice and video communications between two Users and store them in Conversations.

Text, voice and video communications can currently flow through various Channels like App, Phone, SIP, and Websocket. To enable the App channel (for in-app messaging, voice and video), you would need to also utilize our Nexmo [Client SDK](/client-sdk/overview).

Phone, SIP and Websocket Channels are enabled through the [Voice API](/voice/voice-api/overview) and they all flow into Conversations.

## Contents

* [Developer Preview](#developer-preview)
* [Supported features](#supported-features)
* [Getting started](#getting-started)
* [Concepts](#concepts)
* [Code Snippets](#code-snippets)
* [Tutorials](#tutorials)
* [Reference](#reference)

## Developer Preview

This API is currently in Developer Preview.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [ea-support@nexmo.com](mailto:ea-support@nexmo.com) and include Conversation API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

## Supported features

The Conversation API currently supports a range of communication channels described in this documentation.

As the Conversation API expands to support more and more Nexmo services, the supported Channels will also expand.
Conversations would, as a result, become the container for the history of all your communication exchanged via Nexmo Services. This history would then be accessible through the Conversation API.

> **IMPORTANT:** If you are in APAC region there are some limitations. Please contact [ea-support@nexmo.com](mailto:ea-support@nexmo.com) for information on how to obtain APAC LVN support via our Singapore servers.

## Getting started

You should be familiar with the following before you use the Conversation API:

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account)
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers)
3. [Install the **Beta version** of the Nexmo Command Line tools](/conversation/cli-reference#install-the-beta-version-of-the-cli)
4. [Create a Nexmo Application using the command line tools or Dashboard](/concepts/guides/applications#getting-started-with-applications)
5. [Set up Ngrok](https://ngrok.com)

> **NOTE:** Ngrok is typically used to test a [webhook](/concepts/guides/webhooks) server (web application) locally. Alternatively you can host your application on the web using your preferred hosting provider.

The Conversation API is authenticated using JWTs. You can generate a JWT with the following command:

``` shell
JWT="$(nexmo jwt:generate private.key exp=$(($(date +%s)+86400)) application_id=NEXMO_APPLICATION_ID)"
```

You can then view the JWT with:

```
echo $JWT
```

You need to replace `NEXMO_APPLICATION_ID` with the ID for your application. Also, `private.key` is the key associated with this same application.

You can verify your JWT at [jwt.io](https://jwt.io).

To make an example Conversation API call:

```code_snippets
source: '_examples/conversation/conversation/list-conversations'
```

## Concepts

```concept_list
product: conversation
```

## Code Snippets

Code snippets provide ready to use samples of code so you can build out your application quickly.

You could start by [Creating a Conversation](/conversation/code-snippets/conversation/create-conversation).

## Tutorials

```tutorials
product: conversation
```

## Reference

* [Conversation API Reference](/api/conversation)
* [Client SDK](/client-sdk/overview)
