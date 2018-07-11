---
title: Overview
---

# Overview

The Conversion API allows you to tell Nexmo about the reliability of your 2FA communications. Sending conversion data back to us means that Nexmo can deliver messages faster and more reliably.

The conversion data you send us is confidential: Nexmo does not share it with third parties.

In order to identify the carriers who provide the best performance, Nexmo continually tests the routes we use to deliver SMS and voice calls. Using Adaptive Routing™, Nexmo actively reroutes messages through different carrier routes and ensures faster and more reliable delivery for your messages. The route choice is made using millions of real-time conversion data points.

Message delivery indicators are:

* Delivery receipts (DLRs) - in most instances DLRs are indicative of handset delivery. Unfortunately, delivery receipts are not always a reliable measurement of SMS reception. Nexmo uses conversion data as our main quality measurement.
* Conversion data - by continuously sending a small amount of traffic to carriers, we see which route is performing best at a point in time and automatically reroute accordingly. This analysis is carried out every 5 minutes using data points from the previous 15 minutes.

When you are implementing Conversion API you must differentiate between your [2FA](/messaging/us-short-codes/guides/2fa) traffic and other messages. For example, [Event Based Alerts](/messaging/us-short-codes/guides/alerts) or marketing messages. To do this, use one [api_key](/api/conversion) to authenticate requests to Conversion API for 2FA traffic, and a different `api_key` for everything else.

> Note: to rapidly integrate 2FA into your app, use [Verify API](/verify/overview). The Conversion API is already integrated into Verify for fast and reliable delivery of your content.

The following figure shows the Conversion API workflow:

![Conversion API workflow](/assets/images/workflow_conversion_api.svg)

Access to the Conversion API is not enabled by default when you create your Nexmo account. To use Conversion API, you must first request access in an email to [support@nexmo.com](mailto:support@nexmo.com).

Once you have access, to use Conversion API:

1. Start a 2FA workflow using either:

    1. [SMS API](/messaging/sms/overview)
    2. [Text-to-Speech Prompt API](https://docs.nexmo.com/voice/voice-deprecated/text-to-speech-prompt)

2. Nexmo sends a text or voice message to your user.

3. Your user replies to your message or verification request.

4. As soon as possible, send a Conversion API [request](/api/conversion#request) with information about the Call or Text-To-Speech identified by `message-id`. Nexmo uses your conversion data and internal information about `message-id` to help improve our routing of messages in the future.

    ```tabbed_examples
    source: '_examples/messaging/conversion-api/request'
    ```

5. Check the [Response](/api/conversion#response) to see if we successfully received your conversion data.

    ```tabbed_examples
    source: '_examples/messaging/conversion-api/response'
    ```
