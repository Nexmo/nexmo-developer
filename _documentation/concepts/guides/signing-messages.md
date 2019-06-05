---
title: Signing messages
description: Add an extra layer of security by sending and receiving signed requests.
navigation_weight: 4
---

# Signing Messages

You can use signatures with Nexmo when both sending and receiving SMS messages. When sending, you generate a signature to send with your message. When receiving, the incoming webhook will include the signature and all the fields you need to generate the signature in your application to verify that the two signatures match.

You use a signature to:

* Verify that a request originates from a trusted source
* Ensure that the message has not been tampered with en-route
* Defend against interception and later replay

## Contents

This document covers how to use signatures with messages, both signing the messages you send and verifying that incoming messages have a correct signature.

  - [Send messages with signatures](#use-signatures-when-sending-messages). Use the [client libraries](/tools) to generate and send the signed message.
  - [Verify signatures on incoming messages](#validate-the-signature-on-incoming-messages) to ensure authenticity of the message in the incoming webhook.
  - [Manually generate a signature](#manually-generate-a-signature) if you cannot use the existing libraries, the manual process for signature generation is included here.

## Use signatures when sending messages

To send a message with a signature, you will need to use the `SIGNATURE_SECRET` instead of your `API_SECRET` when sending the message. You can find the signature secret and choose which signing algorithm to use by visiting the [dashboard](https://dashboard.nexmo.com). The default algorithm is'[MD5 hash](https://en.wikipedia.org/wiki/MD5)' and we also support `MD5 HMAC`, `SHA1 HMAC`, `SHA-256 HMAC` and `SHA-512 HMAC`.

Nexmo strongly recommends you use one of our [client libraries](/tools) to generate or validate signatures. If you *can't* do this for some reason, you *can* generate and validate signatures yourself, but this can be complicated and potentially error-prone. Refer to the [section on manually generating signatures](#manually-generate-a-signature).

The process for sending a signed message is as follows:

1. Create a signed [request](/api/sms#send-an-sms) to send an SMS.
2. Check the [response codes](/api/sms#errors) and ensure that you sent the request correctly.
3. Your message is delivered to the handset. The user's handset returns a delivery receipt.
4. *(optional)* If you requested signed delivery receipts and inbound messages, you will want to validate the signature for each incoming request.

If you did not generate the signature correctly the [status](/messaging/sms/guides/troubleshooting-sms#sms-api-error-codes) is `14, invalid signature`. You can find more information in the [troubleshooting](#troubleshooting-signatures) section of this guide.

> By default, message signatures are optional when sending messages and are not included with incoming webhooks. To enable either signed webhooks or enforce all sent messages to be signed, please contact support@nexmo.com.

The code example below shows how to send a signed message with the SMS API.

```code_snippets
source: '_examples/concepts/guides/send-signed-sms'
```

## Validate the signature on incoming messages

In order to verify the origin of incoming webhooks to your SMS endpoint, you can enable message signing for incoming messages - contact support@nexmo.com to request incoming messages be accompanied by a signature. With this setting enabled, the webhooks for both incoming SMS and delivery receipts will include a `sig` parameter. Use the other parameters in the request with your signature secret to generate the signature and compare it to the signature that was sent. If the two match, the request is valid.

> Contact support to enable message signing on your account: support@nexmo.com

The code example below shows how to verify a signature for an incoming SMS message.

```code_snippets
source: '_examples/concepts/guides/verify-signed-sms'
```

## Manually generate a signature

It is *highly recommended* that you use your Nexmo library's existing functionality for generating and validating signatures. If you aren't using a library with this functionality, you'll need to generate the signature yourself. The technique is slightly different if are generating an 'MD5 hash' signature or one of the HMAC signatures.

### Step 1: For both hash and HMAC signatures

If you're **generating a signature:** Add the current timestamp to the parameters list with the key `timestamp`. This should be an integer containing the number of seconds since the epoch (this is sometimes also known as UNIX time)

If you're **validating a signature** from Nexmo: Remove the `sig` parameter before generating your signature, and use the `timestamp` provided in the request parameters.

Then:

* Loop through each of the parameters, sorted by key
* For every value in the parameter list, replace all instances of `&` and `=` with an underscore `_`.
* Generate a string consisting of `&akey=value&bkey=value`. **Note that there is an ampersand `&` at the start of the string!**

At this point, the process for hash and HMAC will differ, so use the "Step 2" section that fits your needs:

### Step 2: For hash

* Add signature secret to the end of the string, directly after the last value. It should now look something like this: `&akey=value&bkey=valueyour_signature_secret`
* Now run the string through an md5 hash function and convert the resulting bytes to a string of hexadecimal digits. This is your MD5 hash signature, and should be added to the HTTP parameters of your request as the `sig` parameter.

### Step 2: For HMAC

* Create an HMAC generator with your desired algorithm and your signature secret as the key.
* Now run the string through an hmac generator and convert the resulting bytes to a string of hexadecimal digits. This is your HMAC signature, and should be added to the HTTP parameters of your request as the `sig` parameter (e.g. for PHP this looks like `hash_hmac($algorithm, $data, $secret)`).

### Step 3: Additional notes

Bear in mind that although you changed the parameter values while generating the signature, the values passed as HTTP parameters should be __unchanged__ when sending those parameters to the SMS API.

## Troubleshooting signatures

Here are some tips and pitfalls to look out for when working with signed messages.

### Check the response for details

If the message isn't sent as expected, check the response for any [error codes](/api/sms#errors) that were returned. This will usually give you more detail on what to do next.

### Error 14: Invalid Signature

If the text being sent includes any special characters such as `&` (ampersand) or `=` (equals), then these need to be replaced in the text used to create the signature.

To do this, use the following instructions:

- Detect that the text includes `&` or `=`.
- Create a version of the text that uses `_` (underscore) in place of these special characters.
- Use the sanitised version of the text to create the signature.

The original text can be still be sent/received, the character replacements are only needed to generate the signature.
