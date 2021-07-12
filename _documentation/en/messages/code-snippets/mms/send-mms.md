---
title: Send an MMS
meta_title: Send an MMS using the Messages API
---

# Send an MMS

In this code snippet you will see how to send an MMS using the Messages API.

> **IMPORTANT:** Only US Short codes are currently supported for sending MMS.

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- FROM_NUMBER.MMS.MESSAGES
- TO_NUMBER
- IMAGE_URL.MMS.MESSAGES
```

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 14155550105.

```code_snippets
source: '_examples/messages/mms/send-mms'
application:
  type: messages
  name: 'Send an MMS'
```

## Try it out

When you run the code an MMS message is sent to the destination number.
