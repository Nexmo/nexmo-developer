---
title: Using Number Insight via the Nexmo CLI
description: Use the Nexmo CLI to get information about a phone number.
navigation_weight: 3
---

# Using Number Insight via the Nexmo CLI

## Overview

You can use the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) to work with the Number Insight API without having to create the requests using `curl` or by writing program code. This guide shows you how.

## Getting Started

### Before you begin:

* Sign up for a [Nexmo account](https://dashboard.nexmo.com/signup) - this will give you the API key and secret that you will need to access the Number Insight API.
* Install [Node.JS](https://nodejs.org/en/download/) - you will use `npm` (the Node Package Manager) to install the Nexmo CLI.

### Install and Setup the Nexmo CLI (Command Line Interface)

Execute the following command at a terminal prompt to install the Nexmo CLI:

```bash
$ npm install -g nexmo-cli
```

> *Note*: If you do not have sufficient system privileges you might need to prefix the above command with `sudo`.

Then, provide the Nexmo CLI with your `NEXMO_API_KEY` and `NEXMO_API_SECRET` which you can 
find on the [dashboard getting started page](https://dashboard.nexmo.com/getting-started-guide):

```bash
$ nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```

You only need to do this the first time you use the Nexmo CLI.

## Try your own number with the Basic API

The Number Insight Basic API is free to use. Test it with your own number by using `nexmo insight:basic` (or `nexmo ib`) and replacing the number shown with your own number. The number must be in [international format](/voice/voice-api/guides/numbers#formatting):

```bash
$ nexmo insight:basic 447700900000
```

The Nexmo CLI displays the number you entered and the country it belongs to:

```bash
447700900000 | GB
```

To see the other details that the response from the Number Insight API contains, use the `--verbose` switch (or `-v` for short):

```bash
$ nexmo insight:basic --verbose 447700900000
```

The full response from the Basic API contains the following information:

````
[status]
0

[status_message]
Success

[request_id]
385bf642-d096-4b85-9dfc-4c1910d65300

[international_format_number]
447700900000

[national_format_number]
07700 900000

[country_code]
GB

[country_code_iso3]
GBR

[country_name]
United Kingdom

[country_prefix]
44
````

This human-readable output mirrors the field names and data available in the JSON response: it returns data about your request (`status`, `status_message`, `request_id`), details of the country that the number belongs to (`country_name`, `country_prefix` etc.) and how to format the number appropriately for that country (`national_format_number`).

> If you do not see a response similar to that shown above, check your API credentials and ensure that you have installed Node.js and `nexmo-cli` properly.

## Test the Standard and Advanced APIs

The Standard and Advanced Number Insight APIs provide even more information about the number including details of the operator and roaming status (for mobile numbers). See the [feature comparison table](/number-insight/overview#basic-standard-and-advanced-apis) to see the response data that each API level includes.

> **Note**: Calls to the Standard and Advanced APIs are not free, and you will be asked to confirm that you wish to charge your account when you use them.

### Using the Number Insight Standard API

To use the Number Insight Standard API, use `nexmo insight:standard` (or `nexmo is`). 

```bash
$ nexmo insight:standard --verbose 447700900000
```

A typical response from the Standard API looks like this:

````
[status]
0

[status_message]
Success

[request_id]
aaaaaaaa-bbbb-cccc-dddd-0123456789ab

[international_format_number]
447700900000

[national_format_number]
07700 900000

[country_code]
GB

[country_code_iso3]
GBR

[country_name]
United Kingdom

[country_prefix]
44

[request_price]
0.00500000

[remaining_balance]
1.995

[current_carrier.network_code]
23420

[current_carrier.name]
Hutchison 3G Ltd

[current_carrier.country]
GB

[current_carrier.network_type]
mobile

[original_carrier.network_code]
23410

[original_carrier.name]
Telefonica UK Limited

[original_carrier.country]
GB

[original_carrier.network_type]
mobile

[ported]
assumed_ported
````

### Using the Number Insight Advanced API

To use the Advanced API, use `insight:advanced` (or `ia`):

```bash
$ nexmo insight:advanced --verbose 447700900000
```

Look for the following additional fields in the response:

````
[lookup_outcome]
0

[lookup_outcome_message]
Success

[valid_number]
valid

[reachable]
reachable

[roaming.status]
not_roaming
````

The `[lookup_outcome]` and `[lookup_outcome_message]` fields tell you whether the Advanced API was able to determine the validity (`[valid_number]`), reachability (``[reachable]``) and roaming status (``[roaming.status]``) of the number.
