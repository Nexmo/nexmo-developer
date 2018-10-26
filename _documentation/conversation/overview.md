---
title: Overview
---

# Conversation API

The Conversation API allows you to create various objects such as Users, Members, Conversations used in text, voice and video communication between two endpoints.

## Contents

* [Developer Preview](#developer-preview)
* [Supported features](#supported-features)
* [Getting started](#getting-started)
* [Concepts](#concepts)
* [Building Blocks](#building-blocks)
* [Tutorials](#tutorials)
* [Reference](#reference)

## Developer Preview

This API is currently in Developer Preview.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Conversation API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

## Supported features

Conversation API provides a fundamental mechanism that allows Text, Voice and Video communication. It supports four communication mechanisms App, Phone, SIP, and Websocket. Support for creating communication applications that use the Conversation API are provided by the [Comms SDKs](/comms-sdks/overview), which are available for JavaScript, Android, and iOS.

## Getting started

You should be familiar with the following before you use the Conversation API:

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account)
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers)
3. [Install the Nexmo Command Line tools](/tools)
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

```building_blocks
source: '_examples/conversation/conversation/list-conversations'
```

## Concepts

```concept_list
product: conversation
```

## Building Blocks

```building_block_list
product: conversation
```

## Tutorials

```tutorials
product: conversation
```

## Reference

* [Conversation API Reference](/api/conversation)