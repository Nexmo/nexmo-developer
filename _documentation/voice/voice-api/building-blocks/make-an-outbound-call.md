---
title: Make an outbound call
navigation_weight: 1
---

# Make an outbound call

Making outbound calls from Nexmo is easy. In this building block we'll use the Voice API to start a call and play a text-to-speech message on answer.

## Prerequisites

- *[Rent a virtual number](https://developer.nexmo.com/account/guides/numbers#rent-virtual-numbers)*
- *[Create an application](https://developer.nexmo.com/concepts/guides/applications#getting-started-with-applications)*

## Example

To make a test outbound voice call, sign up for an account and replace the following variables in the example below:

Key |	Description
-- | --
`NEXMO_NUMBER` |	Your Nexmo number that the call will be made from. For example `447700900001`.
`TO_NUMBER` |	The number you would like to call to in E.164 format. For example `447700900000`.
`NEXMO_APPLICATION_ID` |	The ID of the application that you created.

Depending on which library you are using you will need to replace any occurrences of the following:

Key |	Description
-- | --
`NEXMO_API_KEY` | You can find this in your account overview
`NEXMO_API_SECRET` | You can find this in your account overview
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | The path to your private key file. e.g. `private.key`

```tabbed_content
source: '_examples/voice/make-an-outbound-call'
```
