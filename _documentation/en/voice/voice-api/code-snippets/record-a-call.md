---
title: Record a call
navigation_weight: 14
---

# Record a call

A code snippets that shows how to answer an incoming call and set it up to
record, then connect the call. When the call is completed, the `eventUrl`
you specify in the `record` action of the NCCO will receive a webhook
including the URL of the recording for download.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`NEXMO_NUMBER` | The Nexmo Number of the application (the FROM number).
`TO_NUMBER` | The number to connect the call to.


```code_snippets
source: '_examples/voice/record-a-call'
application:
  type: voice
  name: 'Record Call Example'
```

## Try it out

You will need to:

1. Answer and record the call (this code snippet).
2. Download the recording. See the [Download a recording](/voice/voice-api/code-snippets/download-a-recording) code snippet for how to do this.
