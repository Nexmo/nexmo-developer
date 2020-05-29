---
title: Send an SMS 
description: In this step you learn how to send an SMS message.
---

# Send an SMS message

Sending an SMS message with the Messages API can be done with one API call, authenticated using a JWT.

In the example code below you will need to replace the following variables with actual values:

Key | Description
-- | --
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```code_snippets
source: '_examples/messages/sms/send-sms'
```

This will send an SMS message to the destination number you specified.

> **TIP:** If testing using Curl you will need a JWT. You can see how to create one in the documentation on [creating a JWT](/messages/code-snippets/before-you-begin#generate-a-jwt).
