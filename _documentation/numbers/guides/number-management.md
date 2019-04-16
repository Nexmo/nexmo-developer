---
title: Number Management
description: Rent, configure and manage your number inventory in the Nexmo Developer Dashboard
navigation_weight: 1
---

# Number Management

The easiest way to rent, configure and manage your numbers is to use the [developer dashboard](https://dashboard.nexmo.com).

You can use the dashboard to:

* [Rent virtual numbers](#rent-a-virtual-number)
* [Configure virtual numbers](#configure-a-virtual-number)
* [Enable two-factor authentication (2FA)](#enable-two-factor-authentication)
* [Setup event alerts](#setup-event-alerts)

## Rent a virtual number

To rent a Nexmo virtual number:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click **Numbers** then **Buy numbers**.
3. Choose the attributes you need and then click **Search**.
4. Click the **Buy** button next to the number you want and validate your purchase.
5. Your virtual number is now listed in **Your numbers**.
6. If your account has no credit your virtual numbers are released for resale. To avoid this, enable [auto-reload payments](/numbers/guides/payments#auto-reload-your-account-balance).

> You rent each virtual number by the month. The renewal date is relative to the original subscription date. The rental price is automatically deducted from your Nexmo account on the same day every month. However, if you rented a virtual number on the last day of the month, the renewal date is last day of the next month. For example, if you rented a number on the 28th of February, subsequent renewal dates would be the 31st March, the 30th April, and so on.

## Configure a virtual number

To configure a Nexmo virtual number:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click **Numbers** then **Your numbers**.
3. Click the gear icon next to the number you want to configure.
4. Edit your configuration as required and then click **OK**. (If you are changing a [webhook endpoint](/concepts/guides/webhooks), ensure that the new webhook endpoint is live first.)

## Enable two-factor authentication

[Two-factor authentication](/concepts/guides/glossary#2fa) (2FA) gives you confidence that the number your customer provides you with belongs to them. If you are sending SMS to customers in the US, you can use a [short code](/concepts/guides/glossary#short-code) for this. A customer verifies their number by responding directly to the short code or via your web application. Nexmo's [Two-Factor Authentication API](/api/sms/us-short-codes/2fa) provides this capability. 

> These instructions assume that you are using a shared short code. Nexmo also offers dedicated short codes specific to your organisation. Find out more about short codes [here](https://help.nexmo.com/hc/en-us/articles/115013144287-Short-codes-Features-Overview).

To configure a shared US short code for 2FA:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click **Numbers** then **Buy numbers**.
3. Click the **add a shared short code** link.
4. Click the **Add a short code for two factor authentication** button.
5. Configure your message and company name.
6. Click **Update**. Nexmo will process your application. Approval can take up to five business days.

When you use a pre-approved US short code from Nexmo, you **MUST** display the following information on your site's opt-in page:

  * Frequency: How often users of your service can expect to receive messages from you
  * How to opt out: Send a `STOP` SMS to your short code.
  * How to get help: Send a `HELP` SMS to your short code.
  * The cost to your users to receive your messages (message and data rate)
  * The terms and conditions for your service
  * Your privacy policy

## Setup event alerts

You can use a short code to send event alerts or reminders to your users - for example, to remind them of an appointment. You configure these alerts in the developer dashboard.

> **Note** Our carrier partner (AT&T) is discontinuing its shared short code service for alerts. Nexmo is therefore no longer able to offer this service. [Dedicated short codes](https://www.nexmo.com/platform/short-codes) are still available.

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click **Numbers** then **Buy numbers**.
3. Click the **add a shared short code** link.
4. Click the **Add a shortcode for alerting** button.
5. Configure your alert, `HELP` and `STOP` messages and your business information.
6. Click **Update**.