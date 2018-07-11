---
title: Download a recording
navigation_weight: 3
---

# Download a recording

In this building block you see how to download a recording.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`RECORDING_URL` |	The URL of the recording to download.

```building_blocks
source: '_examples/voice/download-a-recording'
application:
  use_existing: |
    To fetch a recording you must use the same <code>NEXMO_APPLICATION_ID</code>
    and private key for the application that owns the call that you're trying to download.
```

## Try it out

When you run the script, the recording located at the recording URL will
be downloaded. You can then listen to the recording.
