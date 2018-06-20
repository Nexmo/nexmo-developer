---
title: Record a call
navigation_weight: 14
---

# Record a call

A building block that shows how to record a call. The call
to be recorded is identified via a UUID.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`NEXMO_NUMBER` | The Nexmo Number of the application (the FROM number).
`TO_NUMBER` | The number to connect the call to.


```building_blocks
source: '_examples/voice/record-a-call'
application:
  name: 'Record Call Example'
```

## Try it out

You will need to:

1. Set up a call and obtain the call UUID. You could use the 'connect an inbound call' building block to do this.
2. Record the call (this building block).
3. Download the recording. See the 'Download a recording' building block for how to do this.
