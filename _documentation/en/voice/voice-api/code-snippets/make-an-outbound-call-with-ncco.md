---
title: Make an outbound call with an NCCO
navigation_weight: 1
---

# Make an outbound call with an NCCO

This code snippet makes an outbound call and plays a
text-to-speech message when the call is answered. You don't need to run a
server hosting an `answer_url` to run this code snippet, as you provide your
NCCO as part of the request

## Example

Replace the following variables in the example code:

```snippet_variables
- VONAGE_NUMBER
- TO_NUMBER.VOICE
```

```code_snippets
source: '_examples/voice/make-an-outbound-call-with-ncco'
application:
  type: voice
  name: 'Outbound Call with NCCO code snippet'
  disable_ngrok: true
```

## Try it out

When you run the code the `TO_NUMBER` will be called and a text-to-speech message
will be heard if the call is answered.
