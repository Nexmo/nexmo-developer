---
title: Configure your ICE server URL
description: This topic shows you how to configure your ICE server URL.
navigation_weight: 2
---

# Configure ICE server URLs

It is possible to optionally configure your specific Interactive Connectivity Establishment (ICE) servers.

STUN and TURN servers are needed for WebRTC to work because of potential network connectivity issues due to NAT and firewalls. A STUN server is used to get an external network address. TURN servers are used to relay traffic if a direct (peer to peer) connection fails.

You are able to configure your own STUN or TURN server if required. The default is `stun:stun.l.google.com:19302`.

## Configuration

You can specify your STUN or TURN server URL when you create the Client SDK `NexmoClient` object:

```tabbed_content
source: '/_examples/client-sdk/ice-server'
```
