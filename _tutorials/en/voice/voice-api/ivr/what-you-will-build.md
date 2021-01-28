---
title: What you will build
description: The capabilities your application must expose to handle and route an incoming call
---

# What you will build

To create the call menu, you need to build a server that exposes three endpoints:

1. One to answer the call
2. One to accept call event data
3. One to process user input via the telephone keypad

## Answering the call

When the Vonage API platform receives a call on your virtual number it will make a HTTP request to the [webhook](/concepts/guides/webhooks) URL that you will configure as part of your Voice Application. This is known as the "answer URL". The request contains all of the information you need to receive and respond to the call. 

## Receiving event data

Vonage sends event data to another webhook known as the "event URL". This contains valuable information about the progress of the call. In this straightforward example, we will output the event data to the console.

## Processing user input

When a user presses a number on their keypad, you can collect it via [DTMF (Dual Tone Multi Frequency)](/voice/voice-api/guides/dtmf). You must create another webhook to receive this input.