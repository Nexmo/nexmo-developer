---
title: Call Flow
navigation_weight: 1
---

# Call Flow

## Overview
Phone calls on the Nexmo Voice API can be initiated in one of 2 ways, Inbound calls are calls made to a Nexmo number from another regular phone anywhere in the world, Outbound calls are calls made from the Nexmo platform to a regular phone number, outbound calls are usually iniated in response to a request made via the REST api to create a new call. Outbund calls may also be made from within the call flow of an existing call (either inbound or outbound) using the `connect` action within the NCCO. This scenario is generally used for forwarding calls.

Both Inbound an Outbound calls once they are answered follow the same flow, this is controlled by an NCCO (Nexmo Call Control Object). The NCCO is a script of actions to be run within the context of the call. Actions are executed in the order they appear in the script with the next action starting when the previous action has reached an end stage. The NCCO is fetched from the answer URL when the call is answered, for Inbound calls the `answerUrl` is set when the applicaiton is created for outbound calls an `answer_url` is supplied in the API request to create the call.

## State

Each call goes through a number of states in its lifecycle, 
Created -> Ringing -> Answered -> Complete

## Events
As the call prpgresses through the various states the Nexmo platform will send event webhooks to your Event URL, like the Answer URl the `eventURL` is associated with the applicaiton for inbound calls or is supplied as an `event_url` when the call is created. Full details of each of these webhooks can be found in the API reference.

|Event Name | Description |
|started    | The call is created on the Nexmo platform|
|ringing    | The destiantion has confirmed that the call is ringing |
|answered   | The destination has answered the call |
|machine    | When machine detection has been requested and the call is answered by a machine|
|human      | When machine detection has been requested and the call is answered by a human|
|timeout    | The call timed out before it was answered|
|failed     | The call attempt failed in the phone network |
|rejected   | The call attempt was rejected by the nexmo platform |
|cancelled  | The call was cancelled by the originator before it was answered |

In addition certain errors are sent to the event URL such as an invalid NCCO

## Fallback NCCO
In certain scenarios you may want to execute an alternative NCCO as a result of the call failing to complete, in these cases you can return a new  NCCO object in response to the event webhook, you need to set te `eventType` as `synchronous` when createing the call and then return a new NCCO to any of the following events:

- `timeout`
- `failed`
- `rejected`
- `unaswered`
- `busy`

## Syncronous vs Asynchronous Actions

Each Action within an NCCO has certain conditions on which it will be considered "complete" and the call will progress to the next action, for some actions this complete state can depend on how they are confiugured.

### Record
A record action will complete when either the `endOnSilence` timer has been reached, the `endOnKey` key is sent,  at this point the recording will be ended and a record event sent before the next action is executed.
If neither value is set then the record will work in an asynchronous mannner and will instantly continue on to the next action while still recording the call, the recording will only then end and send the relevent event when either the `timeout` value is reached or the call is ended.

### Conversation
The conversation action always acts in a syncronous manner where the call is merged into the named conversation (or conferance) The action only ends when the call is ended, therefore no actions in an NCCO after a conversation will be executed.

### Connect
A connect action will progress to the next action in the NCCO when the call is answered. If you have mulitple connect actions in an NCCO it will call each one in turn and when answered create a conferance between the legs.


### Talk
A talk action will complete when the requested text has been read the requested number of times, however if `bargeIn` is set to true AND THE FOLLOWING ACTION IS AN INPUT then the call will progress to accpeting input as soon as the text starts to be played.

### Stream 
A stream action will complete when the requested audio file has been played the requested number of times, however if `bargeIn` is set to true AND THE FOLLOWING ACTION IS AN INPUT then the call will progress to accpeting input as soon as the text starts to be played.

### Input
An input event will complete when one of the required conditions has been met, either the `timeOut` is reached, the `maxDigits` number of digits are entered or a # is sent with `submitOnHash` set. The input action will then send a webhook to the eventURL containing the submitteed digits.
Input is unique in that when the webhook is sent with the entered digits the remote applicaiton can then return a new NCCO to be executed, if no NCCO is returned then the call will contineu to the next item in the NCCO.

## Transferring to new a NCCO

You can replace the currently executing NCCO with a new one by making an HTTP put request to the REST api with the call UUID in it, this will replace whatever actions are being exectued or queued in the current NCCO, one such use case for this is to transfer a call that is on hold (looping an audio file) to an agent by putting a new NCCO with a connect action, however you can also use this to simply modify any aspect of an inprogress call.


## Machine Detection
Machine detection can be configured on either a `connect` action within an NCCO or on a REST API request to create an outbound call, this can be set to one of 2 values, `hangup` or `continue`. If either of these values are set when the call is answered nexmo will attempt to determine if the call was answered by a human being or a machine such as voicemail. This normally takes a few seconds to be determined. At this point Nexmo will send an event to yout event URL with either `Human` or `Machine`

If machine detection was set to `hangup` and nexmo determined that a machine answered the call then the call will be ended.

If set to `continue` then the call will remain connected, you can then modify the call for example to transfer it to a new destination with the PUT feaure described above in 'Transferring to a new NCCO'
