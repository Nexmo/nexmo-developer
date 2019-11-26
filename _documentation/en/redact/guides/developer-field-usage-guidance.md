---
title: Developer Field Usage Guidance
---

# Developer Field Usage Guidance

Developers using the Nexmo API may have privacy compliance requirements. Typically, developers send personal data to Nexmo when using the communication services, e.g. to send an SMS, an end user's phone number is provided, as well as a message body which could include further personal data.

Nexmo offers the [Redact API](/redact/overview) to assist developers to comply with their privacy obligations, which can be used to redact personal data from communications records.

However, it may be possible to inadvertently introduce personal data into the Nexmo platform in other ways. This page lists guidance for fields which should not be populated with end user personal data.

The fields detailed in the following sections should be carefully populated to ensure that personal data is not inadvertently placed in them. They are not intended to accept personal data and it is not possible to redact these fields, as the platform requires this data for normal operation after the communications operation has been completed.

## Messaging

### SMS API

* `callback`
* `clientRef`
* `url`

### 2FA API

* `clientRef`

## Voice API

* `from` (for an outbound call, should be owned by customer/developer)
* `to` (for an inbound call, should be owned by customer/developer)

### NCCO

Note that the NCCO provided by the customer server to the Voice API may contain many customer-defined strings; additionally, the NCCO may be created programmatically. These fields in particular should be checked to ensure no personal data is inadvertently populated (generally any numbers in these fields should be owned by the customer/developer, not an end user):

* `eventUrl`
* `endpoint.uri`
* `from`
* `text` (note that the NCCO is logged for diagnostic purposes, and retained for approximately 30 days)
* `streamUrl`

## Application API

* `name`
* `answer_url`
* `event_url`

## Verify API

* `brand`
* `sender_id`

## Conversation API

Conversation resources can be fully controlled by customers using the related APIs. If any end user personal data is deliberately placed in a Conversation resource such as a user or message, the resource's PUT or DELETE methods may be used to remove this data later.
