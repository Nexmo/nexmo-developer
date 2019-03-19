---
title: Get audit event
navigation_weight: 2
---

# Get audit event

In this Code Snippet you see how to get a single audit event, referenced by its UUID.

## Example

You will need to ensure that the following replaceable values are set in the example code using any convenient method:

Key | Description
-- | --
`NEXMO_API_KEY` | Your Nexmo API key.
`NEXMO_API_SECRET` | Your Nexmo API secret.
`EVENT_UUID` | The UUID of the audit event you want to retrieve.

> In the following example the _Create an application_ and _Initialize your dependencies_ procedures are optional.

```code_snippets
source: '_examples/audit/get-event'
application:
  name: 'Get Event'
```

## Try it out

Run the command in a shell. The call will retrieve the specified audit event.