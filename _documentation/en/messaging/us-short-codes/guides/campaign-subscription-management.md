---
title: Campaign Subscription Management
description: Create an opt-in and opt-out process for recipients of your campaign.
---

# Campaign Subscription Management

> **Action Needed For Vonage Customers Using US Shared Short Codes**
>
>**Effective immediately, Vonage will no longer accept new programs for Shared Short Codes for A2P messaging.** T-Mobile and AT&T’s new code of conduct prohibits the use of shared originators, therefore, existing Shared Short Code traffic must be migrated by March 1, 2021. To help you with this transition, please use the Vonage [guide to alternatives](https://help.nexmo.com/hc/en-us/articles/360050905592).  Please contact us to migrate to a new solution.

Messaging activities fall under the regulatory guidelines of several groups, depending on the nation in which you send the messages. For more information see [Preapproved US Short Codes compliance requirements](https://help.nexmo.com/hc/en-us/articles/204015403-Preapproved-US-Short-Codes-compliance-requirements)

You use the *opt-in* API to:

* Create an opt-out process so a user can [unsubscribe to your campaign](#unsubscribe-to-your-campaign)
* [Resubscribe](#resubscribe-to-your-campaign) a user to you campaign

![SMS Workflow](/images/workflow_campaign_subscription_management.svg)

1. Listen to the incoming requests and manage your recipient mailing list accordingly.
2. Send a request.
3. Check the response.

## Unsubscribe to your campaign

Unsubscribe requests for Event Based Alerts are forwarded to the [webhook endpoint](/concepts/guides/webhooks) you set in [Dashboard](https://dashboard.nexmo.com/private/settings).

To handle unsubscribe requests:

1. Listen to the incoming unsubscribe requests and manage your recipient mailing list accordingly.
Once a recipient number has unsubscribed from your campaign, any outbound SMS to that number will be blocked.

2. Send a [request](/api/sms/us-short-codes/alerts/subscription#request) and see the list of phone numbers that are unsubscribed from your campaign:

```tabbed_examples
source: '/_examples/messaging/us-short-codes/guides/campaign-subscription-management/unsubscribe/request'
```

3. Check the [response](/api/sms/us-short-codes/alerts/subscription#response):

```tabbed_examples
source: '/_examples/messaging/us-short-codes/guides/campaign-subscription-management/unsubscribe/response'
```

## Resubscribe to your campaign

Resubscribe requests for Event Based Alerts are handled through your Website.

To handle resubscribe requests:

1. On your website, listen to the incoming resubscribe requests.

2. Send a [request](/api/sms/us-short-codes/alerts/subscription#request) to opt-in the phone number again:

```tabbed_examples
source: '/_examples/messaging/us-short-codes/guides/campaign-subscription-management/resubscribe/request'
```

3. Check the [response](/api/sms/us-short-codes/alerts/subscription#response):

```tabbed_examples
source: '/_examples/messaging/us-short-codes/guides/campaign-subscription-management/resubscribe/response'
```
