---
title: Recording
navigation_weight: 4
---

# Recording audio

## Overview

The Nexmo Voice API offers the ability to record call audio in several ways. You can:

1. Record a call between two people in a passive 'monitor' manner.
2. Record audio from a single caller when they are prompted. For example, in a voicemail system.
3. Enable recording for a named conversation ([using the conference action](/voice/voice-api/ncco-reference#conversation)).

By default all recordings are in a mono format, with all legs of the conversation in a single channel.

Nexmo also offers a [split recording](#split-recording) feature where the audio will be saved as a stereo file. In this case the audio spoken by the initial caller will be in the left channel, and audio heard by the initial caller will be in the right channel. This is often useful for passing to transcription systems where you wish to identify who said what.

To record a conversation you can use the `record` action in an NCCO. The recording will behave differently depending on how you configure the action. For more information on how to configure a recording, see the [record NCCO reference](/voice/voice-api/ncco-reference#record)

Once the `record` action ends, Nexmo will send a webhook to the `event_url` that you specified when configuring the `record` action. This webhook contains a URL where the recording file can be downloaded from. You will need to authenticate with a JWT signed by the same applicaton key that created the recording in order to download the recording file.

> NOTE: After your recording is complete, it is stored by Nexmo for 30 days before being automatically deleted

## Synchronous recording

A `record` action will complete when either the `endOnSilence` timer has been reached, or the `endOnKey` key is sent. At this point the recording will be ended and a record event will be sent to your `event_url` before the next action is executed. This is used for scenarios similar to voicemail.

## Asynchronous recording

If `endOnSilence` or `endOnKey` is not set, then the record will work in an asynchronous mannner and will instantly continue on to the next action while still recording the call. The recording will only end and send the relevant event when either the `timeout` value is reached, or the call is ended. This is used for scenarios similar to call monitoring.

When recording a named conversation, the recording is always asynchronous and tied to the lifecycle of the conference. To record a conference, you must add set the `record` attribute to `true` in your `conversation` action in the NCCO.

## Split recording

When recording a call, you can enable split recording which will result in the recording being a stereo file with one channel having the audio sent from the caller and another channel being the audio heard by the caller.

## File formats

* Nexmo supports recording in MP3 or WAV format, the default is MP3.
* MP3 files are recorded with a 16-bit depth and a 16kHz sample rate. They are encoded with a constant bit rate of 32Kbps.
* WAV files are recorded with a 16-bit depth and a 16kHz sample rate.

Both formats are mono by default. If split recording is enabled, a stereo file with each channel using the previously mentioned bit-depth and sampling rates is created.

