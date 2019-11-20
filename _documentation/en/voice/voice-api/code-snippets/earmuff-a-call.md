---
title: Earmuff a call
navigation_weight: 4
---

# Earmuff a call

This code snippet earmuffs and unearmuffs a call. When a call is earmuffed, the user cannot hear other participants, but other participants can hear the user.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`UUID` | The UUID of the call you want to update.

```code_snippets
source: '_examples/voice/earmuff-a-call'
application:
  type: voice
  use_existing: |
    Modifying an existing call requires that the <code>UUID</code> provided is a currently active call. To modify a call, you must use the same <code>NEXMO_APPLICATION_ID</code> and private key that were used to create the call.
```

## Try it out

When you run the code the call identified by UUID will be earmuffed or unearmuffed.
