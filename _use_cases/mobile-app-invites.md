---
title: Mobile app invites
products: messaging/sms
description: Link your customers to your app with SMS
languages:
    - Ruby
---

# Mobile app invites

With the number of apps on Android and iOS rising it is important for people to easily find your apps, both in the stores and on the Web.

If your mobile app has a Website you are probably familiar with:

![Mobile app button example](/assets/images/app_store_play_badges.png)

These buttons make it easy for anyone to navigate to the correct store for their mobile device. However, this flow quickly falls apart if the user is not mobile. What happens when your user is using a desktop computer? By using **Mobile app promotion**, you can quickly convert a browsing user into an active customer by sending them a link to your app via SMS.

## In this tutorial

You see how easy it is to build a mobile app invites system using the Nexmo APIs and libraries:

1. [Create a Web app](#create-a-web-app) - create a Web app with download buttons.
2. [Detect desktop users](#detect-desktop-users) - show the correct download button for desktop or mobile users.
3. [Collect a name and phone number](#collect-a-name-and-phone-number) - for desktop browsers, display a form to collect user information.
4. [Send the download link in an SMS](#send-the-download-link-in-an-sms) - send an SMS to your user containing the download link for your app.
4. [Run this tutorial](#run-this-tutorial) - run the tutorial and send the download URL to your phone number.

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* A publicly accessible Web server so Nexmo can make webhook requests to your app. If you're developing locally you must use a tool such as [ngrok](https://ngrok.com/) ([see our ngrok tutorial blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/))
* The source code for this tutorial from <https://github.com/Nexmo/ruby-mobile-app-promotion>

## Create a Web app

For your customer interface, use [Sinatra](http://www.sinatrarb.com) and [rack](https://github.com/nakajima/rack-flash) to create a single page Web app:

**Gemfile**

```ruby
source 'https://rubygems.org'

gem 'sinatra'
gem 'rack-flash3'
```

**app.rb**

```ruby
# web server and flash messages
require 'sinatra'
require 'rack-flash'
use Rack::Flash

# enable sessions and set the
# session secret
enable :sessions
set :session_secret, '123456'

# Index
# - shows our landing page
#   with links to download
#   from the app stores or
#   via SMS
#
get '/' do
  erb :index
end
```

Add the Google and iOS store buttons to the HTML in your Web app:

**views/index.erb**

```erb
<a href="https://play.google.com/store/apps/details?id=com.imdb.mobile">
  <!-- place this image in a public/ folder -->
  <img src="google-play-badge.png" />
</a>

<a href="https://geo.itunes.apple.com/us/app/google-official-search-app/id284815942">
  <!-- place this image in a public/ folder -->
  <img src='app-store-badge.svg' />
</a>
```

> To make life easier, you can [download the buttons](/assets/archives/app-store-badges.zip).

## Detect desktop users

To check if a user is browsing from a mobile or desktop device, parse *request.user_agent*:

**Gemfile**

```
gem 'browser'
```

**app.rb**

```ruby
# determine the browser and platform
require 'browser'

before do
  @browser ||= Browser.new(request.user_agent)
end
```

Use the value of `browser.device` to display the correct store button for the mobile devices:

**views/index.erb**

```erb
<% unless @browser.platform.ios? %>
  <a href="https://play.google.com/store/apps/details?id=com.imdb.mobile">
    <!-- place this image in a public/ folder -->
    <img src="google-play-badge.png" />
  </a>
<% end %>

<% unless @browser.platform.android? %>
  <a href="https://geo.itunes.apple.com/us/app/google-official-search-app/id284815942">
    <!-- place this image in a public/ folder -->
    <img src='app-store-badge.svg' />
  </a>
<% end %>
```

If the user is not using a mobile device, display the button for SMS download:

**views/index.erb**

```erb
<% unless @browser.device.mobile? %>
  <a href="/download">
    <!-- place this image in a public/ folder -->
    <img src='sms-badge.png' />
  </a>
<% end %>
```

This button looks like:

![Mobile app button example](/assets/images/sms-badge.png)

## Collect a name and phone number

If your user is browsing from the desktop, use an HTML form to collect both the phone number you will send an SMS to and a name if the user wants to send this link to a friend. When the user clicks the SMS download button in the home page, show them the input form for their phone number.

**app.rb**

```rb
# Download page
# - a page where the user
#   fills in their phone
#   number in order to get a
#   download link
#
get '/download' do
  erb :download
end
```

The form captures the phone number in the [E.164](https://en.wikipedia.org/wiki/E.164) format expected by SMS API:

**views/download.erb**

```erb
<form action="/send_sms" method="post">
  <div class="field">
    <label for="number">
      Phone number
    </label>
    <input type="text" name="number">
  </div>

  <div class="actions">
    <input type="submit" value="Continue">
  </div>
</form>
```

When your user clicks *Continue*, you use SMS API to send them a text message containing the download URL for your app.

You can also send a direct link to the correct stores in the SMS. To do this you update the form so the user can choose their device.

## Send the download link in an SMS

You send an SMS using a single call to SMS API, Nexmo takes care of all the routing and delivery. The following diagram shows the workflow followed in this tutorial to send an SMS:

```js_sequence_diagram
Participant App
Participant Nexmo
Participant Phone number
Note over App: Initialize library
App->Nexmo: Request to SMS API
Nexmo-->App: Response from SMS API
Note over Nexmo: Request accepted
Nexmo->Phone number: Send SMS
```

In this tutorial, to send an SMS you add the [Nexmo REST API client for Ruby](https://github.com/Nexmo/nexmo-ruby) to your app:

**Gemfile**

```rb
gem 'nexmo'
```

Use your Nexmo API [key and secret](/concepts/guides/authentication) to initialize the client:

**app.rb**

```rb
# Nexmo library
require 'nexmo'
nexmo = Nexmo::Client.new(
  api_key: ENV['NEXMO_API_KEY'],
  api_secret: ENV['NEXMO_API_SECRET']
)
```

> **Note**: Do not store your API credentials in your code, use environment variables instead.

Use the initialized library to make a request to [SMS API](/api/sms#send-an-sms):

**app.rb**

```rb
# Send SMS
# - when submitted this action
#   sends an SMS to the user's
#   phone number with a download
#   link
#
post '/send_sms' do
  message = "Download our app on #{url('/')}"

  # send the message
  response = nexmo.sms.send(
    from: 'My App',
    to: params[:number],
    text: message
  ).messages.first

  # verify the response
  if response.status == '0'
    flash[:notice] = 'SMS sent'
    redirect '/'
  else
    flash[:error] = response.error-text
    erb :download
  end
end
```

The *status* response parameter tells you if Nexmo has accepted your request and sent the SMS.

To verify that this SMS was received by the user, check the (link: messaging/sms-api/api-reference#delivery_receipt text: delivery receipt). This tutorial does not verify delivery receipts.


## Run this tutorial

To run this tutorial:

1. Spin up your app.
2. Using your desktop browser, navigate to the Web app.
3. Click the SMS message button. You are presented with the phone number form.
4. Fill in and submit the form. Within seconds you receive an SMS text with the link to your app.

> **Note**: if the SMS has a *localhost* or *127.0.0.1* link, use a tool like [ngrok](https://ngrok.com/) so the tutorial code creates a URL your mobile device can connect to.

## Conclusion

That's it. You can now let anyone send themselves or a friend a direct link to download your mobile app in an SMS. To do this you collected a phone number, sent the user a link, detected their platform, and presented them with the correct download link to continue.

## Get the Code

All the code for this tutorial is available in the [Mobile app invites tutorial GitHub repo](https://github.com/Nexmo/ruby-customer-engagement).

## Resources

* [Nexmo Client Library for Ruby](https://github.com/Nexmo/nexmo-ruby)
* [SMS](/sms)
* [SMS API reference guide](/api/sms)
