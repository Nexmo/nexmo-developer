---
title: Numbers
description: the key concepts of using phone numbers in the nexmo voice API
navigation_weight: 1
---

# Numbers

## Overview

Numbers are key to using the Nexmo Voice API, the following points should be considered:

### Formatting

Within the Nexmo Voice API all numbers are in e.164 format, that is the full international format without a `+` or international access code eg `00` or `001` and no spaces or other characters eg `()-.`
For example a US number would look like `14155550101` a UK number would be `447700900123`
If you are unsure how to format the number our Number Insight API can help you with this

### Outgoing CallerID

When making an outbound call from Nexmo the CallerID (from) value needs to be a Nexmo number associated with your account, it does not have to be linked to the applicaiton you are using just part of your account. If you set it to any other value then it will be replaced with `unknown` to the recipient.


### Incomming CallerID

We endevour to present to you the caller ID of the party calling your nexmo applicaiton in international format, however this can occasionally be incorrectly formatted by the originating network, we pass through the value we receive from our number suppliers


### Incomming Call Numbers 

Nexmo offers incomming numbers in many countries around the world for rental, in some contries the numbers may be enabled for SMS or Voice only or in others they will support both. We also have numbers in both 'landline' and 'mobile'  ranges for many countries.
You can search for and rent an avalible number via the Dashboard or the Nexmo CLI tool.
To use a number you have rented from nexmo with your voice applicaiton you need to link that number to the application again either via the dashboard or the CLI Tool.
You can link multiple incomming numbers to the same applicaiton, the called number will be passed to your webhook.
