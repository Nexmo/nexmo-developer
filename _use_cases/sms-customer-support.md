---
title: SMS Customer Support
products: messaging/sms
description: Programmable SMS is not just useful for one way notifications. When you combine outbound notifications with inbound messages you create chat-like interactions between your company and your customers.
languages:
    - Ruby
---

# SMS Customer Support

The general availability of SMS makes it a versatile solution for customer support. Phone numbers can be printed, read out, and put on websites, allowing anyone online or offline to engage with your business.

Providing customer support over SMS is an easy way to provide a full two-way communication system to anybody with a phone connected to a mobile network.

## In this tutorial

You will build a simple system for SMS customer support using Nexmo's APIs and libraries.

To do this:

* [Create a basic web app](#a-basic-web-application) - create a basic web application with a link to open a support ticket.
* [Purchase a number](#purchase-a-phone-number) - purchase a Nexmo phone number to send SMS and receive inbound SMS
* [Process an inbound SMS](#process-an-inbound-sms) - accept and process inbound SMS received from the customer
* [Send an SMS reply with a ticket number](#send-an-sms-reply-with-a-ticket-number) - reply with a new ticket number when a ticket is opened

## Prerequisites

In order for this tutorial to work you will need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* A publicly accessible Web server so Nexmo can make webhook requests to your app. If you're developing locally you should use a tool such as [ngrok](https://ngrok.com/)
* The source code for this tutorial from <https://github.com/Nexmo/ruby-sms-customer-support/>


## A Basic Web application

For this tutorial start off with a simple web application with one page. The user will be able to click on a link to open their SMS app and request support. Your app will collect the inbound SMS and open a new ticket. Finally, the app will reply with a new SMS to the user confirming their ticket number.

```sequence_diagram
Participant Phone
Participant Nexmo
Participant App
Phone->Nexmo: SMS 1
Nexmo-->App: Webhook
App->Nexmo: SMS Request
Nexmo->Phone: SMS 2
```

**Start by creating a basic app.**

```sh
rails new customer-support
cd customer-support
rake db:create db:migrate
```

The page will be at the root of our application and will provide a link to your SMS app with some prefilled text.

**Adding a first page**

```sh
rails g controller pages index
```

**app/views/pages/index.html.erb**

```erb
<h1>ACME Support</h1>

<p>
  <a href="sms://<%= ENV['NEXMO_NUMBER'] %>?body=Hi ACME, I'd like some help with: " class='button'>
    Get support via SMS
  </a>
</p>
```

With this in place the server can be started.

**Starting the server**

```sh
rails server
```

## Purchase a phone number

Before the app can receive an SMS a Nexmo phone number has to be rented. Phone numbers can be purchased from the [dashboard](https://dashboard.nexmo.com) or directly from the command line with the [Nexmo CLI](https://github.com/nexmo/nexmo-cli).

```sh
> nexmo number:buy --country_code US --confirm
Number purchased: 447700900000
```

Finally, Nexmo must be informed of the webhook endpoint to make an HTTP request to when an inbound SMS is received. This can be done using the [dashboard](https://dashboard.nexmo.com/your-numbers) or the [Nexmo CLI](https://github.com/nexmo/nexmo-cli).

```sh
> nexmo link:sms 447700900000 http://[your.domain.com]/support
Number updated
```

> *Note*: Ensure your server is running and publicly available before trying to set up a new callback URL for webhooks. When you are setting up a new webhook Nexmo will make a call to your server to confirm it's available.*

⚓ Process an SMS
## Process an Inbound SMS

When the customer sends their SMS it will be received by Nexmo via the mobile carrier network. Nexmo will subsequently make a webhook to your application.

This webhook will contain the original text sent, the phone number the message came from, and a few more parameters. For more details see the [Inbound Message](/api/sms#inbound-sms) documentation.

Your app should process the incoming webhook, extract the text and number, open a new ticket, or update an existing ticket. If this is a customer's first request the app should send a confirmation message back to the customer with their ticket number.

This is achieved by saving the incoming message and opening a new ticket if the number does not already have an open ticket.

**Add a ticket and a message model**

```sh
rails g controller support index
rails g model Ticket number
rails g model Message text ticket:references
rake db:migrate
```

**app/controllers/support_controller.rb**

```ruby
class SupportController < ApplicationController
  def index
    save_message
    send_response
    render nothing: true
  end

  private

  def ticket
    @ticket ||= Ticket.where(
      number: params[:msisdn]
    ).first_or_create
  end

  def save_message
    message = Message.create(
      text: params[:text],
      ticket: ticket
    )
  end
```

## Send an SMS reply with a ticket number

To send the confirmation to the customer's SMS, add the Nexmo library to your project.

**Gemfile**

```ruby
gem 'nexmo'
gem 'dotenv-rails'
```

> *Note*: To initialize the Nexmo client library you will need to pass it your [API key and secret](https://dashboard.nexmo.com/settings). We highly recommend that you do not store your API credentials in your code but to use environment variables instead.*

With the library initialized the application can now [send an SMS](/api/sms#send-an-sms). Only send a response if this was the first message on this ticket.

```ruby
def send_response
  return if ticket.messages.count > 1

  client = Nexmo::Client.new
  result = client.sms.send(
    from: ENV['NEXMO_NUMBER'],
    to: ticket.number,
    text: "Dear customer, your support" \
          "request has been registered. " \
          "Your ticket number is #{ticket.id}. " \
          "We intend to get back to any " \
          "support requests within 24h."
  )
end
```

## Conclusion

In this tutorial you've learned how to receive an SMS from a customer's phone and send an SMS reply to them. With these code snippets you now have an SMS customer support solution using the Nexmo SMS API.

## Get the Code

All the code for this tutorial and more is [available on GitHub](https://github.com/Nexmo/ruby-sms-customer-support/).

## Resources

* [SMS](/sms)
* [SMS API reference guide](/api/sms)
