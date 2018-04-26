---
title: Make an outbound call
navigation_weight: 2
---

# Make an outbound call

In this building block you will use the Voice API to make an outbound
call and play a text-to-speech message on answer. An outbound call is
a call made from your Nexmo Application.

## Prerequisites

- *[Rent a virtual number](/account/guides/numbers#rent-virtual-numbers)*
- *[Create an application](/concepts/guides/applications#getting-started-with-applications)*


## Placeholder values

In the example code snippets you need to substitute the following
variables with suitable values:

Key |	Description
-- | --
`NEXMO_NUMBER` | Your Nexmo number that the call will be made from. For example `447700900001`.
`TO_NUMBER` | The number you would like to call to in E.164 format. For example `447700900000`.
`NEXMO_APPLICATION_ID` |  The ID of the application that you created.

Depending on which library you are using you will need to replace any
occurrences of the following:

Key |	Description
-- | --
`NEXMO_API_KEY` | You can find this in your Nexmo Dashboard
`NEXMO_API_SECRET` | You can find this in your Nexmo Dashboard
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | The path to your private key file. For example, `private.key`

```tabbed_content
source: '_examples/voice/make-an-outbound-call'
```

## Run your code

Run your code. Nexmo will call the `TO_NUMBER` you specified. If you
answer the call you will hear a text-to-speech message.
