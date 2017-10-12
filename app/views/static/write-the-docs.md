---
title: Write the docs
---

# Write the docs

This document provides a guide for writing documentation for Nexmo Developer.

## How should I structure documents?

The NDP content should be designed to be clear, concise and consistent in that order. Exceptions can be made to break consistency where it makes sense, particularly in scenarios where the content would be unnecessary verbose or the structures outlined in this guide are unsuited to material. This guide outlines what we consider to be best practice for our documentation, feel free to open an pull request if you feel as though the advise could be improved upon.

### Structure

The NDP is structured by context and by product. The four main sections of the NDP are:

*Documentation*

This section hosts the bulk of the written content for the NDP. The content is structured by products each of which have the following four sections:

  * [Overview](#overview)
  * [Guides](#guides)
  * [Building Blocks](#building-blocks)
  * [Tutorials](#tutorials)

*API Reference*

The future structure for the API Reference is still under consideration. At this time the content represents a migration from docs.nexmo.com.

*SDKs & Tools*

A section that outlines our SDKs, Tools, Libraries etc. The repo README's should speak for themselves so the content for this page is deliberately very bare.

*Community*

As it develops the community section will be host for 'cool hacks', open source projects that use Nexmo, the events that we are present at or support and links to posts that the community have written about Nexmo.

### Content guides

Different types of content have different requirements, the following should be used as a guideline and broken only when good rational is provided to do so.

#### Overviews

Overview pages are the first pages you reach when you select a product. They serve to support the user to understand the product and direct them to the most appropriate resources.

*Opening*

Explain what the product is and with bullet points what you can do with the product.

> Note: The opening has no heading as the `Overview` heading serves this purpose.

*Contents*

This should be a bulleted outline the contents of the current page, each item should be an anchor link to a page heading.

*Concepts*

It's important to make sure that the user has a grasp of subjects that are common throughout the product you are documenting. Concepts introduces these in brief and links off to further reading where appropriate.

*Getting started*

This section is designed to prove to the user the product does what it claims to. This could be an interactive demonstration or an opinionated & basic getting started guide.

*Features*

Now that the user has an understanding of what the product it's important we tell them what are the capabilities of the product and with links off to guides.

*Further reading*

Further reading isn't a section itself but rather contains links off to the product Building Blocks, Guides, API references & Tutorials.

#### Guides

The guides provide an in depth look into an actionable task such as "How do I send an SMS programmatically". The guides support the user through this problem in an opinionated, isolated way that follows best practice.

*Opening*

Explain what the problem is and outline the steps that you'll take to overcome it in bullet points.

> Note: The opening has no heading as the heading should serve this purpose.

*Guide*

Every guide has its own problem to solve. Use headings and sections that align with the steps one would take to overcome the problem.

*Conclusion*

Point to resources:

* Tutorials - More in depth guides to support the user even further
* API Reference - Given that the guide is opinionated, provide this as a resource to allow the user to see what other options are available to them.
* Other relevant guides - Some guides are closely aligned, for example "Send an SMS" should suggest "Receive a delivery receipt" as further reading.

Reflect on:

* What you have done
* How you could extend on what you have learnt

#### Building Blocks

Building Blocks are used as a quick reference of how to so something specific. They are aimed at users who are somewhat familiar with the product and require a 'snippet' of code or supplementary information to support them during development phase.

*Further reading*

Point to resources:

* Guide - The same subject with more supporting content
* API Reference - Provide this as a resource to allow the user to see what other options are available to them

#### Tutorials

Tutorials are complete example of how to build something practical. They are step by step and self contained providing all necessary content inline and may combine many different products.

*Opening*

Explain what the problem is and outline the steps that you'll take to overcome it in bullet points.

> Note: The opening has no heading as the heading should serve this purpose.

*Guide*

Every tutorial has its own problem to solve. Use headings and sections that align with the steps one would take to overcome the problem.

*Conclusion*

Reflect on:

* What you have done
* How you could extend on what you have learnt

Point to resources:

* Guides - Guides covering the actions used in the tutorial.
* API Reference - Given that the tutorial is opinionated, provide this as a resource to allow the user to see what other options are available to them.
* Other relevant tutorials.

## Code samples

## Use the library

If an existing Nexmo-supported API library supports the functionality, you should use that library for code samples.

### Principle of Least Astonishment

Code samples should match the expectations and experience of a median-level competent developer in a language and try hard to not surprise or confuse them. Code samples for APIs are not a place to use flashy, experimental or cutting-edge techniques, but to try to maximise compatibility, and reduce ambiguity.

Code samples **MUST NOT** use any technique widely considered to be insecure, badly designed or likely to cause harm or confusion to the user.

### JavaScript

Documentation should be clear whether JavaScript code is intended to run on the server (using, say, node.js), the client, or both.

### Python

Python code should adhere to [PEP8](http://pep8.org/).

Avoid code that is significantly different in Python 2 and 3. When this is unavoidable, abstract away the incompatible code to the smallest area possible and use [`__future__`](https://docs.python.org/2/library/__future__.html) to ensure backwards compatibility with Python 2.

Inbound HTTP calls should use a WSGI-compatible web framework, preferably the [Flask](http://flask.pocoo.org/) micro-framework. Explanations of how to integrate Nexmo APIs with [Django](https://www.djangoproject.com/) are sensible too.

## What should I use in place of variables?

When working with keys, phone numbers or accounts we should always be clear about our intent for the customer to replace such values with their own. Use the following as a guideline:

### Keys & Placeholders

Key | Markdown Value | Rendered Value  <small>(if different)</small>
-- | -- | --
API Key | `$API_KEY` | `API_KEY`
API Secret | `$API_SECRET` | `API_SECRET`
From Number | `FROM_NUMBER` | -
To Number | `TO_NUMBER` | -
Timestamp | `2020-01-01 12:00:00` | -
ISO8601 Timestamp | `2020-01-01T12:00:00.000Z` | -
Epoch | `1577880000` | -
HTTP Method | ``[GET]`` or ``[POST]`` | [GET] or [POST]
HTTP Response | `` `200 OK` `` or §§ `` `404 Not Found` `` | `200 OK` or §§ `404 Not Found`
Balance | `3.14159` | -
Latency | `3000` | -
UUID | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | -
SNS ARN | `arn:aws:sns:us-east-1:01234567890:example` | -

> *Note*: When there is a `$` proceeding the value can later be used to indicate
> a values that we later will be dynamic. For example `$API_KEY` would become
> the logged in users actual API Key or just `API_KEY` if they are not signed in.

When using a real number is not avoidable for example when listing out the result of `nexmo numbers:list` in the CLI use the following numbers:

### Numbers

#### US Numbers

Human readable format | E.164 format
-- | --
`(415) 555-0100` | `14155550100`
`(415) 555-0101` | `14155550101`
`(415) 555-0102` | `14155550102`
`(415) 555-0103` | `14155550103`
`(415) 555-0104` | `14155550104`
`(415) 555-0105` | `14155550105`

#### GB Numbers

Human readable format | E.164 format
-- | --
`020 7946 0000` | `442079460000`
`020 7946 0001` | `442079460001`
`020 7946 0002` | `442079460002`
`020 7946 0003` | `442079460003`
`020 7946 0004` | `442079460004`
`020 7946 0005` | `442079460005`

#### GB Mobile Numbers

Human readable format | E.164 format
-- | --
`07700 900000` | `447700900000`
`07700 900001` | `447700900001`
`07700 900002` | `447700900002`
`07700 900003` | `447700900003`
`07700 900004` | `447700900004`
`07700 900005` | `447700900005`

### Known incorrect uses

The following is a list of values that should be removed if found.

```
n3xm0rocks
TwoMenWentToMowWentTOMowAMeadowT
12ab34cd
44123456789
```
