---
title: Play text-to-speech into a call
navigation_weight: 11
---

# Play text-to-speech into a call

This code snippet plays a text-to-speech message into the specified call.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`UUID` | the UUID of the call into which to play the text-to-speech message.
`Text` | text of the message to play into the call.


```code_snippets
source: '_examples/voice/play-tts-into-a-call'
application:
  type: voice
  use_existing: |
    Modifying an existing call requires that the <code>UUID</code> provided is a currently active call. To modify a call, you must use the same <code>NEXMO_APPLICATION_ID</code> and private key that were used to create the call.
```

## Try it out

When you run the code a text-to-speech message is played
into the call identified with the specified UUID.
