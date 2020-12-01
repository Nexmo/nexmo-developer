---
title: Make an outbound call
navigation_weight: 7
---

# Make an outbound call

This code snippet makes an outbound call and plays a
text-to-speech message when the call is answered.

## Example

Replace the following variables in the example code:

```snippet_variables
- VONAGE_NUMBER
- TO_NUMBER.VOICE
- ANSWER_URL
```

```code_snippets
source: '_examples/voice/make-an-outbound-call'
application:
  type: voice
  name: 'Outbound Call code snippet'
  answer_url: https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/text-to-speech.json
  disable_ngrok: true
```

## Try it out

When you run the code the `TO_NUMBER` will be called and a text-to-speech message
will be heard if the call is answered.
