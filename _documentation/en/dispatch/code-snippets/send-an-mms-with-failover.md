---
title: Send an MMS with failover
---

# Send an MMS with failover

> **Action Needed For Vonage Customers Using US Shared Short Codes**
>
> **Effective immediately, Vonage will no longer accept new programs for Shared Short Codes for A2P messaging.** T-Mobile and AT&T's new code of conduct prohibits the use of shared originators for A2P (application to person) traffic. Please migrate any existing Shared Short Code traffic to one of our alternative solutions. To help you with this transition, please use the Vonage [guide to alternatives](https://help.nexmo.com/hc/en-us/articles/360050905592).  Please [contact us](mailto:support@nexmo.com) to migrate to a new solution.

In this example you will send an MMS that can fail over to sending an SMS.

In the Workflow object, message objects can be placed in any order to suit your use case. Each message object must contain a failover object, except for the last message, as there are no more message objects to failover to.

> **NOTE:** MMS only supports US Short Codes.

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- VONAGE_APPLICATION_ID
- FROM_NUMBER.MMS.MESSAGES
- TO_NUMBER.DISPATCH
```

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/dispatch/send-mms-with-failover'
application:
  type: dispatch
  name: 'Send an MMS with failover'
```

## Try it out

When you run the code it will attempt to send an MMS. If this fails, for example because the recipient is on T-Mobile, then a message will be sent via SMS to the destination number.
