---
title: Send an SMS with Messages API
navigation_weight: 1
---

# Send an SMS with Messages API

You will need to replace the following variables with your specific information in the example code:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` |	The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.
`TO_NUMBER` | The phone number you are sending the message to in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.

## Prerequisites

- *[Create an application](/concepts/guides/applications#getting-started-with-applications)*

## Generate a JWT

```curl
$ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

## Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-sms'
```
