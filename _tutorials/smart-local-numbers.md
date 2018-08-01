---
title: Smart local numbers
products: voice/voice-api
description: "Replace your toll-free numbers (e.g. 800, 0800) with easy to use, smart local numbers that allow you to provide a better customer service."
languages:
    - Ruby
---

# Voice - Smart Local Numbers

While toll-free numbers can be expensive, they're also one of the least personal ways to provide a customer with a way to reach you. So with that in mind, we're going to replace your expensive toll-free number with multiple localized regional numbers. This will allow you to give your customers a friendly local number to dial while saving you on expensive toll-free number rental costs.

Additionally, with the power of local numbers, we will show you how you can take some smart steps to provide a more bespoke experience for anyone dialled in, while simultaneously collecting valuable information about your customer's ever changing requirements.

## In this tutorial

We will be creating an application for a fake transit authority, allowing users to dial in with a local number, instantly getting an update on their local transit system, and additionally allowing them to get an update on other cities as well.

* [Create a Voice Application](#create-a-voice-application) - Create a voice application using the Nexmo CLI and configuring answer and event webhook endpoints
* [Buy Phone Numbers](#buy-phone-numbers) - Buy multiple, local numbers for the inbound calls
* [Link the Phone Numbers to a Nexmo Application](#link-the-phone-numbers-to-a-nexmo-application) - Configure the voice enabled phone numbers to be associated with your Voice Application
* [Create a Web Server](#create-a-web-server) - Create a webserver that can handle calls coming in
* [Receive an Inbound Local Phone Call](#receive-an-inbound-phone-call) - Use your webhook endpoint to handle an incoming voice call
* [Prompt for Other Localities](#prompt-for-other-localities) - Use a menu to allow someone to also get information on other localities as if they had dialled from a different number

## Prerequisites

In order to work through this tutorial you'll need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up
* A publicly accessible web server so Nexmo can make webhook requests to your app. If you're developing locally use a tool such as [ngrok](https://ngrok.com/) to help you accept webhooks in your local development environment.
* Some knowledge of Ruby and the [Sinatra](http://www.sinatrarb.com/) web framework

## Create a Voice Application

To create a voice application within the Nexmo platform you execute the following command.

```bash
$ nexmo app:create "Transit Authority" https://example.com/answer https://example.com/event --save app.key
Application created: aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

"Transit Authority" is the name of the application and the next parameter is the webhook endpoint that Nexmo will make a request to when a call is made to a number associated with the application. The final parameter is also a webhook endpoint so that Nexmo can inform your application of other events related your Nexmo app.

The output of this command is the Application UUID (Universally Unique IDentifier) and the private key for your app in a new file called `app.key`. While we won't use this key in this application we still recommend you save this for future purposes.

## Buy Phone Numbers

For our application to function you need two or more local numbers. Using our CLI you can search for, and buy, local numbers:

```bash
# A Chicago number
$ nexmo number:buy 1312* --country_code US --confirm
Number purchased: 13120555000
# A San Francisco number
$ nexmo number:buy 1415* --country_code US --confirm
Number purchased: 14150555000
```

*Note: Repeat the step above to buy more numbers for more localities if needed.*

## Link the Phone Numbers to a Nexmo Application

Associate the newly purchased numbers with the application we've created. This ensures that our application's webhook endpoints are informed when the number is called or any event takes place relating to the number.

```bash
$ nexmo link:app 13120555000 5555f9df-05bb-4a99-9427-6e43c83849b8
```

*Note: Repeat the step above for each number that you rented and want to associate to this application*

## Create a Web Server

For this tutorial you require a web server to be running.

**Gemfile**

```ruby
gem 'sinatra'
gem 'json'
```

**app.rb**

```ruby
# We are using the Sinatra Web Framework
require 'sinatra'
require 'json'
```

With that, the basic server is in place.

## Receive an Inbound Phone Call

Whenever someone calls one of the numbers that are linked to the Nexmo application, Nexmo will receive an incoming call. Nexmo will then notify your web application of that call. It does this by making a webhook request to your web app's `answer_url` endpoint.

To start off, we need to know what number maps to what city. In our simplified case we will hard-code this into our application, but in most real environments this will probably come from a database.

**app.rb**

```ruby
# Map our inbound numbers to different cities.
# In a production system this would most likely
# be queried from your database.
locations = {
  '13120555000' => 'Chicago',
  '14150555000' => 'San Francisco',
}

# The current statuses for the transport in the
# different cities.
statuses = {
  'Chicago'       => 'There are minor delays on the L Line. There are no further delays.',
  'San Francisco' => 'There are currently no delays',
  # An extra city that does not have its own local
  # number yet
  'Austin'        => 'There are currently no delays'
}
```

We can now process an incoming call, extract the number dialled, and respond to the user with the current status of the transit in their city.

**app.rb**

```ruby
get '/answer' do
  # We map the number dialled to a location
  location = locations[params['to']]
  # We map the location to the current status
  status = statuses[location]
  # respond to the user
  respond_with(location, status)
end
```

The final step is to reply to the webhook with a set of actions in the form of a [Nexmo Call Control Object (NCCO)](/voice/guides/ncco). These objects tell Nexmo what text to playback to the caller, and what other actions to perform.

**app.rb**

```ruby
def respond_with(location, status)
  content_type :json
  return [
    # A friendly localized welcome message
    {
      'action': 'talk',
      'text': "Current status for the #{location} Transport Authority:"
    },
    # The current transport status for this city
    {
      'action': 'talk',
      'text': status
    }
  ].to_json
end
```

> *Note*: Take a look at the [NCCO reference](/voice/guides/ncco-reference) for information on other actions available.

## Prompt for Other Localities

Finally, we're going to allow a user to ask for details about other cities as well. While in most cases users will probably be happy with the info they received for the city they dialled the local number for, tracking the other cities users request details for might lead to insights into what cities should be provided with local numbers next.

We start by extending our [NCCO](/voice/guides/ncco) with an input menu.

**app.rb**

```ruby
return [
  {
    'action': 'talk',
    'text': "Current status for the #{location} Transport Authority:"
  },
  {
    'action': 'talk',
    'text': status
  },
  # Next, we give the user the option to get the details for other cities as well
  {
    'action': 'talk',
    'text': 'For more info, press 1 for Chicago, 2 for San Francisco, and 3 for Austin. Or hang up to end your call.',
    'bargeIn': true
  },
  # Listen to a user's input play back that city's status
  {
    'action': 'input',
    'eventUrl': ["http://example.com/city"],
    # we give the user a bit more time before we hang up on them
    'timeOut': 10,
    # we only expect one digit
    'maxDigits': 1
  }
].to_json
```

When the user presses a key on their phone, a new webhook is sent to the `/city` endpoint of our application. At this point, we can use that input and play back the local transit status for that city instead.

**app.rb**

```ruby
# This endpoint is called when the user has typed
# a number on their phone to choose a city
post '/city' do
  # We parse the JSON in the request body
  body = JSON.parse(request.body.read)
  # We extract the user's selection, and turn it into a number
  selection = body['dtmf'].to_i
  # We then select the city name and its status from the list
  location = statuses.keys[selection-1]
  status = statuses[location]
  # Finally, we respond to the user in the same way we have done before
  respond_with(location, status)
end
```

> *Tip*: Any selection made in a phone menu could be tracked to measure valuable data about user behaviour and demand in your application

## Conclusion

You have created a voice application, purchased phone numbers and linked them to a Nexmo voice application. You have then built a Smart Local Number application that receives an inbound call, maps the called number to a standard input, and then collects more input from the user to play back further info to them.

## Get the Code

All the code for this tutorial and more is in the [800 Replacement repository on GitHub](https://github.com/Nexmo/800-replacement).

## Resources

* [Voice Guides](/voice)
* [Voice API Reference](/api/voice)
* [NCCO reference](/voice/guides/ncco-reference)
