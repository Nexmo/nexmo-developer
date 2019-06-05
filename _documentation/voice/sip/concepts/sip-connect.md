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
