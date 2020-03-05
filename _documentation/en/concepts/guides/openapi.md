---
title: OpenAPI
description: What OpenAPI is and how to use it in your development process
navigation_weight: 5
---

# OpenAPI

[OpenAPI](https://www.openapis.org/) is an industry standard specification for describing APIs. At Nexmo, we use OpenAPI to describe all our APIs, and we make those specifications publicly available too.

## Finding an OpenAPI Specification

Each of our products has its own OpenAPI specification. The easiest way to find it is from the API reference - at the top of the page you'll find a "Download OpenAPI 3 Definition" button. The API reference pages themselves are generated from these specifications.

<img src="/assets/images/download-openapi3-button.png" alt="Button with label: Download OpenAPI3 Definition" />

The spec files for each API product are also available [on a GitHub repository](https://github.com/nexmo/api-specification) if you'd like to browse the list directly.

Each specification is in [YAML format](https://en.wikipedia.org/wiki/YAML); you can view it with an plain text editor.

## Use an OpenAPI Specification in Your Own Projects

Having the OpenAPI description of an API that you want to integrate with can really make things easier! Here are some suggestions that you might like to try:

**Local Documentation**

Whether you're working on a poor connection or just prefer to keep things simple, an OpenAPI spec has all the information you need to be able to run a local application to show documentation. Try one of these tools:

* [Nexmo OAS Renderer](https://github.com/Nexmo/nexmo-oas-renderer) is an open source Ruby tool (as you may guess from the name, we created and maintain it)
* [Redoc](https://github.com/Redocly/redoc) is another open source documentation tool, in JavaScript

**Ready-made Postman Collections**

If you're already a [Postman](https://www.postman.com/) fan then this may well appeal to you. If not, then give it a try.

1. Download the spec for the API you're interested (via the API reference page)
2. In Postman, click "Import" and choose the *.yml file you just downloaded

.... that's it. You have a ready-made set of requests to make against the API, just add your Nexmo account details and off you go!

**Mock Server for Testing with Prism**

One tool that many of our developers find useful is [Prism](https://stoplight.io/open-source/prism). It's an open source JavaScript tool that accepts an OpenAPI spec and then imitates the API behaviour it describes. It's an ideal way to work with a local API, avoids using up Nexmo credit when you're testing something, and also gives an easy way to test error responses.
