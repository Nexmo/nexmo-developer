---
title: Recording
navigation_weight: 4
---

# Recording Audio

## Overview

The Nexmo Voice API offers the ability to record call audio with several different setups, you can record a call that is connected between 2 people in a passive 'monitor' type of way or you can use record to capture audio from a single caller when the are prompted for example in a voicemail system. You can also enable recording directing within a named conversation (conferance).

By default all recordings are in a mono format with all parts of the call mixed together into a single channel, however nexmo also offers a split recording feature within NCCO's where the audio will be saved as a stero file and the audio sent from and heard by the callers being in separate left and right channels, this is often useful for passing to transcription systems where you wish to identify who said what.

You would initiate the recording using the `record` action of an NCCO but the behaviour will differ depending on how you configure the action.

Once the recording has been completed your application will be sent a webhook to the event URL that you speficfied when configuring the recording, this webhook contains a URL where the recording file can be downloaded from. Note you will need to authenticate with a JWT signed by the same applicaton key that created the recording in order to download the audio file.

## Syncronous and Asyncronous Modes

A record action will complete when either the `endOnSilence` timer has been reached, the `endOnKey` key is sent, at this point the recording will be ended and a record event sent before the next action is executed. This is used for the Voicemail style of scenario

If neither value is set then the record will work in an asynchronous mannner and will instantly continue on to the next action while still recording the call, the recording will only then end and send the relevent event when either the `timeout` value is reached or the call is ended. This is used for the call monitoring style of scenario.

When recording a named conversation the recording is always asyncronous and tied to the lifecycle of the conference.

## Split Recordings

when recording a call, you can enable split recording which will result in the recording being a stereo file with one channel having the audio sent from the caller and another channel being the audio heard by the caller. This only applies when recording a call between two people.

## File Formats

Nexmo supports recording in MP3 or WAV format, the defualt is MP3.
MP3 files are recorded with a 16bit depth and a 16Khz Sample Rate, they are encoded with a constant bit rate of 32Kbps
WAV files are recording with a 16bit depth and a 16Khz Sample Rate.
Both formats are Mono by default unless split recording is enabled in which case you will get a stereo file with each channel using the above values.
