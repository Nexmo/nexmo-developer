---
title: Verify Velocity Rules
description: Verify's anti-fraud system
navigation_weight: 4
---

# Verify Velocity Rules

The Verify API provides a quick and simple way to implement 2FA into your application and avoid dubious sign-ups.

However, Vonage also needs to prevent fraudulent activity on its own platform. One way we achieve this is by using an anti-fraud system called Velocity Rules.

## How it works

Velocity Rules blocks suspicious traffic based on a combination of volume and conversion rates for customer accounts by operator network. The volume is the number of requests and the conversion rate is the percentage of successful verifications.

> **Note**: The platform can only determine if a Verify request is successful if a call is subsequently made to the [Verify check endpoint](/verify/code-snippets/check-verify-request). For every Verify request, your code should perform a Verify check.

If we see a customer’s conversion rate for a network fall below 35% and a set minimum amount of traffic during a given period, our platform blocks any further traffic to that particular network. Any subsequent Verify requests will return code 15: `The destination number is not in a supported network`.

## Monitoring your conversions

You should monitor your conversion rate to ensure that you are staying within the boundaries set by Velocity Rules.

The conversation rate is calculated by comparing the number of successful verification attempts to the total number of attempts, expressed as a percentage:

`Conversion rate = (# successful verifications / # total verifications) * 100`


> This information is available in the [Developer Dashboard](https://dashboard.nexmo.com/verify/analytics), from the Verify > Analytics navigation menu option.

You can also keep track of your conversion rate based on the responses you receive from the platform during the [Verify Check](/api/verify#verifyCheck) process.

## Unblocking a network

If your verification attempts are consistently returning error code 15: `The destination number is not in a supported network`, that network might have been blocked by Velocity Rules. You can ask us to restore service, but first we advise that you do the following:

* Check the most recent blocked verification attempts sent to this network (or country)
* Confirm that they are legitimate verification attempts
* Address any suspicious traffic by updating your fraud prevention rules

If, having done this, you are satisfied that the traffic is genuine and would like to restore service to this network, please contact support@nexmo.com for assistance.

## Further information

* [Verify service to high-risk countries](https://help.nexmo.com/hc/en-us/articles/360018406532)
