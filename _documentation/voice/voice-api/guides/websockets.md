---
title: Websockets
navigation_weight: 7
---

# Websockets

## Overview
The Nexmo Voice API allows you to connect to a call via a WebSocket, this means that you will have a real time 2 way stream of the raw audio in the call delivered to you over the HTTP Websocket protocol, this allows you to connect the audio to platforms such as sentiment analisys, real time transcription or artifical intelligence along with many more.

You can also send audio back into the call over this interface.

The Websocket is an endpoint just like another Phone or SIP address, this means it is a participant in your call not a passive monitor like a recording. If you connect a websocket to a confereance call or even just as a 3rd party in a 1-1 call the audio it will recieve will be a mix of all audio in the call, it is not possible to receive a single leg of the conversation via the websocket.

The nexmo Voice API always acts as the HTTP client when establishing the websocket connection, as the applicaiton developer you need to make a compatible server avalivble to accept this connection and del with the audio.

## Message Format

The initial message sent on an established webscoket connection will be text based and contain a JSON payload detailing the audio format along with any other meta data that you have put in the `headers` parameter of the Webscoket endpoint in your NCCO `connect`

For example the following connect action would result in the below message being received:

```
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

You will recieve this JSON in the first message on the socket:
```
 {
     "app": "demo",
     "content-type":"audio/l16;rate=16000"
 }
```

The maximum length of the headers data is 512 bytes.

After the inital text message all subsequent messages on the socket will be Binary containing the audio payload as specified beliw
## Audio Payload

The only audio codec presently supported on the Websocket interface is Linear PCM 16bit, with a16Khz sample rate, and a  20ms Frame Size.

This means that each message will be a 20ms sample of the audio from the call, this will contain 320 samples of 16bits each, giving a fixed message size of 640 bytes.

## Writing Audio to the socket
You can send audio back into the call by writing binary messages to the socket, the audio must be in the same format as above, it is important that each message is 640bytes and contains 20ms of audio. You can send the messages at a faster than realtime rate and they will be buffered for play out at the nexmo end. So for example you can write a whole file to the socket in one go (so long as the 640byte per message is observed)