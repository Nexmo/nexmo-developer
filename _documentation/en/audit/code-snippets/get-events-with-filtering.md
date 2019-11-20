---
title: Get audit events with filtering
navigation_weight: 3
---

# Get audit events with filtering

In this code snippet you see how to get a list of audit events with filtering.

## Parameters

You can filter the list of event objects returned by using query parameters. The parameters that can be specified are shown in the following table:

Query Parameter | Description
--- | ---
`event_type` | The type of the audit event, for example: `APP_CREATE`, `NUMBER_ASSIGN`, and so on. You can specify a comma-delimited list of [event types](/audit/concepts/audit-events#audit-event-types) here.
`search_text` | JSON compatible search string. Look for specific text in an audit event.
`date_from` | Retrieve audit events from this date (in ISO-8601 format).
`date_to` | Retrieve audit events to this date (in ISO-8601 format).
`page` | Page number starting with page 1.
`size` | Number of elements per page (between 1 and 100, default 30).

## Example

You will need to ensure that the following replaceable values are set in the example code using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | Your Nexmo API key.
`NEXMO_API_SECRET` | Your Nexmo API secret.
`SEARCH_TEXT` | Some JSON compatible text to search for. For example, "number".
`DATE_FROM` | Audit events starting from this ISO-8601 datetime value. For example, "2018-07-01".
`DATE_TO` | Audit events up to this ISO-8601 datetime value. For example, "2018-08-01".

> In the following example the _Create an application_ and _Initialize your dependencies_ procedures are optional.

```code_snippets
source: '_examples/audit/get-events-with-filtering'
application:
  name: 'Get Events with filtering'
```

## Try it out

Run the command in a shell. The call will retrieve a filtered list of audit events.
