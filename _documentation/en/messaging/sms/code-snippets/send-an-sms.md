---
title: Send an SMS
description: How to send an SMS with the Nexmo SMS API
navigation_weight: 2
---

# Sending an SMS

To send an SMS, replace the following variables in the example below:

Key | Description
-- | --
`TO_NUMBER` | The number you are sending the SMS to in E.164  format. For example `447700900000`.
`NEXMO_API_KEY` | You can find this in your account overview
`NEXMO_API_SECRET` | You can find this in your account overview

```code_snippets
source: '_examples/messaging/sms/send-an-sms'
```
## Try it out

When you run the example above, the text message will be sent to the mobile number that you specified.

## Further reading

* [How to send SMS messages with Node.js and Express](https://www.nexmo.com/blog/2016/10/19/how-to-send-sms-messages-with-node-js-and-express-dr/)
* [Two-way SMS for customer engagement](/tutorials/two-way-sms-for-customer-engagement)
