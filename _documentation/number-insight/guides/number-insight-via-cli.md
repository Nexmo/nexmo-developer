---
title: Using Number Insight via the Nexmo CLI
---

# Using Number Insight via the Nexmo CLI

[Nexmo CLI](https://github.com/Nexmo/nexmo-cli) allows you to try out the Number Insight API.

## Getting Started

Before you begin:

* Sign up for a [Nexmo account](https://dashboard.nexmo.com/signup)
* Install [Node.JS](https://nodejs.org/en/download/)

> *Note*: If you do not wish to install Node in order to use the [Nexmo CLI](/tools) you can also create applications using the [Application API](/concepts/guides/applications)*

Install and Setup the Nexmo CLI (Command Line Interface)

Install the Nexmo CLI:

```bash
$ npm install -g nexmo-cli
```

> *Note*: Depending on your system setup you may need to prefix the above command with `sudo`*

Using your Nexmo `API_KEY` and `API_SECRET`, available from the [dashboard getting started page](https://dashboard.nexmo.com/getting-started-guide), you now setup the CLI with these credentials.

```bash
$ nexmo setup API_KEY API_SECRET
```

## Try your own number

The Number Insight Basic API is free to use. You can test it from the CLI using `nexmo insight:basic` (or `nexmo ib`):

```bash
$ nexmo insight:basic 447700900000
```

The response will list the number along with the country the number is located in:

```bash
447700900000 | GB
```

You can get fuller details of what's contained in the API response by using the `--verbose` flag (or `-v` for short):

```bash
$ nexmo insight:basic --verbose 447700900000
```

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
````

This human readable output mirrors the field names and data available in the JSON response: it gives you back some data about your request (`status`, `status_message`, `request_id`) and details of the country of the number (`country_name`, `country_prefix` etc.) and how to format the number appropriately for that country (`national_format_number`).

If you are not getting a response using the Number Insight Basic API, you may need to check your API credentials and ensure that you have set up Node.js and `nexmo-cli` properly.

## Test the Standard or Advanced API

Once you have checked to make sure a call to the free Number Insight Basic API has worked, you can use the Standard or Advanced APIs, which provide more detail about the number including details of mobile operator, roaming status and so on (see the [Overview](/number-insight/overview) for a comparison table showing the difference between the various products).

To test using the Number Insight Standard API, use `nexmo insight:standard` (or `nexmo is`). To use the Advanced API, use `insight:advanced` (or `ia`).

```bash
$ nexmo insight:standard --verbose 447700900000
```

The response will look like this:

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
