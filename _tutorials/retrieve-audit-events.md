---
title: Retrieve audit events
products: audit
description: "You can retrieve filtered lists of audit events. Audit events log activity in a Nexmo account."
languages:
    - Curl
---

# Retrieve audit events

You can retrieve a record of all audit events associated with your Nexmo account. You can also filter this list based on dates, keyword, user and event type.

## In this tutorial

You will see how to retrieve a filtered list of audit events:

- [Prerequisites](#prerequisites)
- [Retrieve a list of audit events](#retrieve-a-list-of-audit-events)
- [Retrieve a filtered list of audit events](#retrieve-a-filtered-list-of-audit-events)
- [Retrieve a specific audit event](#retrieve-a-specific-audit-event)
- [Conclusion](#conclusion)
- [Resources](#resources)

## Prerequisites

In order to work through this tutorial you'll need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up).
* A Terminal application running into which you can type or paste Curl commands. Alternatively you could use Paw, Postman or a similar application.
* You will need to know your `NEXMO_API_KEY` and `NEXMO_API_SECRET` which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com/sign-in).

You can also refer to the [Audit API documentation](/audit/overview).

> **NOTE:** In the examples below, please replace `NEXMO_API_KEY` and `NEXMO_API_SECRET` with actual values obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).

## Retrieve a list of audit events

To receive a list of all audit events enter the following into your terminal:

```bash
$ curl "https://api.nexmo.com/beta/audit/events" \
     -u 'NEXMO_API_KEY:NEXMO_API_SECRET'
```

When you run this command you will receive a list of all audit events.

## Retrieve a filtered list of audit events

The list of audit events you receive in the previous step may well be overwhelming, especially if you have been using your Nexmo account for some time. You can filter this list based on several parameters:

Query Parameter | Description
--- | ---
`event_type` | The type of the audit event, for example: `APP_CREATE`, `NUMBER_ASSIGN`, and so on. You can specify a comma-delimited list of [event types](/audit/concepts/audit-events#audit-event-types) here.
`search_text` | JSON compatible search string. Look for specific text in an audit event.
`date_from` | Retrieve audit events from this date (in ISO-8601 format).
`date_to` | Retrieve audit events to this date (in ISO-8601 format).
`page` | Page number starting with page 1.
`size` | Number of elements per page (between 1 and 100, default 30).


So for example, to filter based on dates you can enter the following command:

```
$ curl "https://api.nexmo.com/beta/audit/events?date_from=2018-08-01&date_to=2018-08-31" \
     -u 'NEXMO_API_KEY:NEXMO_API_SECRET'
```     

This will return all audit events that occurred during August 2018.

You can narrow this down further in various ways. For example you can also filter based on [audit event type](/audit/concepts/audit-events#audit-event-types).

So for example, to find audit events in August of type `NUMBER_ASSIGN` you could enter the following:

```
$  curl "https://api.nexmo.com/beta/audit/events?date_from=2018-08-01&date_to=2018-08-31&event_type=NUMBER_ASSIGN" \
     -u 'NEXMO_API_KEY:NEXMO_API_SECRET'
```

You can further filter based on `search_text`. For example to find all audit events containing the text "password" you can enter the following command:

```
$  curl "https://api.nexmo.com/beta/audit/events?search_text=password" \
     -u 'NEXMO_API_KEY:NEXMO_API_SECRET'
```

## Retrieve a specific audit event

If you know the UUID for a specific audit event you can retrieve the information for just that audit event object. For example if the event UUID is `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` you would enter:

```
$ curl "https://api.nexmo.com/beta/audit/events/aaaaaaaa-bbbb-cccc-dddd-0123456789ab" \
     -u 'NEXMO_API_KEY:NEXMO_API_SECRET'
```

This would then return the audit event object JSON for the specified audit event.

## Conclusion

Using the filtering capabilities of the Audit API you have complete control regarding the audit events that you retrieve.

## Resources

* [Audit API docs](/audit/overview)
* [Audit API Reference](/api/audit)
