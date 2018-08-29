---
title: Get audit event
navigation_weight: 2
---

# Get audit event

In this building block you see how to get a single audit event, referenced by its UUID.

## Example

Ensure that the following variables are set using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | Your Nexmo API key.
`NEXMO_API_SECRET` | Your Nexmo API secret.
`EVENT_UUID` | The UUID of the audit event you want to retrieve.


```building_blocks
source: '_examples/audit/get-event'
application:
  name: 'Get Event'
```

## Try it out

Run the command in a shell. The call will retrieve the specified audit event.