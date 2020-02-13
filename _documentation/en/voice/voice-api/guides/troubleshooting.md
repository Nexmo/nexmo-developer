---
title: Troubleshooting
navigation_weight: 9
ignore_in_list: true
---

# Troubleshooting

## Overview

The Nexmo Voice API offers a highly available service. However, due to the nature of providing service across hundreds of phone carriers around the world, problems may arise occasionally that are outside of Nexmo's control. In addition there are certain limitations placed on Nexmo by partner networks, which can have an impact on how your application functions. While not exhaustive here are a few things to look for if you are experiencing problems.

## Timeouts

When Nexmo sends a webhook to your Answer URL it expects the server to respond in a certain time frame:

1. The TCP connection should be established within 3 seconds.
2. The HTTP response (NCCO) should be returned within 5 seconds.

If Nexmo does not get a response within these time frames it will retry the request twice. If this fails, Nexmo will make two further attempts to access your Fallback Answer URL, if it is configured. If Nexmo does not get a response within these time frames from your Fallback Answer URL it will retry again. If the Fallback Answer URL responds with a HTTP error code or invalid NCCO then the call is disconnected.

## Regions

The Nexmo Voice API resides in two geographic data centers. Phone numbers are associated with the closest data center, either US East Coast or Singapore. API requests are routed to the closest data center to the requesting client. However, a call currently only exists in a single region, this means that if you are receiving a call on a number connected to Singapore but making an API request from a server hosted in the US it will return a 404.

You can work around this issue by sending your API request to the correct region, either:

* https://api-us-1.nexmo.com
* https://api-sg-1.nexmo.com

## Capacity

As standard the Voice API has the following capacity limitations:

1. Maximum of 3 outgoing calls per second created either via the REST API or using the `connect` action within another call.
2. Maximum of 15 requests per second to the REST API (excluding create calls).

If you exceed these limits you will receive an HTTP 429 response or a webhook to your `event_url` with an error.

## Error events

The Nexmo Voice API sends error events to the `event_url` associated with the application. For example, when we encounter an invalid NCCO or an outbound call failure.
