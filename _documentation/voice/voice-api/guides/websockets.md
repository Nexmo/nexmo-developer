---
title: Websockets
navigation_weight: 7
---

# Websockets

## Overview

The Nexmo Voice API allows you to connect to a call via a WebSocket. This means that you will have a real-time two-way stream of the raw audio in the call delivered to you over the HTTP WebSocket protocol. This allows you to connect the audio to platforms such as sentiment analysis, real-time transcription systems, and artificial intelligence.

You can also send audio back into the call over this interface.

The WebSocket is an endpoint in the same what that a phone or SIP address is. This means it is a participant in your call and not a passive monitor like a recording. If you connect a WebSocket to a conference call, or a third-party in a 1-1 call, the audio it receives is a mix of all the audio in the call. It is not possible to receive a single leg of the conversation via the WebSocket.

The Nexmo Voice API always acts as the HTTP client when establishing the WebSocket connection. As the application developer you need to make a compatible server available to accept this connection and deal with the audio.

## Message Format

The initial message sent on an established WebSocket connection will be text-based and contain a JSON payload detailing the audio format, along with any other metadata that you have put in the `headers` parameter of the WebSocket endpoint in your NCCO `connect`.

For example, consider the following `connect` action:

``` json
[
    {
       "action": "connect",
       "endpoint": [
           {
              "type": "websocket",
              "uri": "wss://example.com/socket",
              "content-type": "audio/l16;rate=16000", 
              "headers": {
                 "app": "demo"
              }
           }
       ]
     }
]
```

This results in the following JSON in the first message on the
WebSocket:

``` json
{
     "app": "demo",
     "content-type":"audio/l16;rate=16000"
}
```

The maximum length of the `headers` data is 512 bytes.

After the initial text message all subsequent messages on the WebSocket will be binary, containing the audio payload as specified in the following sections.

## Audio payload

The audio codec presently supported on the WebSocket interface is Linear PCM 16-bit, with either a 8kHz or a 16kHz sample rate, and a 20ms frame size.

To choose the sampling rate set the `Content-Type` parameter to `audio/l16;rate=16000` or `audio/l16;rate=8000` depending on if you need the data at 16kHz or 8kHz. Most realtime transcription services work best with audio at 8kHz.

Each message will be a 20ms sample of the audio from the call, containing 320 samples. If you choose the 8kHz rate each message will be 320 bytes large. Choosing the 16kHz rate will result in each message being 640 bytes large.

## Writing audio to the WebSocket

You can send audio back into the call by writing binary messages to the WebSocket. The audio must be in the same format as described in the previous section. It is important that each message is 640 bytes and contains 20ms of audio. You can send the messages at a faster than real-time rate and they will be buffered for playing at the Nexmo end. So for example, you can send an entire file to the socket in one write, providing the 640 byte per message restriction is observed.
