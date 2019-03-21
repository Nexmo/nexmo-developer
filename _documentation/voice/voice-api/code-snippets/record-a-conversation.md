---
title: Record a conversation
navigation_weight: 15
---

# Record a conversation

A code snippet that shows how to record a conversation. Answer an incoming
call and return an NCCO that joins the caller to a named conversation. By
setting `record` to true, the conversation is recorded and when the call is
complete, a webhook is sent to the `eventUrl` you specify. The webhook includes
the URL of the recording.

## Example

```code_snippets
source: '_examples/voice/record-a-conversation'
application:
  type: voice
  name: 'Record Conversation Example'
```

## Try it out

You will need to:

1. Record a conversation by dialling your Nexmo Number (this code snippet).
2. Download the recording. See the [Download a recording](/voice/voice-api/code-snippets/download-a-recording) code snippet for how to do this.
