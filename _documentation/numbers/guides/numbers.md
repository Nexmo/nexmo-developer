---
title: Numbers
description: How to rent numbers
---

# Numbers

Instantly provision virtual phone numbers to send or receive text messages and phone calls

## Contents

* [Manage numbers](#manage-numbers)
* [Rent virtual numbers](#rent-virtual-numbers)
* [Configure a virtual number](#configure-a-virtual-number)
* [Setup Two-factor authentication](#setting-up-two-factor-authentication)
* [Setup event based alerts](#setting-up-event-based-alerts)

## Manage numbers

You use a Nexmo virtual number to reception inbound communication from your users.

You rent each virtual number by the month. The renewal date is relative to the original subscription date. The rental price is automatically deducted from your Nexmo account on the same day every month. However, if you rented a virtual number on the last day of the month, the renewal date is last day of the next month. For example: `28/02/2015`, `31/03/2015`, `30/04/2015`.

You use Dashboard to:

* [Rent virtual numbers](#rent-virtual-numbers)
* [Setup Two-factor authentication](#setting-up-two-factor-authentication)
* [Setup event based alerts](#setting-up-event-based-alerts)

## Rent virtual numbers

To rent a Nexmo virtual number:

1. [Sign in](https://dashboard.nexmo.com/sign-in) to Dashboard.
2. Click **Numbers**, then **Buy Numbers**.
3. Select the attributes you need and click **Search**.
4. Click the number you want and validate your purchase.
5. Your virtual number is now listed in **Your numbers**.

If your account has no credit your virtual numbers are released for resale. To avoid this, enable [auto-reload payments](/numbers/guides/payments#auto-reload-your-account-balance).

> **Note**: to rent virtual numbers programmatically, call [Number: Search](/api/developer/numbers#search-available-numbers) to list the available numbers, then [Number: Buy](/api/developer/numbers#buy-a-number) to rent one of the numbers returned by the search.

## Configure a virtual number

To configure a Nexmo virtual number:

1. [Sign in](https://dashboard.nexmo.com/sign-in) to Dashboard.
2. Click **Numbers**.
3. Select the virtual number to configure and click **Edit**.
4. Update your configuration, then click **Update**.
  If you are changing a webhook endpoint, ensure that your webhook endpoint is live before you press Update.
5. Your virtual number is now listed in **Your numbers**.

## Setting up Two-factor authentication

To use [Two-factor Authentication API](/api/sms/us-short-codes/2fa):

1. [Sign in](https://dashboard.nexmo.com/sign-in) to Dashboard.
2. Click **Numbers**, then **Buy Numbers**.
3. Click **add a shared short code**.
3. Click **Add a short code for two factor authentication**.
4. Configure your message, then click **Update**.

When you use a Pre-approved US Short Code you **MUST** show the following information at the opt-in website for your service:

* Frequency - how many messages per day.
* How to opt-out - Send 'STOP' SMS to Short Code xxxxx.
* How to get help - Send 'HELP' SMS to Short Code xxxxx.
* The message and data rate that may apply.
* A link to the:
  * Terms and Conditions.
  * Privacy Policy.

For example:

```
You will receive no more than 2 msgs/day. To opt-out at any time, send STOP to 98975. To receive more information, send HELP to 98975. Message and Data Rates May Apply. The terms and conditions can be viewed at <http://url.to/your_t&c.html>. Our Privacy Policy can be reviewed at <http://url.to/your_privacypolicy.html>.
```

## Setting up event based alerts

To send [Event Based Alerts](/api/sms/us-short-codes/alerts/sending) to your users:

1. [Sign in](https://dashboard.nexmo.com/sign-in) to Dashboard.
2. Click **Numbers**, then **Buy Numbers**.
3. Click **add a shared short code**.
3. Click **Add a shortcode for alerting**.
4. Configure your alert, then click **Update**.
