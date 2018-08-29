---
title: Overview
navigation_weight: 1
description: The Audit API overview.
---

# Audit API Overview

The Nexmo Audit API allows you to track events. These events are activities created by using the API or by interacting with the Nexmo Dashboard. The Audit API allows you to monitor your Nexmo account.

With this API you can:

* Retrieve a list of Audit events.
* Retrieve a specific Audit event.

It is possible to filter the events retrieved based on parameters such as date, user ID, and event type.

## Developer Preview

This API is currently in Developer Preview.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Audit API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

During Developer Preview Nexmo may expand the capabilities of the Audit API.

## Contents

In this document you can learn about:

* [Concepts](#concepts)
* [**How to Get Started with the Audit API**](#getting-started)
* [Guides](#guides)
* [Building Blocks](#building-blocks)
* [Tutorials](#tutorials)
* [Reference](#reference)

## Concepts

### Authentication

Interactions with the Audit API are authenticated using Basic Authentication. Basic Authentication allows you to use your `NEXMO_API_KEY` and `NEXMO_API_SECRET` to validate your API requests. For more information see [authenticating your applications](/concepts/guides/authentication).

### Audit Events

Audit Events are activities that occur when a user interacts with the Nexmo API or the Nexmo Dashboard. Audit events are represented by a JSON object. Examples of audit events include:

* Account settings updates.
* A Nexmo Number gets assigned to an application.
* Creation of a Nexmo application.

Further information on types of audit events is given in the [Audit Event Guide](/audit/guides/audit-events).

### Audit Event object

An example audit event object is 'updating a number' which has `event_type` of `NUMBER_UPDATED`:

``` json
{
  "country":"GB",
  "msisdn":"447700900000",
  "voice-type":"app",
  "voice-value":"aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
}
```

## Getting Started

This example shows you how to get started with the Audit API. It will retrieve a list of audit events:

```building_blocks
source: '_examples/audit/get-events'
application:
  name: 'Get Audit Events'
```

## Guides

* [Audit events](/audit/guides/audit-events): Audit events concepts, including types and structure of audit events.

## Building Blocks

* [Get Audit events](/audit/building-blocks/get-events)
* [Get Audit event](/audit/building-blocks/get-event)
* [Get Audit events with filtering](/audit/building-blocks/get-events-with-filtering)
* [Get Audit event types](/audit/building-blocks/get-event-types)

## Tutorials

* [Tutorials](/audit/tutorials)

## Reference

* [Audit API Reference](/api/audit)
