---
title: Send a WhatsApp Message
navigation_weight: 4
---

# Send a WhatsApp Message

You will need to replace the following variables with your specific information in the example code:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.**

## Prerequisites

- *[Create an application](/concepts/guides/applications#getting-started-with-applications)*

## Generate a JWT

```curl
$ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

## Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-whatsapp'
```
