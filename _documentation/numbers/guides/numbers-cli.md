---
title: Manage Numbers with the Nexmo CLI
description: Rent, configure and manage your number inventory using the Nexmo CLI
navigation_weight: 2
---

# Manage Numbers with the Nexmo CLI

You can use the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) to perform the following operations:

* [List your numbers](#list-your-numbers)
* [Search for new numbers](#search-for-new-numbers)
* [Rent a number](#rent-a-number)
* [Update a number](#update-a-number)
* [Cancel a number](#cancel-a-number)

Read the [installation instructions](https://github.com/Nexmo/nexmo-cli#installation) to get started.

## List your numbers

The `nexmo numbers:list` command lists all the numbers owned by the  account.

Optional flags are:

| Flag | Description |
|---|---|
| `--size`  | The number of results to return  |
| `--page` | The number of results per page  |
| `--pattern` | The pattern you want to search for. Use the `*` wildcard to match the start or end of the number. For example, `*123*` matches all numbers that contain the pattern `123`.  |

Aliases: `nexmo nl`, `nexmo numbers` and `nexmo number:list`.

```
> nexmo numbers:list
31555555555
44655555555
44555555555

> nexmo numbers:list --verbose
Item 1-3 of 3

msisdn      | country | type       | features  | voiceCallbackType | voiceCallbackValue | moHttpUrl | voiceStatusCallbackUrl
----------------------------------------------------------------------------------------------------------------------------
31555555555 | NL      | mobile-lvn | VOICE,SMS | app               | b6d9f957           | undefined | https://example.com
44655555555 | GB      | mobile-lvn | VOICE,SMS | app               | b6d9f957           | undefined | https://example.com
44555555555 | GB      | mobile-lvn | SMS       | app               | b6d9f957           | undefined | https://example.com
```

## Search for new numbers

Use the `nexmo number:search` command to list numbers available for purchase.

Optional flags are:

| Flag | Description |
|---|---|
| `--pattern` | The pattern you want to search for. Use the `*` wildcard to match the start or end of the number. For example, `*123*` matches all numbers that contain the pattern `123`.  |
| `--voice` | To search for voice-enabled numbers |
| `--sms` | To search for SMS-enabled numbers |
| `--size` | The number of results to return |
| `--page` | The number of results per page |

Aliases: `nexmo ns` and `nexmo numbers:search`.

```
> nexmo number:search US
12057200555
12069396555
12069396555
12155961555

> nexmo number:search NL --sms --pattern *007 --verbose
msisdn      | country | cost | type       | features
-----------------------------------------------------
31655551007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
31655552007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
31655553007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
```

## Rent a number

Use the `nexmo number:buy` command to rent an available number. You will be prompted to confirm the purchase.

You must specify **either**:

* The `number` you want to rent
* The `country_code` and `pattern` to automatically select any matching available number

Aliases: `nexmo nb` and `nexmo numbers:buy`.

```
> nexmo number:buy 12069396555
Buying 12069396555\. This operation will charge your account.

Please type "confirm" to continue: confirm

Number purchased

> nexmo number:buy US *555
Buying 12069396555\. This operation will charge your account.

Please type "confirm" to continue: confirm

Number purchased: 12069396555

> nexmo number:buy 12069396555 --confirm
Number purchased: 12069396555
```

## Update a number

Use the `nexmo number:update` command to update the voice properties of the specified number. 

Aliases: `nexmo nu` and `nexmo numbers:update`.

> **Note**: To change the application ID, linked phone number, SIP URI or webhooks you can use the `nexmo link` command instead, as [described here](https://github.com/Nexmo/nexmo-cli#linking).

```
> nexmo number:update 445555555555 --voice_callback_type app --voice_callback_value asdasdas-asdd-2344-2344-asdasdasd345
--voice_callback_status https://example.com/webhooks/status
Number updated
```

## Cancel a number

Use the `nexmo number:cancel` command to cancel an existing number on your account. You must specify the number you wish to cancel and you will be prompted to confirm cancellation before the number is removed from your account.

Aliases: `nexmo nc` and `nexmo numbers:cancel`.

```
> nexmo number:cancel 12069396555
This is operation can not be reversed.

Please type "confirm" to continue: confirm

Number cancelled: 12069396555

> nexmo number:cancel 12069396555 --confirm
Number cancelled: 12069396555
```