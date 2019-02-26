---
title: Send an MMS
---

# Send an MMS

In this building block you will see how to send an MMS using the Messages API.

> **IMPORTANT:** Only US Short codes are currently supported for sending MMS.

## Example

Ensure the following variables are set to your required values using any convenient method:

| Key           | Description                                                                                                 |
| ------------- | ----------------------------------------------------------------------------------------------------------- |
| `FROM_NUMBER` | The phone number you are sending the MMS from. (US Short Code only)                              |
| `TO_NUMBER`   | The phone number you are sending the message to. |
| `IMG_URL`     | The URL of the media you want to send                                                                       |

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 14155550105.

```building_blocks
source: '_examples/messages/send-mms'
application:
  type: messages
  name: 'Send an MMS'
```

## Try it out

When you run the code an MMS message is sent to the destination number.