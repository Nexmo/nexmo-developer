---
title: SIP Connect
---

# SIP Connect

Nexmo supports SIP Connect, allowing you to dial in to the Nexmo Platform directly from your own infrastructure.

Connecting from a SIP endpoint to a Nexmo application enables you to dynamically handle calls and connect out to mobile, landline, SIP and IP endpoints.

![SIP Connect Workflow](/assets/images/workflow_sip_connect.png)

Currently, you need to dial a Nexmo virtual number that is attached to an application. This is how Nexmo routes your call to the correct `answer_url`.

To test this functionality have your PBX forward calls to `sip.nexmo.com`. Here is an example of doing so with an Asterisk extension, transmitting a custom header that will be sent to your `answer_url`:

```
exten => 69100,1,SIPAddHeader(X-UserId:ABC123)
exten => 69100,2,Dial(SIP/nexmo/14155550100)
```

## Domain-based routing

If you are using `SIP Connect` and require your call to be handled by a specific Nexmo region, then you can specify that by using R-URI with such information in the domain part.

e.g.:
```
sip:anLVN@sip-eu1.nexmo.com
```
will instruct us that you want this `SIP Connect` call to be handled in EU.

Available domains are the same as the A records:

- sip-us-2-1.nexmo.com: US
- sip-us-2-2.nexmo.com: US
- sip-eu1.nexmo.com: EU
- sip-eu2.nexmo.com: EU
- sip-ap1.nexmo.com: AP
- sip-ap2.nexmo.com: AP


