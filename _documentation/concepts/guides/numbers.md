---
title: Numbers
---

# Numbers

Nexmo allows you to rent virtual phone numbers in 80+ countries for use with our SMS, Voice API and [SIP] products. You will need to get a Nexmo number for the following use cases:

* Making or receiving phone calls.
* Receiving text messages.
* Forwarding to [SIP].

Numbers have a variety of capabilities: they either support SMS only, voice only, or both. Number availbility in countries differs and you should make sure that you have a number that matches the requirements of your users. Geographical numbers (with an area code tying it to a local area) are available as well as non-geographical numbers that users may associate with calling cellular devices.

For legal and compliance reasons, some numbers are only available by special request and may require proof of identity. If you need a number for a specific purpose that is not available for sale via the Dashboard or API, contact [support@nexmo.com](mailto:support@nexmo.com)

The Nexmo Help site has a [list of country-specific features and restrictions](https://help.nexmo.com/hc/en-us/sections/200622473-Country-Specific-Features-and-Restrictions) that is kept up-to-date with details of number feature availability in different countries Nexmo supports.

## Buying a number

You can search for and buy a number on the [Nexmo Dashboard](https://dashboard.nexmo.com) or purchase numbers using the API or via the Nexmo CLI tool.

To buy a number, firstly you need to search for a number:

```tabbed_content
source: '_examples/concepts/buy-a-number-search'
```

Once you have found a number to purchase, you can then add it to your account:

```tabbed_content
source: '_examples/concepts/buy-a-number-purchase'
```

## Linking a number to an app

Once you have [created an application](/concepts/guides/applications), you can link the number you have created to an application:

```tabbed_examples
source: '_examples/api/developer/numbers/link-number-to-app'
```

## Linking a number to another phone number

You can redirect voice calls made to your number to another phone number as follows:

```tabbed_examples
source: '_examples/api/developer/numbers/link-number-to-tel'
```

[SIP]: /voice/sip/overview
