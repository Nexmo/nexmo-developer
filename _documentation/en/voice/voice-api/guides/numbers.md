---
title: Numbers
description: Numbers are a key part of using the Vonage Voice API. This guide covers number formatting, outgoing caller IDs and incoming call numbers.
navigation_weight: 2
---

# Numbers

## Overview

Numbers are a key concept to understand when working with the Vonage Voice API. The following points should be considered before developing your Vonage Application.

### Formatting

Within the Vonage Voice API all numbers are in E.164 format. This means that numbers:

* Omit both a leading `+` and the international access code such as `00` or `001`. 
* Contain no special characters, such as a space, `()` or `-`

For example, a US number would have the format `14155550101`. A UK number would have the format `447700900123`. 

If you are unsure how to format the number the Number Insight API can be used to find correct information about a number.

### Outgoing CallerID

When making an outbound call from Vonage the CallerID, `from` value needs to be a Vonage Number associated with your account. Any Vonage number associated with your account will work. It does not have to be linked to the application you are using. If you set it to any other value then `from` is set to `unknown`.


### Incoming CallerID

Vonage attempts to present to you the caller ID of the party calling your Vonage application in international format. However, this can occasionally be incorrectly formatted by the originating network. Vonage passes through the number received from the number supplier. You can learn more about inbound caller ID on our [voice features overview](https://help.nexmo.com/hc/en-us/articles/115011761808) page in the Vonage knowledge base.


### Incoming Call Numbers 

Vonage offers for rental incoming numbers located in many countries around the world. In some countries the numbers may be enabled for SMS or Voice only, or in others they will support both.

Vonage can also provide numbers in both 'landline' and 'mobile' ranges for many countries. You can search for and rent an available number via the Dashboard or the Nexmo CLI tool. 

To use a number you have rented from Vonage with your voice application you need to link that number to the application again either via the Dashboard or the CLI tool. You can link multiple incoming numbers to the same application and the number that was called will be passed to your `answer_url` in the `to` parameter.
