---
title: Overview
description: the Voice API overview.
---

# Voice API Overview

The Nexmo Voice API is the easiest way to build high-quality voice applications in the cloud. With the Voice API you can:

* Build apps that scale with the web technologies that you are already using
* Control the flow of inbound and outbound calls in JSON with Nexmo Call Control Objects (NCCO)
* Record and store inbound or outbound calls
* Create conference calls
* Send text-to-speech messages in 23 languages with different genders and accents

## Contents

In this document you can learn about:

* [Nexmo Voice API Concepts](#concepts)
* [How to Get Started with the Voice API](#getting-started)
* [Voice API Features](#voice-api-features)
* [References](#references)
* [Tutorials](#tutorials)

## Concepts

* **Authentication with JWTs** - interaction with the Voice API are authenticated using JWTs. The [Nexmo libraries](/tools) handle JWT generation using a unique Nexmo Voice Application ID and a Private Key. For more information on see [Authenticating your applications](/concepts/guides/authentication)
* **Nexmo Voice Applications** - Nexmo Voice Applications represent a one-to-one mapping with the application that you are building. They contain configuration such virtual numbers and webhook callback URLs. You can create Nexmo Voice Applications using the [Nexmo CLI](/tools) or the [Application API](https://docs.nexmo.com/tools/application-api)
* **Webhooks** - when any event takes place relating to your Nexmo application HTTP callbacks are made to your application web server so that you can act upon them. For example, when an inbound call is made to a number associated with your Nexmo application.
* **NCCOs** - Nexmo Call Control Objects are a set of actions that instruct the Nexmo how to control call to your Nexmo application. For example, you can `connect` a call, send synthesized speech using `talk`, `stream` audio, or `record` a call. They are represented in JSON form as an Array of objects. For more information see the [NCCO Reference](/voice/guides/ncco-reference) and [NCCO guide](/voice/guides/ncco).

## Getting Started

Before you begin:

* Sign up for a [Nexmo account](https://dashboard.nexmo.com/signup)
* Install [Node.JS](https://nodejs.org/en/download/)

> *Note*: If you do not wish to install Node to use the [Nexmo CLI](/tools) you can also create applications using the [Application API](https://docs.nexmo.com/tools/application-api)*

Install and Setup the Nexmo CLI (Command Line Interface)

Install the Nexmo CLI:

```bash
$ npm install -g nexmo-cli
```

*Note: depending on your system setup you may need to prefix the above command with `sudo`*

Using your Nexmo `API_KEY` and `API_SECRET`, available from the [dashboard getting started page](https://dashboard.nexmo.com/getting-started-guide), you now setup the CLI with these credentials.

```bash
$ nexmo setup API_KEY API_SECRET
```

### Create a Nexmo Voice Application

Create a Nexmo Voice Application within the Nexmo platform to contain configuration such as associated virtual numbers and webhook callback URLs.

```bash
$ nexmo app:create 'First Voice App' --type voice https://nexmo-community.github.io/ncco-examples/first_call_talk.json https://example.com/events --keyfile private.key
```

The output of the `app:create` command contains:

* The ID of your Nexmo Voice Application
* The location of the `private.key`

```bash
Application created: 635c2797-9295-4cdf-9232-d275f75ff096
Private Key saved to: private.key
```

Both of these are required to interact with the Nexmo Voice API.

For more information on the `app:create` command run `nexmo app:create --help` in your terminal or console.

### Make a Text-to-Speech Call

In the examples replace `API_KEY`, `API_SECRET`, `APPLICATION_ID`, `PRIVATE_KEY_PATH`, `TO_NUMBER` and `FROM_NUMBER` with real values.

```tabbed_content
source: '_examples/voice/make-a-tts-call'
```

## Voice API Features

The Nexmo Voice API provides features which are actioned in one of two ways:

1. Through a call to the [Voice REST API](/api/voice)
2. By returning [NCCOs](/voice/guides/ncco-reference) from your app server webhook endpoints

The following table shows the features available and how are achieved.

Action + Guide | NCCO | API
-- | -- | --
[Create outbound calls](/voice/guides/outbound-calls) | | [`POST /calls`](/api/voice#create-an-outbound-call) |
[Accept inbound calls](/voice/guides/inbound-calls) | See [Nexmo Call Control Objects](/voice/guides/ncco) |
Retrieve all call information | | [`GET /calls`](/api/voice#call_retrieve)
Retrieve information for a call | | [`GET /calls/{uuid}`](/api/voice#call_retrieve_single)
End an in-progress call | | [`PUT /calls/{uuid}`](/api/voice#call_modify_single)
[Record a call](/voice/guides/record-calls-and-conversations) | [`record`](/voice/guides/ncco-reference#record) |
[Collect user input from a call (IVR)](/voice/guides/interactive-voice-response) | [`input`](/voice/guides/ncco-reference#input) |
[Create conference calls](/voice/guides/create-conferences) | [`conversation`](/voice/guides/ncco-reference#conversation) |
[Connect calls to phone endpoints](/voice/guides/connect-two-users) | [`connect`](/voice/guides/ncco-reference#connect) |
[Connect calls to websocket endpoints](/voice/guides/call-a-websocket) | [`connect`](/voice/guides/ncco-reference#connect) |
Stream audio to a call | [`stream`](/voice/guides/ncco-reference#stream) | [`PUT /calls/{uuid}/stream`](/api/voice#stream_put)
Stop streaming audio to a call | | [`DELETE /calls/{uuid}/stream`](/api/voice#stream_delete)
Send synthesized speech to a call | [`talk`](/voice/guides/ncco-reference#talk) | [`PUT /calls/{uuid}/talk`](/api/voice#talk_put)
Stop sending synthesized speech to a call | | [`DELETE /calls/{uuid}/talk`](/api/voice#talk_delete)
Send Dual-tone multi-frequency (DTMF) to a call | | [`PUT calls/{uuid}/dtmf`](/api/voice#dtmf_put)

## References

* [Voice API Reference](/api/voice)
* [NCCO Reference](/voice/guides/ncco-reference)

## Tutorials

* [Private voice communication](/tutorials/private-voice-communication)
* [Call tracking](/tutorials/call-tracking)
* [Interactive voice response](/tutorials/interactive-voice-response)
