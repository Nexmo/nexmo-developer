---
title: Programmable SIP
---

# Programmable SIP

## Overview

Nexmo’s Programmable SIP product enables you to integrate your existing SIP Infrastructure with Nexmo’s powerful conversational communications platform. This integration will enable you easily connect to mobile, landline, SIP and WebRTC endpoints including browsers and mobile applications. It will also bring Voice API functionality such as multichannel recording, IVR, Text to Speech, web socket connectivity for AI integrations and the power of contextual conversations to your platform.

> **NOTE:** Programmable SIP is currently in Developer Preview.

## Nexmo SIP Domains

A _Nexmo SIP Domain_ contains configuration you need to connect to Nexmo SIP endpoints to link to your Nexmo application.

To route a SIP call to your Nexmo application, you need to create a unique Nexmo domain, such as `yourcompany`. The domain name will form the SIP URI, for example `sip:number@yourcompany.sip.nexmo.com`, and any calls routed to that SIP URI will be routed to your application NCCO `answer_url`.

The authentication method will be determined within your configuration of the Nexmo domain. Nexmo will authenticate the request and forward it to your application.

Some example domains:

``` text
yourcompany.sip-eu.nexmo.com
alice@yourcompany.sip-us.nexmo.com
12345@yourcompany.sip-ap.nexmo.com
```

## Authentication - Access Control Lists

IP addresses of your devices and endpoints can be configured to reach your Nexmo application. Nexmo will only accept calls from the IP address list that is configured for your domain. This method will enable you to whitelist your endpoints’ and devices’ IP Addresses per your application.

## Domain Based Routing

If you require your call to be handled by a specific Nexmo region, then you can specify that by using R-URI with such information in the domain part.

The following code will indicate to Nexmo that you want this SIP call to be handled in the EU:

``` text
sip:number@yourcompany.sip-eu.nexmo.com
```

Available domains are the same as the A records:

``` text
sip-us.nexmo.com: US
sip-eu.nexmo.com: EU
sip-ap.nexmo.com: AP
```

## Custom SIP Headers

You can specify any additional headers you need when sending a SIP Request. Any headers provided must start with `X-` and will be sent to your `answer_url` with a prefix of `SipHeader_`. For example, if you add a header of `X-UserId` with a value of `1938ND9`, Nexmo will add `SipHeader_X-UserId=1938ND9` to the request made to your `answer_url`.

> **CAUTION:** Headers that start with `X-Nexmo` are not sent to your `answer_url`.

## Receiving Calls From Nexmo

You can use the Voice API NCCO connect action to connect a call to your SIP endpoints. The detailed documentation is here.

## SIP Connect

The SIP Connect feature support will continue where you can dial your virtual number via your SIP endpoint that is attached to your application. _Digest Authentication_ is the accepted authentication method for SIP Connect.

![SIP Connect Workflow](/assets/images/workflow_sip_connect.png)

To test this functionality have your PBX forward calls to `sip.nexmo.com`. Here is an example of doing so with an Asterisk extension, transmitting a custom header that will be sent to your `answer_url`:

``` text
exten => 69100,1,SIPAddHeader(X-UserId:ABC123)
exten => 69100,2,Dial(SIP/nexmo/14155550100)
```

## Further information

* [SIP Overview](/voice/sip/overview)
