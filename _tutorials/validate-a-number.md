---
title: Validate a number
products: number-insight
description: Use the Number Insight and Developer API from Ruby code to validate, sanitize and determine the cost to call or message a number.
languages:
    - Ruby
---

# Validate a number

The Number Insight API helps you validate numbers that customers provide to prevent fraud and ensure that you can contact that customer again in the future. It also provides you with other useful information such as how to format the number and whether the number is a mobile or landline.

The Number Insight API has three product levels:

* Basic API: Discover which country a number belongs to and use the information to format the number correctly.
* Standard API: Determine whether a number is a landline or mobile number (to choose between voice and SMS contact) and block virtual numbers.
* Advanced API: Calculate the risk associated with a number.

> Find out more about the [basic, standard and advanced APIs](/number-insight/overview#basic-standard-and-advanced-apis).
> **Note**: Requests to the Number Insight Basic API are free. The other API levels incur costs. See the [API reference](/api/number-insight) for more information.

The [Nexmo Ruby](http://github.com/nexmo/nexmo-ruby) REST API client library makes it easy to access the Number Insight API. It also enables you to work with the other APIs, such as the Pricing API. This means that as well as validating and sanitizing a phone number, you can confirm the cost of sending text messages and voice calls to it, as we demonstrate in the [calculate the cost](#calculate-the-cost) section of this tutorial.

## In this tutorial

You learn how to sanitize and validate phone numbers using the Nexmo REST API client for Ruby.

* [Before you begin](#before-you-begin) make sure that you have what you need to complete this tutorial
* [Create the project](#create-the-project) by cloning the tutorial source code on GitHub and configuring it with your Nexmo account details
* [Install the dependencies](#install-the-dependencies) including the Ruby REST API client
* [Code walkthrough](#code-walkthrough) to learn how the code works

## Before you begin

To complete this tutorial you need:

* Your `api_key` and `api_secret` for your [Nexmo account](https://dashboard.nexmo.com/sign-up) - sign up for an account if you do not already have one
* Access to the [tutorial source code](https://github.com/Nexmo/ruby-ni-customer-number-validation) on GitHub

## Create the project

Clone the [tutorial source code](https://github.com/Nexmo/ruby-ni-customer-number-validation) repository:

```
git clone git@github.com:Nexmo/ruby-ni-customer-number-validation.git
```

Change to the project folder:

```
cd ruby-ni-customer-number-validation
```

Copy the `.env-example` file to `.env` and edit `.env` to configure your API key and secret from the [Nexmo Developer dashboard](https://dashboard.nexmo.com):

```
NEXMO_API_KEY="(Your API key)"
NEXMO_API_SECRET="(Your API secret)"
```

## Install the dependencies

Run `bundle install` to install the project's dependencies.

```ruby
$ bundle install
Fetching gem metadata from https://rubygems.org/...
Resolving dependencies...
Using bundler 1.16.4
Using dotenv 2.1.1
Using jwt 2.1.0
Using nexmo 5.4.0
Bundle complete! 2 Gemfile dependencies, 4 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

## Code Walkthrough

The tutorial project is not an application, but a collection of code snippets that show you how to work with the Number Insight API. In this walkthrough you will execute each snippet in turn and learn how it works.

### Determine the country

This sample uses the Number Insight Basic API to find out which country a number belongs to.

#### Run the code

Execute the `snippets/1_country_code.rb` ruby file:

```
$ ruby snippets/1_country_code.rb
```

This returns the phone number in international format as well as the name, code and prefix where the number is registered.

```ruby
{
    "status" => 0,
    "status_message" => "Success",
    "request_id" => "923c7054-3201-4146-b6df-23bfe929cd03",
    "international_format_number" => "442079460000",
    "national_format_number" => "020 7946 0000",
    "country_code" => "GB",
    "country_code_iso3" => "GBR",
    "country_name" => "United Kingdom",
    "country_prefix" => "44"
}
```

#### How it works

First, the code creates the `nexmo` client object with the API key and secret that you configured in the `.env` file:

```ruby
require 'nexmo'
nexmo = Nexmo::Client.new(
  api_key: ENV['NEXMO_API_KEY'],
  api_secret: ENV['NEXMO_API_SECRET']
)
```

Then, it calls the Number Insight Basic API, passing in the `number` to provide insight about:

```ruby
puts nexmo.number_insight.basic(number:  "442079460000")
```

### Sanitize a Number

Your user might supply a phone number that is not in international format. That is, it does not include the country prefix. This sample shows you how to use the Number Insight Basic API to format the number correctly.

> Most Nexmo APIs expect a phone number to be in international format, so you can use the Number Insight Basic API to sanitize numbers before using them.

#### Run the code

Execute the `snippets/2_cleanup.rb` ruby file:

```
$ ruby snippets/2_cleanup.rb
```

This returns the local number provided (`020 3198 0560`, a Great Britain (`GB`) number) in international format with the `44` prefix:

```
"442031980560"
```

#### How it works

To retrieve a phone number in international format, call the Number Insight Basic API with a phone number in local format and a country code:

```ruby
insight = nexmo.number_insight.basic(
  number:  "020 3198 0560",
  country: 'GB'
)

p insight.international_format_number
```

### Determine the type of number (landline or mobile)

The Number Insight Standard API supplies more information about a phone number than the Basic API but includes all the data that the Basic API provides. One of its most useful features is that it tells you _type_ of number you are dealing with, so that you can determine the best way to contact the number.

#### Run the code

Execute the `snippets/3_channels.rb` ruby file:

```
$ ruby snippets/3_channels.rb
```

You see that this phone number is assigned to a UK landline, making voice a better option than SMS:

```ruby
{
    "network_code" => "GB-FIXED",
            "name" => "United Kingdom Landline",
         "country" => "GB",
    "network_type" => "landline"
}
```

#### How it works

To determine the type of number, call the Number Insight Standard API, passing in either a local number with the country code as we demonstrate here:

```ruby
insight = nexmo.number_insight.standard(
  number:  "020 3198 0560",
  country: 'GB'
)
```

You could also pass the `number` in international format without specifying the `country`:

```ruby
insight = nexmo.number_insight.standard(
  number:  "442031980560"
)
```

Then we can find the current carrier information and use it to display the type of number (mobile or landline):

```ruby
p insight.current_carrier
```

### Calculate the cost

You can use the Number Insight APIs and [Pricing](/api/developer/pricing) APIs together to determine which network the number is on and how much it costs to call the number, or send an SMS to it.

#### Run the code

Execute the `snippets/4_cost.rb` ruby file:

```
$ ruby snippets/4_cost.rb
```

The response indicates the cost to send an SMS message or the price-per-minute for a voice call to the phone number:

```ruby
{
      :sms => [{
                "type" => "landline",
               "price" => "0.03330000",
            "currency" => "EUR",
              "ranges" => [441, 442, 443],
        "network_code" => "GB-FIXED",
        "network_name" => "United Kingdom Landline"}],
    :voice => [{
               "type" => "landline",
              "price" => "0.01200000",
           "currency" => "EUR",
             "ranges" => [441, 442, 443],
       "network_code" => "GB-FIXED",
       "network_name" => "United Kingdom Landline"}]
}
```

This output shows that the number is a landline and therefore best suited to voice calls, which you can make at a cost of 0.12 EUR per minute.

#### How it works

The code first calls the Number Insight Standard API, which provides information about the network the number is currently registered to, as well as the country of origin (a feature that is also available in the Basic API):

```ruby
insight = nexmo.number_insight.standard(
  number:  '020 3198 0560',
  country: 'GB'
)

# Store the network and country codes
current_network = insight.current_carrier.network_code
current_country = insight.country_code
```

It then uses the [Pricing](/api/developer/pricing) API to retrieve the cost of calling and texting the number for all the carriers in that country:

```ruby
# Fetch the voice and SMS pricing data for the country
sms_pricing = nexmo.pricing.sms.get(current_country)
voice_pricing = nexmo.pricing.voice.get(current_country)
```

Other options for retrieving pricing data in the Ruby REST Client API are:

- `nexmo.pricing.sms.list()` or `nexmo.pricing.voice.list()` - to retrieve pricing data for _all_ countries
- `nexmo.pricing.sms.prefix(prefix)` or `nexmo.pricing.voice.prefix(prefix)` - to retrieve pricing data for a specific international prefix code, such as `44` for the United Kingdom.

The code then looks up the cost for the specific network that the number belongs to and displays that information:

```ruby
# Retrieve the network cost from the pricing data
sms_cost = sms_pricing.networks.select{|network| network.network_code == current_network}
voice_cost = voice_pricing.networks.select{|network| network.network_code == current_network}

p({
  sms: sms_cost,
  voice: voice_cost
})
```

### Validate a mobile phone number

The Number Insight Advanced API enables you to validate a number to determine if it is likely to be genuine and a reliable way to contact your customer. For mobile numbers, you can also discover whether the number is active, roaming, reachable and in the same location as their IP address. The Advanced API includes all the information from the Basic and Standard APIs.

#### Run the code

Execute the `snippets/5_validation.rb` ruby file:

```
$ ruby snippets/5_validation.rb
```

In this case the response indicates that the number is `valid`.

```ruby
"valid"
```

If you remove a few digits from the phone number and re-run the program, the Number Insight Advanced API reports that the number is `not_valid`.

```ruby
"not_valid"
```

If the Number Insight Advanced API is unable to determine whether the number is valid or not, you will receive a response of `unknown`:

```ruby
"unknown"
```

#### How it works

The code requests the international representation of the number as before, using a feature that is available in the Basic API but which the Advanced API also includes:

```ruby
insight = nexmo.number_insight.advanced(
  number:  "020 3198 0560",
  country: 'GB'
)
```

It also returns and displays the `valid_number` field from the response. This field's value is one of `valid`, `not_valid` or `unknown`.

```ruby
p insight.valid_number
```

## Conclusion

In this tutorial you learned how to validate and determine the international format of a number and calculate the cost of calling or sending SMS messages to it.

## Resources and Further Reading

- Check out our [Number Insight Guides](/number-insight) for more things you can do with Number Insight.
- Read [Blog Posts](https://www.nexmo.com/?s=number+insight) about Number Insight.
- Visit the [Number Insight API Reference](/api/number-insight) for detailed documentation on each endpoint.
