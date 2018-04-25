---
title: Troubleshooting
navigation_weight: 9
---


# Troubleshooting

## Overview
The Nexmo Voice API offers a highly availble service, however due to the nature of providing service across hunderouds of phone carriers around the world occasionally problems may arise that are outside of our control. In addition there are certain limitations placed on us by our partner networks which can have an impact on how you application functions. 
While not exhaustive here are a few things to look for if  you are experiencing problems

## Timeouts
When Nexmo sends a webhook to your answer URL it expects the server to respond in a certain timeframe.

The TCP connection should be established within 3 seconds
The HTTP response (NCCO) should be returned within 5 seconds

If Nexmo does not get a response in these times it will retry the request.

## Regions

The Nexmo Voice API resides in 2 geographic datacentres, phone numbers are assocaited with the closet datacentre, either US East Coast or Singapore. APi requests are routed to the closest data centre to the requesting client. However a call currently only exists in a single region, this means that if you are recieving a call on a number connected to Singaport but making an API request from a server hosted in the US it will return a 404.

You can work around this issue by sending your API request to the correct region, either:

* https://api-us-1.nexmo.com
* https://api-sg-1.nexmo.com

## Capacity

As standard the Voice API has the following capacity limitations:

Maximum of 3 outgoing calls per second created either via the REST API or using the `connect` action wihin another call.

Maximum of 15 requests per second to the REST API (excluding create calls)

If you exceed these limits you will recieve an HTTP 429 response or a webhook to your eventURL with an error.


## Error Events

The Nexmo Voice API sends error events to the Event URl associated with the applicaiton, for example an invalid NCCO or an outbound call failure.