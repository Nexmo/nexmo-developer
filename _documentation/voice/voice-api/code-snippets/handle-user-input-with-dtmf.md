---
title: Handle user input with DTMF
navigation_weight: 5
---

# Handle user input with DTMF

A code snippet that shows how to handle a user input with DTMF. The
user enters an option on the keypad and the selected option is acknowledged
via a text-to-speech message.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`NEXMO_NUMBER` | Nexmo Number to call.


```code_snippets
source: '_examples/voice/handle-user-input-with-dtmf'
application:
  type: voice
  name: 'User Input DTMF Example'
```

## Try it out

Call your Nexmo Number. When the call is answered you will hear
a menu. Press `1` on the keypad followed by the `#` key. You will then hear
a text-to-speech message acknowledging your selected option.
