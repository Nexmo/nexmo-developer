---
title: Buy a phone number
description: Buy a phone number
---

## Buy a phone number

To handle inbound calls to your application, you need a number from Nexmo. If you already have a number to use, jump to the next section to associate the existing number with your application.

You can use the [Nexmo CLI](https://github.com/nexmo/nexmo-cli) to buy the phone number:

```bash
nexmo number:buy --country_code GB --confirm
Number purchased: 441632960960
```

The `number:buy` command allows you to specify which country the number should be in, using [ISO 3166-1 alpha-2 format](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). By specifying `--confirm` as well, we don't need to confirm the choice of number, the first available one will be purchased.


Now you can set up the phone number to point to the application you created earlier.
