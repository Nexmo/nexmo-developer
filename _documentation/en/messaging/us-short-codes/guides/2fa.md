---
title: 2FA
---

# Two-factor Authentication API

You can use Two-factor Authentication API to prove a user's identity. Provision a US Short Code with a standard or custom template that specifies the custom parameters for two-factor authentication (2FA) messages. These APIs support 2FA for the US and Canada.

Two-factor authentication (also known as 2FA) provides user identification by combining two different components. In this case, a phone number associated with your user and a PIN. Before you use this API you have to [Setup a preapproved Short Code for 2FA](/numbers/guides/enable-2fa).

The workflow for Two-factor Authentication API is:

![Two-factor Authentication workflow](/assets/images/workflow_2fa.svg)

1. Send a 2FA [request](/api/sms/us-short-codes/2fa#request).
2. Check the [response codes](/api/sms/us-short-codes/2fa#keys-and-values) in the [response](/api/sms/us-short-codes/2fa#response) and ensure that you sent the request to Nexmo correctly.
3. Nexmo delivers your PIN to your user's handset. Your user enters this PIN into your APP.
4. Receive the [delivery receipt](/api/sms/us-short-codes/2fa#delivery-receipt) at your [webhook endpoint](/concepts/guides/webhooks) and verify delivery.

To ensure that your traffic is send over the best possible route, use [Conversion API](/messaging/conversion-api/overview) to tell us about the reliability of your 2FA communication. Adding your conversion data means Nexmo delivers your messages faster and more reliably.

> Note: Nexmo calculates quality of delivery (QoD) statistics using delivery receipts (DLR). In the United States, we only receive intermediate and not handset DLRs. This means Dashboard analytics cannot show QoD statistics for messages sent via the US short code API.

## Implementing the Two-factor Authentication API workflow

To use the 2FA API you:

1. Send a 2FA [request](/api/sms/us-short-codes/2fa#request).

```tabbed_examples
source: '_examples/messaging/us-short-codes-api/2fa/send-a-2fa-request'
```

2. Check the [response codes](/api/sms/us-short-codes/2fa#keys-and-values) in the [response](/api/sms/us-short-codes/2fa#response) and ensure that you sent the request to Nexmo correctly.

```tabbed_examples
source: '_examples/messaging/us-short-codes-api/generic/check-the-response-codes'
```

3. Nexmo delivers your PIN to your user's handset. Your user enters this PIN into your APP.

4. Receive the [delivery receipt](/api/sms/us-short-codes/2fa#delivery-receipt) at your [webhook endpoint](/concepts/guides/webhooks) so you can see:

    1. If the [status](/api/sms/us-short-codes/2fa#keys-and-values-2) was successful.
    2. When and how the call was made.
    3. How much the call cost.

```tabbed_examples
source: '_examples/messaging/us-short-codes-api/generic/delivery-receipt'
```

> Note: remember to return a  status code when you receive the delivery receipt.
