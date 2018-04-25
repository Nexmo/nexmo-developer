---
title: DTMF
navigation_weight: 6
---

# DTMF Tones

## Overview

DTMF stands for Dual Tone Multi Frequency, it is a form of signalling used by phone systems to transmit the digits 0-9 and the * and # characters, typically a caller presses these buttons on their telephone keypad and the phone then generates a tone made up of 2 frequnceis played simultaneously (hence Dual Tone)

DTMF is used both for dialing a destination on a landline telephone and also for signalling to the remote end once a call is answered, typically this is used to select options from a menu (known as an IVR) or to enter information like a PIN number or conferance number.
 The Nexmo Voice API supports both collecting information from callers using the `input` action in an NCCO as well as sending DTMF tones within a call.
 
## Collecting Input

You can collect input from your caller on either an inbound or outbound call by using the `input` action within your NCCO, you need to set certain parameters so that nexmo knows when to return the data to you via webhook, so specifying either how many digits you expect, a timeout value or asking the user to press # when completed.
The input action will then send a new webhook to your event url and you can return an new NCCO to be executed.

## Sending DTMF 
There are 2 ways to send DTMF tones to a call;

For an outbound call made either via the REST API create call or via a connect action you can set the `dtmfAnswer` param within the phone endpoint, this means that when the call is answered nexmo will automatically send the defined string of tones.

You can also asend DTMF digits to a call at any time buy paing a PUT request to the REST API and specifying a string of `digits`

You can use digits `0-9` `*` and `#` a `p` indicates a pause of 500ms if you need to add a delay in sendingg the digits


## Troubleshooting

DTMF can be sent across diigtal phone networks in several ways, known as Inband and Out of Band, with Inband the tones are played in the audio channel of the call and will be heard by the parties on the call, with out of Band signalling the tones are sent in a separate signalling channel and may not be heard by a caller listening on the other end.
This means that if you are testing sending DTMF by calling your own phone you may not hear the tones in your earpeice.

DTMF can also have specific local carrier problems, if you expereince difficulties in using DTMF please contact support@nexmo.com with details who will be able to investigate.
