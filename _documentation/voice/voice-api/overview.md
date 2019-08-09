---
title: Overview
meta_title: Text-To-Speech, IVR, Call Recording and more with Nexmo's Voice API
navigation_weight: 1
description: The Voice API overview.
---

# Voice API Overview

The Nexmo Voice API is the easiest way to build high-quality voice applications in the Cloud. With the Voice API you can:

* Build apps that scale with the web technologies you are already using
* Control the flow of inbound and outbound calls in JSON with Nexmo Call Control Objects (NCCO)
* Record and store inbound or outbound calls
* Create conference calls
* Send text-to-speech messages in 40 languages with different genders and accents

## Contents

In this document you can learn about:

* [Nexmo Voice API Concepts](#concepts) to introduce terminology
* [**How to Get Started with the Voice API**](#getting-started) including examples in your language
* [Guides](#guides) learn about working with the Voice API
* [Code Snippets](#code-snippets) code snippets to help with specific tasks
* [Use Cases](#use-cases) detailed use cases with code examples
* [Reference](#reference) API documentation and other supporting content

## Concepts

* **Authentication with JWTs** - interaction with the Voice API are authenticated using JWTs (JSON Web Tokens). The [Nexmo libraries](/tools) handle JWT generation using a unique Nexmo Voice Application ID and a Private Key. For more information see [authenticating your applications](/concepts/guides/authentication).

* **Nexmo Voice Applications** - Nexmo Voice Applications represent a one-to-one mapping with the application that you are building. They contain configuration such virtual numbers and webhook callback URLs. You can create Nexmo Voice Applications using the [Nexmo CLI](/tools) or the [Application API](/concepts/guides/applications).

* **[NCCOs](/voice/voice-api/ncco-reference)** - Nexmo Call Control Objects are a set of actions that instruct Nexmo how to control the call to your Nexmo application. For example, you can `connect` a call, send synthesized speech using `talk`, `stream` audio, or `record` a call. They are represented in JSON form as an Array of objects. For more information see the [NCCO Reference](/voice/voice-api/ncco-reference).

* **[Numbers](/voice/voice-api/guides/numbers)** - The key concepts of using phone numbers in the Nexmo Voice API.

* **[Webhooks](/concepts/guides/webhooks)** - HTTP requests are made to your application web server so that you can act upon them. For example, an incoming call will send a webhook.

## Getting Started

### Voice Playground

In the [Nexmo Dashboard](https://dashboard.nexmo.com), you can try out the Voice API interactively in the Voice Playground. Once you are [signed up for a Nexmo account](https://dashboard.nexmo.com/signup), you can go to [Voice Playground](https://dashboard.nexmo.com/voice/playground) in the Dashboard (Voice ‣ Voice Playground).

More details are available in this blog post: [Meet Voice Playground, Your Testing Sandbox for Nexmo Voice Apps](https://www.nexmo.com/blog/2017/12/12/voice-playground-testing-sandbox-nexmo-voice-apps/)

### Using the API

The primary way that you'll interact with the Nexmo voice platform is via the [public API](/voice/voice-api/api-reference). To place an outbound call, you make a `POST` request to `https://api.nexmo.com/v1/calls`.

To make this easier, we provide client libraries in various languages that take care of authentication and creating the correct request body for you. Choose your language below to get started.

```code_snippets
source: '_examples/voice/make-an-outbound-call'
application:
  type: voice
  name: 'Outbound Call code snippet'
  answer_url: https://developer.nexmo.com/ncco/tts.json
```

## Guides

```concept_list
product: voice/voice-api
```


## Code Snippets

```code_snippet_list
product: voice/voice-api
```

## Use Cases

```use_cases
product: voice/voice-api
```

## Reference

* [Voice API Reference](/api/voice)
* [NCCO Reference](/voice/voice-api/ncco-reference)
* [Webhook Reference](/voice/voice-api/webhook-reference)
