---
title: Make an outbound call
navigation_weight: 7
---

# Make an outbound call

This code snippet makes an outbound call and plays a
text-to-speech message when the call is answered.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`NEXMO_NUMBER` |	Your Nexmo number that the call will be made from. For example `447700900000`.
`TO_NUMBER` |	The number you would like to call to in E.164 format. For example `447700900001`.
`ANSWER_URL` | The answer URL. For example `https://developer.nexmo.com/ncco/tts.json`.

```code_snippets
source: '_examples/voice/make-an-outbound-call'
application:
  type: voice
  name: 'Outbound Call code snippet'
  answer_url: https://developer.nexmo.com/ncco/tts.json
  disable_ngrok: true
```

## Try it out

When you run the code the `TO_NUMBER` will be called and a text-to-speech message
will be heard if the call is answered.
