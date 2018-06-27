---
title: Send a Viber Service Message
navigation_weight: 3
---

# Send a Viber Service Message

You will need to replace the following variables with your specific information in the example code:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`VIBER_SERVICE_MESSAGE_ID` | Your Viber Service Message ID.
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
config: 'messages_and_workflows_apis.messages.send-viber'
```
