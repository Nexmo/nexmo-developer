---
title: Send a Viber message with failover
---

# Send a Viber message with failover

In this example you will send a Viber message that fails over to sending an SMS. In the Workflow object, message objects can be placed in any order to suit your use case. Each message object must contain a failover object, except for the last message, as there are no more message objects to failover to.

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- VONAGE_APPLICATION_ID
- FROM_NUMBER.DISPATCH
- TO_NUMBER.DISPATCH
- VIBER_SERVICE_MESSAGE_ID
```

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/dispatch/send-viber-message-with-failover'
application:
  type: dispatch
  name: 'Send a Viber message with failover'
```

## Try it out

When you run the code it will attempt to send a message via Viber. This will fail and then a message will be sent via SMS to the destination number.
