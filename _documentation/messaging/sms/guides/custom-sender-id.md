---
title: Custom Sender ID
---

# Custom Sender ID

The Sender ID is the number or text shown on a handset when it displays a message. You set a custom Sender ID to better represent your brand.

## Overview

The Sender ID can be either:

* **Numeric** - up to a 15 digit telephone number in international format without a leading `+` or `00`
* **Alphanumeric** - an 11 character string of ^[supported characters](abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789).

> Note: Using other characters may result in failed delivery or an altered Sender ID.

## Country specific

Depending on the jurisdiction one or more of the following can happen:

* Your Sender ID must be a virtual number.
* SMS filtering is applied and the Sender ID is modified.
* Numeric-only Sender IDs are replaced by short codes.
* You can only send traffic in a limited time window.
* For marketing traffic you have to implement a STOP system.

Before you start your messaging campaign:

1. Check the Sender ID columns in the [Country Specific Features](country-specific-features).
2. Batch send your messages to each country and set `from` to match the Sender ID capabilities.

## SMS Spoofing

Illegitimate use of [SMS spoofing](https://en.wikipedia.org/wiki/SMS_spoofing) such as impersonating another person, company or product is strictly forbidden.
