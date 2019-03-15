---
title: Endpoints
description: When connecting a call, you can connect to another phone number, a `sip` endpoint or a `websocket`. These are known as endpoints.
navigation_weight: 5
---

# Endpoints

## Overview

Endpoints are a term used with the Nexmo Voice API to describe the different destinations a call could be connected to. Each endpoint type has its own addressing format and other related metadata that can be sent along with the call. The most common type of endpoint used is `phone`, which is for making phone calls to regular phone numbers anywhere in the world. This network of phones is known as the Public Switched Telephone Network (PSTN).

## Phone

The `phone` endpoint takes a required value of `number` which is the number to be called in E.164 format. E.164 format is the full international format without any leading zeros or + signs, for example `447700900123` for the UK or `14155550100` for the US.

You can also send an optional `dtmfAnswer` parameter which is a string of digits 0-9 along with `*`, `#` and `p` characters that would be sent via DTMF when the call is answered. Each pause (`p`) is 500ms.

## Session Initiation Protocol (SIP)

SIP is used to connect a call to your own SIP system such as an office PBX or other telephony service using the standards laid down in [RFC3261](https://tools.ietf.org/html/rfc3261).

The `uri` should be constructed as a SIP URL in the format `sip:user@example.com` by default Nexmo will connect to port 5060 unless another port is specified in the URI. You can specify TLS for the SIP transport by adding `;transport=tls` to the end of your URI.

Media will be sent via UDP on a port in the range 10000-20000.

For more information on the IP addresses used for SIP traffic originating from Nexmo see [What IP addresses should I whitelist in order to receive voice traffic from Nexmo?](https://help.nexmo.com/hc/en-us/articles/115004859247-What-IP-addresses-should-I-whitelist-in-order-to-receive-voice-traffic-from-Nexmo-)

## Websockets

Nexmo offers the ablity to connect a call to a WebSocket endpoint where the audio of the call is sent and received in real-time over a long-lived HTTP connection.

With websockets Nexmo acts as the HTTP client and makes an HTTP request to your web server which should then upgrade that connection to a websocket.

The endpoint is addressed via a `uri` parameter which should be a standard websocket URL, starting with either `ws://` for plain HTTP or `wss://` for TLS enabled servers. The `Content-Type` parameter can be set to `audio/l16;rate=16000` or `audio/l16;rate=8000`, depending on if you need the data at 16kHz or 8kHz. Most realtime transcription services work best with audio at 8kHz.

An optional `headers` parameter can be passed containing a JSON object of key value pairs that you want to send.  The maximum size of this headers parameter is 512 bytes.

## CallerID

For both `phone` and `sip` endpoint types, the `from` field *must* be a Nexmo Number associated with your account in e.164 format. This will then be used as the caller ID on the receiving phone. For SIP endpoints it will take the format `number@sip.nexmo.com`.

## Vonage Business Cloud

The `vbc` endpoint enables you to connect an inbound call on a Vonage Business Cloud (VBC) programmable number to the VBC extension you specify in the `extension` property of the endpoint.
