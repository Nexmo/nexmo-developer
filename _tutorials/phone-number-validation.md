---
title: Phone number validation
products: number-insight
description: By asking your customer to provide a phone number — and then validating the legitimacy of that number — you minimize fraud and ensure that you can easily contact that customer in the future.
languages:
    - Ruby
---

# Phone number validation

By asking your customer to provide a phone number — and then validating the legitimacy of that number — you minimize fraud and ensure that you can easily contact that customer in the future. Using Number Insight you also distinguish mobile from landline numbers and ensure that you only send text messages to mobile phone numbers.

Number Insight has three product levels:

* Number Insight Basic API - retrieve local and international representations of a phone number in order to pretty-print numbers in a user interface
* Number Insight Standard API - use all the features from the Number Insight Basic API and identify the network a phone number is registered with
* Number Insight Advanced API - use all the features from the Number Insight Standard API and retrieve roaming information about a mobile phone number

The *Nexmo REST API client for Ruby* combines requests to the Number Insight API and the Developer API. As well as validating and sanitizing a phone number, you can confirm the cost of sending text messages and voice calls to it.

## In this tutorial

You see how easy it is to sanitize and validate phone numbers using the Nexmo APIs and libraries:

* [Install the library](#install-the-library) so you can use the *Nexmo REST API client for Ruby* to make calls to the Number Insight API
* [Determine the country](#determine-the-country) a phone number is registered in
* [Sanitize](#sanitize) a local phone number and determine the international version
* [Calculate the cost](#calculate-the-cost) of calling or messaging a phone number
* [Determine the type](#determine-the-type) of phone number: mobile or landline
* [Validate a mobile phone number](#validate-a-mobile-phone-number) and find out if it is real, active or roaming

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The source code from [https://github.com/Nexmo/ruby-ni-customer-number-validation](https://github.com/Nexmo/ruby-ni-customer-number-validation)

## Install the library

After you have created a project, add the *Nexmo REST API client for Ruby*.

**Gemfile**

```ruby
gem 'nexmo', '~> 5.0'
```

Set the `NEXMO_API_KEY` and `NEXMO_API_SECRET` environmental variables to initialize the library:

```ruby
# Initialize nexmo with the
# NEXMO_API_KEY and
# NEXMO_API_SECRET environment
# variables
require 'nexmo'
nexmo = Nexmo::Client.new(
  api_key: ENV['NEXMO_API_KEY'],
  api_secret: ENV['NEXMO_API_SECRET']
)
```

## Determine the country

To retrieve country information about a phone number:

```ruby
# Perform a  Number Insight
# basic inquiry
p nexmo.number_insight.basic(
  number:  "442079460000"
)
```

This returns the phone number in international format as well as the name, code, and prefix for the country the phone number is registered in.

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

Requests to the Number Insight Basic API are free. See the [API reference](/api/number-insight) for more information.

##Sanitize

Your user may not supply a phone number in international format. That is, with the county code prefix.

To retrieve a phone number in international format, call the Number Insight Basic API with a phone number in local format and a country code:

```ruby
# Perform a  Number Insight
# basic inquiry
insight = nexmo.number_insight.basic(
  number:  "020 7946 0000",
  country: 'GB'
)

p insight.international_format_number
```

And it returns the phone number in international format:

```ruby
"442079460000"
```

You can use the phone number returned in requests to the Nexmo APIs.

Requests to the Number Insight Basic API are free. See the [API reference](/api/number-insight) for more information.

## Calculate the cost

You use a phone number in international format to find out more about the products supplied by Nexmo for that phone number.

To make a request to the Developer API and retrieve the cost of making a voice call or sending an SMS:

```ruby
# Perform a  Number Insight
# basic inquiry
insight = nexmo.number_insight.basic(
  number:  "020 7946 0000",
  country: 'GB'
)

# Fetch the voice and SMS pricing
sms_pricing   = nexmo.get_sms_pricing(
  insight['international_format_number'])
voice_pricing = nexmo.get_voice_pricing(
  insight['international_format_number'])

p({
  sms: sms_pricing,
  voice: voice_pricing
})
```

The response includes the cost to send an SMS message or the price-per-minute for a voice call to the phone number:

```ruby
{
      :sms => {
             "network" => "GB-FIXED",
               "phone" => "442079460000",
        "country-code" => "GB",
               "price" => "0.03330000"
    },
    :voice => {
             "network" => "GB-FIXED",
               "phone" => "442079460000",
        "country-code" => "GB",
               "price" => "0.01200000"
    }
}
```

See the [API reference](/api/developer/account#pricing) for more information about the Developer API.

## Determine the type

The Number Insight Standard API supplies a lot more information about a phone number. One of the most useful features is to to determine the type of number you are dealing with:

```ruby
# Perform a Number Insight
# standard inquiry
insight = nexmo.number_insight.standard(
  number:  "020 7946 0000",
  country: 'GB'
)

p insight.current_carrier
```

You see that this phone number is assigned to a UK landline:

```ruby
{
    "network_code" => "GB-FIXED",
            "name" => "United Kingdom Landline",
         "country" => "GB",
    "network_type" => "landline"
}
```

Requests to the Number Insight Standard API are not free. See the [API reference](/api/number-insight) for more information.

## Validate a mobile phone number

The Number Insight Advanced API is a really powerful API. For mobile phone numbers, the Number Insight Advanced API makes an active inquiry to see if the phone number you provide is valid, active, roaming, and much more.

To see if a phone number is valid:

```ruby
# Perform a  Number Insight
# basic inquiry
insight = nexmo.number_insight.advanced(
  number:  "020 7946 0000",
  country: 'GB'
)

p insight.valid_number
```

In this case the number is valid.

```ruby
"valid"
```

If you removing a few digits from the phone number:

```ruby
"valid"
```

You receive an invalid or unknown response:

```ruby
"unknown"
```

Requests to Number Insight Advanced API are not free. See the [API reference](/api/number-insight) for more information.

## Conclusion

That's it. You can validate, retrieve the international format for, and calculate the cost for sending SMS or phone calls to a phone number.

## Resources

* [Number Insight API guides](/number-insight)
