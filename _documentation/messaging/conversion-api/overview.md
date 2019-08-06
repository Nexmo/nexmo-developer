---
title: Overview
meta_title: Conversion API
---

# Conversion API

The Conversion API allows you to tell Nexmo about the reliability of your [2FA](/messaging/us-short-codes/guides/2fa/) communications. Sending conversion data back to Nexmo enables faster and more reliable delivery of your messages.

> **Note**: If you are using the [Verify API](/verify/overview) for 2FA, you don't need to send us conversion data. The Verify API does this automatically.

Nexmo uses this conversion data, together with [delivery receipts (DLRs)](/messaging/sms/guides/delivery-receipts) to facilitate Adaptive Routing™. The Adaptive Routing algorithm automatically determines the best carrier routes via which to deliver SMS and voice calls at any specific moment. In most instances, a DLR is confirmation that your message was delivered to the recipient. However, not all carriers' DLRs are reliable and some do not provide them at all. Therefore, conversion data is our best indicator of route quality.

> **Note**: The conversion data you send us is confidential: Nexmo will never share it with third parties.

## Before you send conversion data

Access to the Conversion API is not enabled by default when you create your Nexmo account. To use the Conversion API, you must first request access by sending an email to [support@nexmo.com](mailto:support@nexmo.com).

When sending us conversion data you must differentiate between your [2FA](/messaging/us-short-codes/guides/2fa) messages and other communications. For example, [event based alerts](/messaging/us-short-codes/guides/alerts) or marketing messages. To do this, use one [API key](/api/conversion) to authenticate requests to the Conversion API for 2FA, and a different API key for everything else.

## Reporting conversion data

The following diagram shows the Conversion API workflow:

![Conversion API workflow](/assets/images/workflow_conversion_api.svg)

To send conversion data to Nexmo:

1. Start a 2FA workflow by [sending a 2FA request](/messaging/us-short-codes/guides/2fa#implementing-the-two-factor-authentication-api-workflow)

2. Nexmo sends a text or voice message to your user.

3. Your user replies to your message or verification request.

4. Immediately send a Conversion API [request](/api/conversion#request) with information about the message identified by `message-id`:

    ```tabbed_examples
    source: '_examples/messaging/conversion-api/request'
    ```
    > **Important**: You should always send these requests as soon as possible after your user has replied to your 2FA invitation and not wait to submit them in batches. Adaptive Routing relies on timely conversion data to make the best routing decisions.

5. Check the [response](/api/conversion#response) to ensure that Nexmo successfully received your conversion data:

    ```tabbed_examples
    source: '_examples/messaging/conversion-api/response'
    ```
