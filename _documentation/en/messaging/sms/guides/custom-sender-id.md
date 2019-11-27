---
title: Sender identity
description: How to change where your SMS appears to come from.
navigation_weight: 1
---

# Sender Identity

Your messages will appear to be sent from any allowed value you enter in the `from` parameter of the request. You might want to use this capability to better represent your brand and maximize readership and response rates.

However, there are limitations on what this parameter can contain. You should also be aware that a message recipient can only respond if the `from` parameter contains a valid mobile number which is able to accept inbound SMS.

> Please note that Nexmo expressly prohibits [SMS spoofing](https://en.wikipedia.org/wiki/SMS_spoofing) where the Sender ID is used to impersonate another person, company or product.

## Valid 

The `from` parameter in the request can only contain numeric or alphanumeric values that obey certain rules: 

* **Numeric**
    * Must be a telephone number of up to 15 digits
    * Must be in [international format](/concepts/guides/glossary#number-format)
    * Cannot include the leading `+` or `00`
* **Alphanumeric**
    * Must be a string of up to 11 ^[supported characters](abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789).
    * Cannot contain spaces

> **Note**: If the value in your `from` parameter does not obey these rules it might be modified in transit or not delivered at all.

## Country-specific considerations

Some countries impose further limitations on where your message appears to be sent from, such as:

* It must be a virtual number
* Your stated phone number might be replaced by a [short code](https://en.wikipedia.org/wiki/Short_code)

If your SMS does not appear to come from a valid telephone number, you might:

* Have your sender details changed by SMS filtering
* Only be allowed to send SMS at certain times of the day
* Be required to implement a [STOP system](https://developer.nexmo.com/api/sms/us-short-codes/alerts/subscription) if your SMS is for marketing purposes 

Before you start your messaging campaign:

1. Check the `SenderID` column for the target country in [this document](https://help.nexmo.com/hc/en-us/articles/115011781468).
2. Send your all your messages to numbers in the same country in a batch and set your sender identity to match what that country allows.



