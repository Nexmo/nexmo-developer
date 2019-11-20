---
title: Local Numbers
products: voice/voice-api
description: "Replace your toll-free numbers (e.g. 800, 0800) with local geographical numbers that allow you to provide a better customer service. Users can make cheaper calls and you can offer location-sensitive information when they contact you."
languages:
    - Ruby
---

# Local Numbers for Voice Calls

While toll-free numbers can be expensive, they're also one of the least personal ways to provide a customer with a way to reach you. So with that in mind, we're going to replace your expensive toll-free number with multiple localized regional numbers. This will allow you to give your customers a friendly local number to dial while saving you on expensive toll-free number rental costs.

Additionally, with the power of local numbers, we will show you how you can take some smart steps to provide a more bespoke experience for anyone dialled in, while simultaneously collecting valuable information about your customers' ever-changing requirements.

 In this tutorial you will be creating an application for an imaginary transit authority, allowing users to dial in with a local number, instantly getting an update on their local transit system, and additionally allowing them to get an update on other cities if desired.

## Prerequisites

In order to work through this tutorial you'll need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up
* A publicly accessible web server so Nexmo can make webhook requests to your app. You can learn more about webhooks in our [webhooks guide](/concepts/guides/webhooks) and it includes information on [using ngrok to expose your local webserver](/concepts/guides/webhooks#using-ngrok-for-local-development)
* Some knowledge of Ruby and the [Sinatra](http://www.sinatrarb.com/) web framework

⚓ Create a Voice Application
⚓ Buy Phone Numbers
⚓ Link the Phone Numbers to a Nexmo Application
## Getting Started

We'll start by registering two Nexmo numbers to use with this application. We need two so that we can demonstrate the use of different numbers linking to different locations. Follow the instructions for [getting started with applications](https://developer.nexmo.com/concepts/guides/applications#getting-started-with-applications). This will walk you through buying a number, creating an application, and linking the two (do the buying and linking twice, once for each number).

You will need to give the `answer_url` of your publicly-accessible webserver or ngrok endpoint when you configure your application, this should be `[YOUR_URL]/answer` in this project. For example if your ngrok URL is `https://25b8c071.ngrok.io` then the your `answer_url` would be `https://25b8c071.ngrok.io/answer`

When you create an application, you will get a key to use for authentication. Save this into a file called `app.key` and keep it safe! You will need it later on to make outgoing phone calls.

Once the application is created, configured and linked to the phone numbers, take a look at the code and then go ahead and try it out.

⚓ Create a Web Server
## Set Up and Run the Application Code

Clone or download the code for this application from <https://github.com/Nexmo/800-replacement>.

One you have it, you will need to:

* Run `bundle install` to get the dependencies
* Copy `.env.example` to `.env` and edit this new file with your own configuration settings including the two numbers you bought and linked to your application
* Start the app with `ruby app.rb`

## Receive an Inbound Phone Call

Whenever someone calls one of the numbers that are linked to the Nexmo application, Nexmo will receive an incoming call. Nexmo will then notify your web application of that call. It does this by making a webhook request to your web app's `answer_url` endpoint. You can read more information about the [answer webhook](/voice/voice-api/webhook-reference#answer-webhook) in the developer docs.

User will call a city-specific number, so we need to know which number maps to which city. In our simplified case we will simply configure the two numbers you bought into your application, but in most real environments this relationship is stored in a database. The configuration can be found in `app.rb`:

```ruby
# Map our inbound numbers to different cities.
# In a production system this would most likely
# be queried from your database.
locations = {
  ENV['INBOUND_NUMBER_1'] => 'Chicago',
  ENV['INBOUND_NUMBER_2'] => 'San Francisco',
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

We can now handle an incoming call, extract the number dialled, and respond to the user with the current status of the transit in their city. The statuses will be delivered to the user as spoken text-to-speech messages.

> The impatient may phone their Nexmo numbers at this point and hear the application in action :)

The `answer_url` that we set earlier is the route that will be in use when we make a call. You can find this code in `app.rb`:

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

This code answers the call, checks the incoming phone number, and fetches the status that relates to that geographical number. Then it makes a call to the `respond_with()` function that takes care of building the [Nexmo Call Control Object (NCCO)](/voice/guides/ncco). These objects tell Nexmo what text-to-speech messages should be played to the caller and which other actions, such as accepting number input, should be performed.

```ruby
# This method is shared between both endpoints to play
# back the status and then ask for more input
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
      'eventUrl': ["#{ENV['DOMAIN']}/city"],
      # we give the user a bit more time before we hang up on them
      'timeOut': 10,
      # we only expect one digit
      'maxDigits': 1
    }
  ].to_json
end
```

> *Note*: Take a look at the [NCCO reference](/voice/guides/ncco-reference) for information on other actions available.

Call your Nexmo numbers and check that your application speaks the (imaginary) transport status for Chicago on one number, San Francisco on the other, and offers multiple options afterwards using the `input` NCCO action.

## Prompt for Other Localities

We can offer any of the cities' information to any caller, but if they didn't call the number related to their desired location then we need to ask them for input, as you see above. Let's look at that input action in more detail:

```
{
    'action': 'input',
    'eventUrl': ["#{ENV['DOMAIN']}/city"],
    # we give the user a bit more time before we hang up on them
    'timeOut': 10,
    # we only expect one digit
    'maxDigits': 1
}
```

The input puts the call into a listening mode. The configuration on this particular input block expects only one digit, but you can also accept multiple digits and end on the `#` symbol for example. The code here also sets the `eventUrl`: this is where the webhook containing the input data will be sent to. In this case, it's the `/city` endpoint on our application that will receive the data.

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

> *Tip*: Any selection made in a phone menu could be tracked to measure valuable data about user behavior and demand in your application

The button pressed will arrive in the `dtmf` field of the incoming webhook to that `/city` URL. Check out the more detailed [webhook documentation](/voice/voice-api/webhook-reference#input) for more information about webhook payloads.

Once you work out which city the user requested data for, you can look up the city and its status from the same configuration as before and re-use the `respond_with()` function to return the NCCO.

## Conclusion

You have created a voice application, purchased phone numbers and linked them to a Nexmo voice application. You have then built an application that receives an inbound call, maps the called number to a standard input, and then collects more input from the user to play back further info to them.

⚓ Resources
## Where Next?

* [Code on GitHub](https://github.com/Nexmo/800-replacement) - all the code from this application
* [Add a call whisper to an inbound call](https://developer.nexmo.com/tutorials/add-a-call-whisper-to-an-inbound-call) - how to announce details about an incoming caller before connecting the call
* [Inbound call tracking](https://www.nexmo.com/blog/2017/08/03/inbound-voice-call-campaign-tracking-dr/) - blog post on tracking which inbound marketing campaigns are working best
* [Voice API Reference](/api/voice) - detailed API documentation for the Voice API
* [NCCO reference](/voice/guides/ncco-reference) - detailed documentation for the webhooks 
