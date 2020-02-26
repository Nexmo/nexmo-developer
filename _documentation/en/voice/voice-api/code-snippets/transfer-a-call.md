---
title: Transfer a call
navigation_weight: 19
---

# Transfer a call

A code snippet that shows how to transfer control of the current call
to control by a new NCCO.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`UUID` | The UUID of the call to modify.
`action` | The action to use in updating the call. In this case `transfer`.
`NCCO_URL` | The URL of the NCCO to transfer control to. URLs _must_ be array type.


```code_snippets
source: '_examples/voice/transfer-a-call'
application:
  type: voice
  use_existing: |
    Modifying an existing call requires that the <code>UUID</code> provided is a currently active call. To modify a call, you must use the same <code>NEXMO_APPLICATION_ID</code> and private key that were used to create the call.
```

## Try it out

You will need to:

1. Set up a call and obtain the call UUID. You could use the 'connect an inbound call' code snippet to do this.
2. Run the example code to transfer the call.
3. Control will be transferred to a new NCCO, and you will hear a text-to-speech message to confirm this.
