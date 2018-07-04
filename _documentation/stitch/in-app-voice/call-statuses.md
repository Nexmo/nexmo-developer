---
title: Call Statuses
---

# Call Statuses 

This guide explains call statuses like started, ringing, answered, rejected, busy, unanswered, timeout, failed, complete, machine. Since everyone is familiar with the phone, these concepts are pretty straightforward. 
 
Both inbound and outbound calls follow the same call flow once answered. This call flow is controlled by an NCCO. An NCCO is a script of actions to be run within the context of the call. Actions are executed in the order they appear in the script, with the next action starting when the previous action has finished executing. For more information about NCCOs, see the [NCCO reference](/voice/voice-api/ncco-reference).

## Lifecycle

Each call goes through a sequence of statuses in its lifecycle:

A call may pass from Created to Ringing to Answered to Complete but there are many different sets of sequences for statuses in a call's lifecycle. Below is a schematic diagram outlining a few sets. 

![Visual diagram of Call statuses. A description of the text is given in the next section.](/assets/images/call-statuses-rtc-diagram.png)

## Statuses

Here is list of of all ten call statuses: 

- **started** : The call is created on the Nexmo platform
- **ringing** : The destination has confirmed that the call is ringing
- **answered** : The destination has answered the call
- **rejected** : The call attempt was rejected by the destination
- **busy**: The destination is on the line with another caller
- **unanswered**: The call was canceled by the caller
- **timeout**: The call timed out before it was answered
- **failed**: The call failed before reaching the destination
- **complete**: The call is completed successfully
- **macine**: The call is answered by a machine

These statuses are valid for all 1:1 call combinations such as (IP to IP, IP to PSTN, PSTN to IP). 

## Disclaimer 

While Nexmo, the Vonage API Platform strives to provide the best possible access how so ever it may be, we have little to no control over assuring the accuracy of the changes in state, most of which depend in the largest part upon the carriers themselves, mostly separate legal entities with whom we share a business interest. More specifically, a state change may indeed be busy but is relayed as rejected. 
