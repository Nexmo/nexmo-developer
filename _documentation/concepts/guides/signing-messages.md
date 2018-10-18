---
title: Signing requests
description: Add an extra layer of security by sending and receiving signed requests.
navigation_weight: 4
---

# Signing requests

Signatures validate the authenticity of the person who interacts with Nexmo.

You use a signature to:

* Verify that a request originates from a trusted source
* Ensure that the message has not been tampered with en-route
* Defend against interception and later replay

A signature is an [MD5 hash](https://en.wikipedia.org/wiki/MD5) of:

* The parameters - all the parameters in a request sorted in alphabetic order
* A timestamp - a UNIX timestamp at UTC + 0 to protect against replay attacks
* Your `SIGNATURE_SECRET` - the key supplied by Nexmo that you use to sign or validate requests

The signature has a leading `&`. All parameters in the hash input, apart from your `SIGNATURE_SECRET` are separated by `&`.

[HMAC-SHA1/256/512 ](https://en.wikipedia.org/wiki/SHA-2) is also supported. Contact support@nexmo.com for more information.

> Note: Using signatures is an *optional* improvement on using the standard `api_secret`. You use the `SIGNATURE_SECRET` instead of your api_secret in a signed request.

The following example shows a signed request to the SMS API:

```
https://rest.nexmo.com/sms/xml?api_key=API_KEY&from=Nexmo&to=447700900000&type=text&text=Hello+from+Nexmo&status-report-req=false&timestamp=1461605396&sig=SIGNATURE
```

The workflow for using signed messages is:

![Signing requests workflow](/assets/images/workflow_call_api_outbound.svg)

1. Create a signed [request](/api/sms#request) to send an SMS.
2. Check the [response codes](/api/sms#errors) and ensure that you sent the request correctly.
3. Your message is delivered to the handset. The user's handset returns a delivery receipt.
4. If you requested signed delivery receipts and inbound messages validate the signature.


## Implementing the message signing workflow

When you create a Nexmo account you will be provided a signature secret. These can be found in your [account settings](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.

To sign your messages:

**Create a signed [request](/api/sms#request):**

```tabbed_examples
source: '_examples/messaging/signing-messages/create-request'
```

**Check the [response codes](/api/sms#response-codes) to ensure that you sent the request to Nexmo correctly:**

```tabbed_examples
source: '_examples/messaging/signing-messages/check-response'
```

If you did not generate the signature correctly the [status](/api/sms#status-codes) is `14, invalid signature`

Your message is delivered to the handset. The user's handset returns a delivery receipt.

**If your delivery receipts and inbound messages are signed, validate the signature:**

```tabbed_examples
source: '_examples/messaging/signing-messages/validate-signature'
```

## Troubleshooting signatures

Here are some tips and pitfalls to look out for when working with signed messages.

### Check the response for details

If the message isn't sent as expected, check the response for any [error codes](/api/sms#errors) that were returned. This will usually give you more detail on what to do next.

### Error 14: Invalid Signature

If the text being sent includes any special characters such as `&` (ampersand) or `=` (equals), then these need to be replaced in the text used to create the signature.

A general approach would be:

- Detect that the text includes `&` or `=`.
- Create a version of the text that uses `_` (underscore) in place of these special characters.
- Use the sanitised version of the text to create the signature.

The original text can be still be sent/received, the character replacements are only needed to generate the signature.
