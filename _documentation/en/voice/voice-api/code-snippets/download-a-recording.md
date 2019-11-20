---
title: Download a recording
navigation_weight: 3
---

# Download a recording

In this code snippet you see how to download a recording.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`RECORDING_URL` |	The URL of the recording to download. You typically get this from the JSON response received on the `/webhooks/recordings` endpoint when the `record` action is used.

```code_snippets
source: '_examples/voice/download-a-recording'
application:
  type: voice
  use_existing: |
    To fetch a recording you must use the same <code>NEXMO_APPLICATION_ID</code>
    and private key for the application that owns the call that you're trying to download.
```

## Try it out

You will need a Recording URL from which to download the recording file. You typically get this from the JSON response received on the `/webhooks/recordings` endpoint when the `record` action is used when [recording a call](/voice/voice-api/code-snippets/record-a-call), connecting another call and so on. A typical JSON response will resemble the following:

```
{'conversation_uuid': 'CON-ddddaaaa-bbbb-cccc-dddd-0123456789de',
 'end_time': '2018-08-10T11:19:31Z',
 'recording_url': 'https://api.nexmo.com/v1/files/aaaaaaaa-bbbb-cccc-dddd-0123456789ab',
 'recording_uuid': 'ccccaaaa-dddd-cccc-dddd-0123456789ab',
 'size': 162558,
 'start_time': '2018-08-10T11:18:51Z',
 'timestamp': '2018-08-10T11:19:31.744Z'}
1.2.3.4 - - [10/Aug/2018 11:19:31] "POST /webhooks/recordings HTTP/1.1" 200 -
```

When you run the script, the recording located at the recording URL will
be downloaded. You can then listen to the recording.
