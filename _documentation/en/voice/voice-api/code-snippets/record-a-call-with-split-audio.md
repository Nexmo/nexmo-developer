---
title: Record a call with split audio
navigation_weight: 13
---

# Record a call with split audio

A code snippet that shows how to answer an incoming call and set it up to
record the conversation legs separately, then connect the call. When the call
is completed, the `eventUrl` you specify in the `record` action of the NCCO
will receive a webhook including the URL of the recording for download.

## Example

Replace the following variables in the example code:

```snippet_variables
- VONAGE_NUMBER
- TO_NUMBER.VOICE
```

```code_snippets
source: '_examples/voice/record-a-call-with-split-audio'
application:
  type: voice
  name: 'Record Call Split Audio Example'
```

## Try it out

You will need to:

1. Answer and record the call with split audio (this code snippet).
2. Download the recording. See the [Download a recording](/voice/voice-api/code-snippets/download-a-recording) code snippet for how to do this.
