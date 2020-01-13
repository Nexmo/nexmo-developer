---
title: Overview
meta_title: Audit your account by monitoring events as they happen
navigation_weight: 1
description: The Audit API overview.
---

# Audit API Overview

Nick's fix.

The Nexmo Audit API enables you to monitor your account by tracking events. These events are generated when your account users work with the SDKs or interact with the Nexmo Dashboard.

With this API you can:

* Retrieve a specific Audit event.
* Filter events by parameters such as date, user ID, and event type.

## Beta

This API is currently in Beta.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Audit API in the subject line. Please note that during the Beta period support times are limited to Monday to Friday.

During the Beta period Nexmo may expand the capabilities of the Audit API.

## Contents

In this document you can learn about:

* [Authentication](#authentication)
* [Audit Events](#audit-events)
* [Audit Event Object](#audit-event-object)
* [**How to Get Started with the Audit API**](#getting-started)
* [Concepts](#concepts)
* [Code Snippets](#code-snippets)
* [Use Cases](#use-cases)
* [Reference](#reference)

## Authentication

Interactions with the Audit API are authenticated using Basic Authentication. Basic Authentication allows you to use your `NEXMO_API_KEY` and `NEXMO_API_SECRET` to validate your API requests. For more general information on authentication see [Authentication](/concepts/guides/authentication).

## Audit Events

Audit Events are activities that occur when a user interacts with the Nexmo API or the Nexmo Dashboard. Audit events are represented by a JSON object. Examples of audit events include:

* Account settings updates.
* A Nexmo Number gets assigned to an application.
* Creation of a Nexmo application.

Further information on types of audit events is given on the [Audit Events](/audit/concepts/audit-events) page.

## Audit Event object

An example audit event object is 'updating a number' which has `event_type` of `NUMBER_UPDATED`:

``` json
{
  "_links": {
    "self": {
      "href": "http://api.nexmo.com/beta/audit/events/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
    }
  },
  "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "event_type": "NUMBER_UPDATED",
  "event_type_description": "Number updated",
  "created_at": "2018-08-13T10:15:31",
  "account_id": "abcd1234",
  "source": "DEVAPI",
  "source_ip": "154.59.142.233",
  "source_description": "Developer API",
  "source_country": "GB",
  "context": {
    "country": "GB",
    "msisdn": "447700900000",
    "voice-type": "sip",
    "voice-value": "sip:user@example12.com",
    "accountId": "abcd1234"
  }
}
```

## Getting Started

This example shows you how to get started with the Audit API. It demonstrates how to retrieve a list of audit events.

You will need to ensure that the following replaceable values are set in the example code using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | Your Nexmo API key.
`NEXMO_API_SECRET` | Your Nexmo API secret.

> In the following example the _Create an application_ and _Initialize your dependencies_ procedures are optional.

```code_snippets
source: '_examples/audit/get-events'
application:
  name: 'Get Audit Events'
```

## Concepts

```concept_list
product: audit
```

## Code Snippets

```code_snippet_list
product: audit
```

## Use Cases

```use_cases
product: audit
```

There is also a blog post on how to [monitor your applications with the Audit API with Python](https://www.nexmo.com/blog/2018/10/09/get-nexmo-audit-events-with-python-dr/) you might find useful.

## Reference

* [Audit API Reference](/api/audit)
