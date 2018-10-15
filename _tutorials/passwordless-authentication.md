---
title: Passwordless authentication
products: verify
description: Using the Verify API to allow users to login to a Ruby application.
languages:
    - Ruby
---
# Passwordless authentication

Although logging in with usernames and passwords is very common, passwords can be hard to remember, insecure and do not always offer the best usability.

By implementing passwordless login you replace static passwords with single use codes delivered by Nexmo in an SMS or a Voice calls. Your users can forget about passwords.

This tutorial is based on the [Passwordless Authentication](https://www.nexmo.com/use-cases/passwordless-authentication/) use case. You can [download the source code from GitHub](https://github.com/Nexmo/ruby-passwordless-login).

## In this tutorial

We will build a simple app that uses the Nexmo Verify API to log a user in without them having to type a password.

The following sections explain the code in this tutorial. They show you how to:

* [Create a basic Web app](#a-basic-web-application) - create a basic Web app that the user logs into
* [Collect the user's phone number](#collect-a-phone-number) - add a form to collect the user's phone number
* [Send the verification request](#send-verification-request) - create a verification request and send a PIN to the user's phone number
* [Collect the PIN](#collect-pin-code) - add a form to collect the PIN from the user
* [Verify the PIN](#verify-pin-code) - verify that the PIN the user provided is valid and log him or her in

## Prerequisites

To work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* To download the tutorial from <https://github.com/Nexmo/ruby-passwordless-login>
* Follow the installation instructions in the tutorial readme

## Create a basic Web app

To build the web app, we use [Sinatra](http://www.sinatrarb.com) and [Rack-Flash](https://github.com/nakajima/rack-flash) to create a single page web app:

```ruby
# enable sessions and set the
# session secret
enable :sessions
set :session_secret, '123456'

# specify a default layout
set :erb, layout: :layout

# Index
# - tries to show the current user's phone number if it is present
#
get '/' do
  @user = session[:user]
  erb :index
end
```

In the HTML you display the user's phone number and either:

* If the user is already logged in, show a logout link.
* If not, show a link to the login page.

```erb
<h1>
  Hello <%= @user %>
</h1>

<% if @user %>
  <a href="/logout">Logout</a>
<% else %>
  <a href="/login">Login</a>
<% end %>
```


## Collect a phone number

To use the Verify API, you use two API calls. The first sends starts the verification process by generating a PIN to send to the user (first by SMS, then if that fails, through a voice call). The second call is where you send back the PIN the user enter in your app. The response to the second API call will tell you whether the user entered the PIN correctly.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant User
Note over App,Nexmo: Initialization
App->Nexmo: Verify Request
Nexmo-->App: Verify Request ID
Nexmo->User: PIN
```

When your user *Login* in your app, show them the login form:


```ruby
get '/login' do
  erb :login
end
```

The form accepts the user's phone number in [E.164](https://en.wikipedia.org/wiki/E.164) format.

```html
<form action="/start_login" method="post">
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
````

When the user has submitted this form, you send a verification request via the Nexmo Verify API.

## Send verification request

To send the verification request, add the [nexmo-ruby](https://github.com/Nexmo/nexmo-ruby) client library to your application. Add it to your Gemfile:

```ruby
gem 'nexmo'
```

Remember to run `bundle install`.

You need Set your [API key and secret](https://dashboard.nexmo.com/settings) in order to initialize the `nexmo` library.

```ruby
require 'nexmo'
nexmo = Nexmo::Client.new(
  api_key: ENV['NEXMO_API_KEY'],
  api_secret: ENV['NEXMO_API_SECRET']
)
```

  **Note**: Best practice is to store your API credentials in environment variables.

We now integrate sending the verification code to the user into the application, so it occurs when the form above is submitted.

```ruby
post '/start_login' do
  # start verification request
  response = nexmo.verify.request(
    number: params['number'],
    brand: 'MyApp'
  )

  # any status that's not '0' is an error
  if response.status == '0'
    # store the number so we can show it later
    session[:number] = params['number']
    # store the verification ID so we can verify the user's code against it
    session[:verification_id] = response.request_id

    redirect '/verify'
  else
    flash[:error] = response.error_text

    redirect '/login'
  end
end
```

You can see that we have stored the user's phone number and the `request_id` that the Verify API returns to us as session data. We will need that request identifier in the next step.

## Collect the PIN

When the user receives the PIN they enter it into the UI of your app. The app uses *request_id* to send a Verify check request for the PIN.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant User
Nexmo->User: PIN
User->App: PIN
App->Nexmo: Verify Check
Nexmo-->App: Verify Check Status
```

The app uses the following form to collect the PIN entered by the user:

```ruby
get '/verify' do
  erb :verify
end
```

```erb
<h1>Verify Number</h1>

<p>
  We have sent a verification code to your number.
  This could take up to a minute to arrive.
</p>

<form action="/finish_login" method="post">

  <div class="field">
    <label for="number">Code</label>
    <input type="text" name="code">
  </div>

  <div class="actions">
    <input type="submit" value="Verify">
  </div>
</form>
```

## Verify the PIN

To verify the PIN submitted by the user you use the Nexmo library to make a [Verify Check](/api/verify#check) request. You pass in the `request_id` (which we stored in the user's session data) and the PIN entered by the user.

The Verify API response tells you if the user entered the correct PIN. If the `status` is `0`, log the user in.

```ruby
post '/finish_login' do
  # check the code with Nexmo
  response = nexmo.verify.check(
    request_id: session[:verification_id],
    code: params[:code]
  )

  # any status that's not '0' is an error
  if response.status == '0'
    # set the current user to the number
    session[:user] = session[:number]

    redirect '/'
  else
    flash[:error] = response.error_text

    redirect '/login'
  end
end
```

## Conclusion

That's it. You can now log a user into this web app using just a phone number via SMS. To do this you collected their phone number, used Verify to send the user a PIN, collected this PIN from the user and sent it back to the Verify API to check.
