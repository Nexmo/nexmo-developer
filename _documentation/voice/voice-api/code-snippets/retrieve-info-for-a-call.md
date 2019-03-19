---
title: Retrieve information for a call
navigation_weight: 17
---

# Retrieve information for a call

A Code Snippet that shows how to retrieve information for a call. The call
to retrieve information for is identified via a UUID.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`UUID` | The UUID for the call for which information is being requested.


```code_snippets
source: '_examples/voice/retrieve-info-for-a-call'
application:
  type: voice
  use_existing: |
    To fetch information about a call, you must use the same <code>NEXMO_APPLICATION_ID</code> and private key that were used to create the call.
```

## Try it out

You will need to:

1. Set up a call and obtain the call UUID. You could use the 'connect an inbound call' Code Snippet to do this.
2. Retrieve information for the call (this Code Snippet).
