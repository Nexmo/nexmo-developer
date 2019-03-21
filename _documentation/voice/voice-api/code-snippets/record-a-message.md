---
title: Record a message
navigation_weight: 16
---

# Record a message

A code snippet that shows how to record a conversation. Answer an incoming
call and return an NCCO that includes a `record` action. When the call is
complete, a webhook is sent to the `eventUrl` you specify. The webhook includes
the URL of the recording.

## Example

```code_snippets
source: '_examples/voice/record-a-message'
application:
  type: voice
  name: 'Record Message Example'
```

## Try it out

You will need to:

1. Record a message by dialling your Nexmo Number, and leaving your message after the tone (this code snippet).
2. Download the recording. See the [Download a recording](/voice/voice-api/code-snippets/download-a-recording) code snippet for how to do this.
