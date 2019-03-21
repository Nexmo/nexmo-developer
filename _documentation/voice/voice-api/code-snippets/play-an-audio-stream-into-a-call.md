---
title: Play an audio stream into a call
navigation_weight: 9
---

# Play an audio stream into a call

This code snippet plays an audio stream into the specified call.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`UUID` | the UUID of the call into which to play an audio stream.
`URL` | The URL of the audio file that will be streamed into an array. The URL must be in an array.

```code_snippets
source: '_examples/voice/play-an-audio-stream-into-a-call'
application:
  type: voice
  use_existing: |
    Modifying an existing call requires that the <code>UUID</code> provided is a currently active call. To modify a call, you must use the same <code>NEXMO_APPLICATION_ID</code> and private key that were used to create the call.
```

## Try it out

When you run the code an audio stream from the file specified is played
into the call identified with the specified UUID.
