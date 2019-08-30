---
title: Overview
meta_title: Connect to Nexmo using SIP
description: Use Nexmo SIP to forward inbound and send outbound Voice calls that use the Session Initiation Protocol.
---

# SIP Overview

Nexmo allows you to [forward inbound](#inbound-configuration) and [send outbound](#configuring-your-system-for-sip-forwarding) Voice calls using the [Session Initiation Protocol](https://en.wikipedia.org/wiki/Session_Initiation_Protocol).

This document explains the relevant setup options.

**Endpoint**

You can send your [INVITE](https://en.wikipedia.org/wiki/List_of_SIP_request_methods) requests to the Nexmo SIP endpoint: `sip.nexmo.com`.

**Authentication**

Every INVITE request is authenticated with Digest authentication:

- `username` - your Nexmo *key*
- `password` - your Nexmo *secret*

**Service records**

If your system is not enabled for [Service records](https://en.wikipedia.org/wiki/SRV_record) (SRV records), you should load balance between the two closest endpoints and set the remaining ones as backup. The Nexmo SIP endpoints are:

- `sip-eu1.nexmo.com` (London)
- `sip-eu2.nexmo.com` (London)
- `sip-ap1.nexmo.com` (Singapore)
- `sip-ap2.nexmo.com` (Singapore)
- `sip-us-2-1.nexmo.com` (Dallas)
- `sip-us-2-2.nexmo.com` (Dallas)

**Recipient**

Recipient numbers must be in [E.164](https://en.wikipedia.org/wiki/E.164) format:

**Caller ID**

Set the Caller Line Identity (CLI) in the *From* header using [E.164](https://en.wikipedia.org/wiki/E.164). For example: `From: <sip:447700900000@sip.nexmo.com>`.

**Codecs**

The following codecs are supported:

- PCMA (G711a)
- PCMU (G711u)
- iLBC
- g729 (without annexdb)
- g722
- Speex16

**Media traffic**

Open traffic for all ports for the following IP ranges:

  * 169.50.120.160/28
  * 169.54.106.32/27
  * 161.202.24.16/28
  * 169.48.97.80/28
  * 169.47.144.176/28

**DTMF**

Nexmo supports out-of-band DTMF. For more information, see [RFC2833](https://www.ietf.org/rfc/rfc2833.txt).

**Health checks**

Use the [OPTIONS](https://en.wikipedia.org/wiki/List_of_SIP_request_methods) method to run a health check on our SIP trunks.

**Protocols**

You can use the following protocols:

- UDP on port 5060
- TCP on port 5060
- TLS on port 5061

[Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security) (TLS) is a cryptographic protocol designed to provide communications security to your SIP connection. You can use self-signed certificates on your user agent, Nexmo does not validate the certificate on the client side.

Connections using TLS 1.2 are accepted. Older protocols are disabled as they are considered insecure.

## Inbound configuration

This section tells you how to:

- [Configure your system for SIP forwarding](#configuring-your-system-for-sip-forwarding)
- [Configure example servers](#example-configurations)

## Configuring your system for SIP forwarding

To configure for SIP forwarding:

1. Sign into [Dashboard](https://dashboard.nexmo.com/sign-in).
2. In Dashboard, click *Products* > *Numbers*.
3. Scroll to the number to forward from, then select *Forward to SIP*.
4. Type a valid SIP URI and click *Update*. For example `sip:1234@example.com`.
  This field supports comma-separated entries for failover capabilities. For example: `sip:1234@example.com,sip:1234@example.net,sip:1234@example.org`. If you set more than one endpoint in *Forward to SIP* the call is initially forwarded to the first endpoint in the list. If this fails, the call is forwarded to the second endpoint in the list, and so on.
  Calls failover for the whole 5xx class of HTTP errors. The timeout is 486.
5. You can specify a timeout for non responding SIP endpoints, by appending a `;timeout=xxxxx` to the related URI. For example: `sip:1234@example.com;timeout=2000,sip:1234@example.net` will attempt to forward to the first URI, and in case of no response within 2 seconds it will try the second one. Timeouts are expressed in milliseconds and can range from 2000 to 20000. This is useful to quickly fail over when an endpoint is temporarily unavailable. The default value is 5000 ms.
6. Ensure that the traffic generated from the following IP addresses can pass your firewall:

  * 5.10.112.121
  * 5.10.112.122
  * 119.81.44.6
  * 119.81.44.7
  * 169.60.141.29
  * 169.60.141.30

> **Note**: Nexmo supports TLS on inbound connections. To enable this, enter a valid URI in the format sip:user@(IP|domain);transport=tls. For example, *sip:1234@example.com;transport=tls*. By default, traffic is sent to port 5061. To use a different port, add it at the end of your domain or IP address: *sip:1234@example.com:5062;transport=tls*.

## Example configurations

We have provided examples for a number of different SIP capable systems:

* [Asterisk](/voice/sip/configure/asterisk)
* [Avaya SBCe](/voice/sip/configure/avaya-sbce)
* [Cisco CUCM/CUBE](/voice/sip/configure/cucm-cube)
* [FreePBX](/voice/sip/configure/freepbx)
* [FreeSWITCH](/voice/sip/configure/freeswitch)
* [MiTel MiVoice and MiTel Border Gateway](/voice/sip/configure/mitel-mivoice)
* [ShoreTel Director and InGate SIParator](/voice/sip/configure/shoretel)
* [Skype for Business with Oracle E-SBC](/voice/sip/configure/skypeforbusiness)
* [NEC SV9100](/voice/sip/configure/nec-sv9100)
