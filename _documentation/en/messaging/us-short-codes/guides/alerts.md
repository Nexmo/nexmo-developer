---
title: Alerts
---

# Alerts

> **Action Needed For Vonage Customers Using US Shared Short Codes**
>
> **Effective immediately, Vonage will no longer accept new programs for Shared Short Codes for A2P messaging.** T-Mobile and AT&T's new code of conduct prohibits the use of shared originators for A2P (application to person) traffic. Please migrate any existing Shared Short Code traffic to one of our alternative solutions. To help you with this transition, please use the Vonage [guide to alternatives](https://help.nexmo.com/hc/en-us/articles/360050905592).  Please [contact us](mailto:support@nexmo.com) to migrate to a new solution.

You use Event Based Alerts to communicate with people using Event Based Alerts. Provision a US Short Code with a standard or custom template that specifies the custom parameters for Alert messages.

> Note: quality of delivery (QoD) statistics are based on delivery receipts (DLR). For the US we only receive intermediate and not handset DLRs. This means Dashboard analytics cannot show QoD statistics for short codes.

## Sending Alerts

You use Event Based Alerts to send custom messages to your users. Before you use this API you have to [set up a preapproved Short Code for Event Based Alerts](/numbers/guides/event-alerts)

The workflow for sending Event Based Alerts is:

![Event Based Alerts Workflow](/images/messaging/alerts/alerts_workflow.png)

1. Send an Event Based Alerts [request](/api/sms/us-short-codes/alerts/sending#request).

2. Check the [status code](/api/sms/us-short-codes/alerts/sending#response) in the [response](/api/sms/us-short-codes/alerts/sending#response) and ensure that you sent the request to Vonage correctly.

3. Vonage sends the alert to your user.

4. Receive the [delivery receipt](/api/sms/us-short-codes/alerts/sending#delivery-receipt) at your [webhook endpoint](/concepts/guides/webhooks) and verify delivery.


### Implementing the Event Based Alerts workflow

To send Event Based Alerts to your users:

1. Send an Event Based Alerts [request](/api/sms/us-short-codes/alerts/sending#request). If you have multiple templates, remember to set the <i>template</i> number in your request.

    ```tabbed_examples
    source: '_examples/messaging/us-short-codes-api/alerts/send-alerts-request'
    ```

2. Check the [status code](/api/sms/us-short-codes/alerts/sending#response) in the [response](/api/sms/us-short-codes/alerts/sending#response) and ensure that you sent the request to Vonage correctly:

    ```tabbed_examples
    source: '_examples/messaging/us-short-codes-api/generic/check-the-response-codes'
    ```

3. Vonage sends the alert to your user.

4. Receive the [delivery receipt](/api/sms/us-short-codes/alerts/sending#delivery-receipt) at your [webhook endpoint](/concepts/guides/webhooks) so you can see:

* If the [status](/api/sms/us-short-codes/alerts/sending#response) was `delivered`.
* When and how the message was made.
* How much the message cost.

    ```tabbed_examples
    source: '_examples/messaging/us-short-codes-api/generic/delivery-receipt'
    ```

> Note: remember to send return *200 OK* when you receive the delivery receipt.
