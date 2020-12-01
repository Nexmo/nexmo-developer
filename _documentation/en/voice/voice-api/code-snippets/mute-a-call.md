---
title: Mute a call
navigation_weight: 8
---

# Mute a call

This code snippet mutes / unmutes a call.

## Example

Replace the following variables in the example code:

```snippet_variables
- UUID.VOICE
```

```code_snippets
source: '_examples/voice/mute-a-call'
application:
  type: voice
  use_existing: |
    Modifying an existing call requires that the <code>UUID</code> provided is a currently active call. To modify a call, you must use the same <code>VONAGE_APPLICATION_ID</code> and private key that were used to create the call.
```

## Try it out

When you run the code the call is muted or unmuted depending on the action specified.
