---
title: Overview
meta_title: US Short Codes
description: Vonage provides an API for sending SMS messages from a shared short code to mobile device users in the United States.
---

# US Short Codes Overview

> **Action Needed For Vonage Customers Using US Shared Short Codes**
>
> **Effective immediately, Vonage will no longer accept new programs for Shared Short Codes for A2P messaging.** T-Mobile and AT&T's new code of conduct prohibits the use of shared originators for A2P (application to person) traffic. Please migrate any existing Shared Short Code traffic to one of our alternative solutions. To help you with this transition, please use the Vonage [guide to alternatives](https://help.nexmo.com/hc/en-us/articles/360050905592).  Please [contact us](mailto:support@nexmo.com) to migrate to a new solution.

Vonage provides an API for sending SMS messages from a shared short code to mobile device users in the United States.

Due to [legal and regulatory requirements for use of US Short Codes](https://help.nexmo.com/hc/en-us/articles/204015403-Preapproved-US-Short-Codes-compliance-requirements), approval is required by Vonage to use the API. You can apply for a shared US Short Code via the [Vonage Dashboard](https://dashboard.nexmo.com) in the Numbers section. You will need to ensure that your application follows the best practices outlined at the link above.

Customers using the US Short Codes API use separate endpoints for sending messages to the standard [SMS API](/messaging/sms/overview).

## Guides

* [Alerts](/messaging/us-short-codes/guides/alerts) – how to send event-based alerts
* [Two-factor Authentication API](/messaging/us-short-codes/guides/2fa) – how to send two-factor authentication (2FA) codes
* [Campaign Subscription Management](/messaging/us-short-codes/guides/campaign-subscription-management) — handling unsubscribe and resubscribe requests

## API Reference

* [Alerts API - Subscribing](/api/sms/us-short-codes/alerts/subscription)
* [Alerts API - Receiving](/api/sms/us-short-codes/alerts/sending)
