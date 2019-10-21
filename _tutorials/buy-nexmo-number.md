---
title: Buy a Nexmo number
description: In this step you learn how to purchase a Nexmo number.
---

# Buy a Nexmo number 

## Using the Nexmo Dashboard

First you can browse [your existing numbers](https://dashboard.nexmo.com/your-numbers).

If you have no spare numbers you can [buy one](https://dashboard.nexmo.com/buy-numbers).

## Using the Nexmo CLI

You can purchase a number using the Nexmo CLI. The following command purchases an available number in the US. Specify [an alternate two-character country code](https://www.iban.com/country-codes) to purchase a number in another country.

```
nexmo number:buy -c US --confirm
```

Make a note of the number returned, as you'll need it later.
