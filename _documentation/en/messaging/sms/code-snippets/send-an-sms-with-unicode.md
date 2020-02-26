---
title: Send an SMS with Unicode
description: How to send a Unicode SMS with the Nexmo SMS API
navigation_weight: 3
---

# Sending an SMS with Unicode

Nexmo's SMS API supports Unicode characters too, which you will need to use when communicating with customers in Chinese, Japanese and Korean.

To send an SMS that contains Unicode characters, replace the following variables in the example below:

Key | Description
-- | --
`NEXMO_API_KEY` | You can find this in your Nexmo Dashboard.
`NEXMO_API_SECRET` | You can find this in your Nexmo Dashboard.
`NEXMO_BRAND_NAME` | The alphanumeric string that represents the name or number of the organization sending the message.
`TO_NUMBER` | The number you are sending the SMS to, for example `447700900000`.

```code_snippets
source: '_examples/messaging/sms/send-an-sms-with-unicode'
```

## Try it out

When you run the example above, the text message will be sent to the mobile number specified with the Unicode characters intact.

> Note that Unicode messages can only contain 70 characters, rather than the usual 160. There's more information about this [on the help page](https://help.nexmo.com/hc/en-us/articles/204076866-How-long-is-a-single-SMS-body-)

## Further reading

* [Concatenation and encoding for SMS](/messaging/sms/guides/concatenation-and-encoding)
* [How to Send and Receive SMS Messages With Node.js and Express](https://www.nexmo.com/blog/2019/09/16/how-to-send-and-receive-sms-messages-with-node-js-and-express-dr)
* [Two-way SMS for customer engagement](/tutorials/two-way-sms-for-customer-engagement)
