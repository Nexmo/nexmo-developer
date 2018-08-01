---
title: Overview
---

# Number Insight Overview

Nexmo's Number Insight API provides details about the validity, reachability and roaming status of a phone number, as well as give you details on how to format the number properly in your application.

There are three levels of Number Insight API available: Basic, Standard and Advanced. The advanced API can be used asynchronously as well as synchronously.

Feature | Basic | Standard | Advanced
--|--|--|--
Retrieve international and local format | ✅ | ✅ | ✅
Country recognition | ✅ | ✅ | ✅
Line type detection (mobile/landline/virtual number/premium/toll-free) | ❎ | ✅ | ✅
Detect mobile country code (MCC) and mobile network code (MNC) | ❎ | ✅ | ✅
Detect if number is ported | ❎ | ✅ | ✅
Identify caller name (USA only) | ❎ | ✅ | ✅
Check if phone number is reachable | ❎ | ❎ | ✅
Identify network when roaming | ❎ | ❎ | ✅
Confirm user's IP address is in same location as their mobile phone | ❎ | ❎ | ✅
Asynchronous API available | ❎ | ❎ | ✅

> You should be careful to check legislation in your country to make sure you can save user information about roaming.

## Concepts

* [Webhooks](/concepts/guides/webhooks) - the Advanced Async API uses webhooks to return more comprehensive data when it becomes available.

## Getting Started

Before you begin:

* Sign up for a [Nexmo account](https://dashboard.nexmo.com/signup)
* Install [Node.JS](https://nodejs.org/en/download/)

> *Note*: If you do not wish to install Node in order to use the [Nexmo CLI](/tools) you can also create applications using the [Application API](/concepts/guides/applications)

Install and Setup the Nexmo CLI (Command Line Interface)

Install the Nexmo CLI:

```bash
$ npm install -g nexmo-cli
```

> *Note*: depending on your system setup you may need to prefix the above command with `sudo`*

Using your Nexmo `API_KEY` and `API_SECRET`, available from the [dashboard getting started page](https://dashboard.nexmo.com/getting-started-guide), you now setup the CLI with these credentials.

```bash
$ nexmo setup API_KEY API_SECRET
```

## Check your number using the Nexmo CLI

```bash
$ nexmo insight:basic 447555555555
```

See [Number Insight Basic](/number-insight/building-blocks/number-insight-basic) Building Block for details on how to use this in detail.
