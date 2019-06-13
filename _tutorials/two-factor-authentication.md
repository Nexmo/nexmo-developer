---
title: Two-factor authentication for security and spam prevention
products: verify
description: Increase your application security
languages:
    - Ruby
---

# Two-factor authentication for security and spam prevention

Although usernames and passwords are the most common way to log a user into a system, they don't come without issues. Passwords can be difficult and this leads to bad password management. For example, reusing the same password across multiple sites or writing difficult passwords down on paper. Usernames and passwords do not provide any protection against spam or bot networks. Verifying a phone number on registration prevents bots from creating bulk accounts. This eradicates spam more effectively than captchas or social logins.

Two-factor authentication improves your app's security because your users enter a PIN that is sent to their phone every time they log in.

This tutorial is based on the [Two-factor authentication](https://www.nexmo.com/use-cases/two-factor-authentication/) use case. You download the code from <https://github.com/Nexmo/ruby-2fa>.

## In this tutorial

In this tutorial you see how easy it is to build an app that adds two-factor authentication using Nexmo Verify:

1. [Create a basic Web app](#create-a-basic-web-app) - create a Web app with a protected page.
2. [Enforce phone number verification](#enforce-phone-number-verification) - verify a user's phone number on registration and sign up.
3. [Send a verification request](#send-a-verification-request) - use Verify to send a PIN to the user’s phone number.
4. [Collect the PIN](#send-a-verification-request) - add a form to collect the PIN received by your user.
5. [Verify the PIN](#verify-pin) - verify the PIN the user provided is valid and log them in.

## Prerequisites

To work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)

## Create a basic Web app

Create a minimal web app for user authentication:

```
$ rails new ruby-2fa
$ rails generate controller pages index
$ rails generate model user username password_digest number
$ rake db:migrate
```

**config/routes.rb**

```ruby
root to: 'pages#index'
resource :user, only: [:new, :create, :edit, :update]
```

For now, users register with a username and password:

**app/models/user.rb**

```ruby
class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: true
end
```

**app/controllers/users_controller.rb**

```ruby
def new
  @user = User.new
end

def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to '/'
  else
    flash[:alert] = 'Registration failed'
    render :new
  end
end
```

**app/views/users/new.html.erb**

```erb
<h1>Register</h1>

<%= form_for @user, url: user_path do |f| %>
  <div class="field">
    <%= f.label :username %>
    <%= f.text_field :username %>
  </div>
  <div class="field">
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>
  <div class="field">
    <%= f.label :password_confirmation %>
    <%= f.password_field :password_confirmation %>
  </div>
  <div class="field">
    <%= f.label :number %>
    <%= f.password_field :number %>
  </div>
```

This form captures the phone number in [E.164](https://en.wikipedia.org/wiki/E.164) format expected by Voice API. For example, *447700900000*.

Let a user log in and out with their details:

**app/controllers/users_controller.rb**

```ruby
def new
  @user = User.new
end

def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to '/'
  else
    flash[:alert] = 'Registration failed'
    render :new
  end
end
```

**app/views/users/new.html.erb**

```erb
<h1>Register</h1>

<%= form_for @user, url: user_path do |f| %>
  <div class="field">
    <%= f.label :username %>
    <%= f.text_field :username %>
  </div>
  <div class="field">
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>
  <div class="field">
    <%= f.label :password_confirmation %>
    <%= f.password_field :password_confirmation %>
  </div>
  <div class="field">
    <%= f.label :number %>
    <%= f.password_field :number %>
  </div>
```

Finally, add a section to the app that requires authentication:

**app/controllers/application_controller.rb**

```ruby
private

def ensure_authenticated
  unless logged_in?
    redirect_to new_session_path
  end
end

def logged_in?
  !current_user.nil?
end

def current_user
  @current_user ||= User.where(id: session[:user_id]).first
end
```

**app/controllers/pages_controller.rb**

```ruby
before_action :ensure_authenticated
```

**app/views/pages/index.html.erb**

```erb
<h1>A protected page</h1>

<%= link_to 'Logout', :session, method: :delete %>
<%= link_to 'Edit user', [:edit, :user] %>
```

At this point you can start the app and log in and out with the user you created. The next step is to add two-factor authentication to the registration and login process.

## Enforce phone number verification

Using Verify you send and validate a one time PIN using 2 API calls. In the first call you send the user's phone number, Nexmo generates the PIN and delivers it to the user's phone.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant User
Note over App,Nexmo: Initialization
App->Nexmo: Verify Request
Nexmo-->App: Verify Request ID
Nexmo->User: PIN Code
```

When your user logs in or registers, verify their phone number before they can continue:

**config/routes.rb**

```ruby
resource :verification, only: [:new, :create]
```

**app/controllers/application_controller.rb**

```ruby
  def ensure_verified
    unless verified?
      redirect_to new_verification_path
    end
  end

  def verified?
    session[:verified]
  end
end
```

**app/controllers/pages_controller.rb**

```ruby
before_action :ensure_verified
```

## Send a verification request

To send the verification request, add the [Nexmo REST API client for Ruby](https://github.com/Nexmo/nexmo-ruby) to the project:

**Gemfile**

```ruby
gem 'nexmo'
```

To initialize the Nexmo client library you pass it your [API key and secret](https://dashboard.nexmo.com/settings). Best practice is to store your API credentials in your environment variables rather than your code.

Send a verification code to an unverified user:

**app/controllers/verifications_controller.rb**

```ruby
class VerificationsController < ApplicationController
  before_action :send_verification_request
```

**app/controllers/verifications_controller.rb**

```ruby
private

def send_verification_request
  response = client.verify.request(
    number: current_user.number,
    brand: 'MyApp'
  )

  if response.status == '0'
    session[:verification_id] = response.request_id
  end
end
```


## Collect a PIN

When the user receives the PIN they pass this to your app. Your app verifies the PIN using *request_id*.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant User
Nexmo->User: PIN
User->App: PIN
App->Nexmo: Verify Check
Nexmo-->App: Verify Check Status
```

To collect this PIN, add a form to the app:

**app/controllers/verifications_controller.rb**

```ruby
def new
end
```
**app/views/verifications/new.html.erb**

```erb
<h1>Verify</h1>

<%= form_tag '/verification' do |f| %>
  <div class="field">
    <%= label_tag :code %>
    <%= text_field_tag :code %>
  </div>
  <div class="actions">
    <%= submit_tag 'Continue Login' %>
    <%= link_to 'Logout', :session, method: :delete %>
  </div>
<% end %>
```

⚓ Verify the PIN
## Verify PIN

To validate the PIN submitted by the user you use the [Nexmo REST API client for Ruby](https://github.com/Nexmo/nexmo-ruby) to make a [Verify Check](/api/verify#verify-check) request. You pass the *request_id* and the PIN entered by the user to Verify.  

The Verify API response tells you if the user entered the correct PIN. If *status* is *0*, log the user in:

**app/controllers/verifications_controller.rb**

```ruby
def create
  response = client.verify.check(
    request_id: session[:verification_id],
    code: params[:code]
  )

  if response.status == '0'
    session[:verified] = true
    redirect_to :root
  else
    flash[:alert] = 'Code invalid'
    redirect_to [:new, :verification]
  end
end
```

## Conclusion

That's it. You can now log a user into your Web app using two-factor authentication powered by Verify. To do this you collected their phone number, used Verify to send the user a PIN, collected this PIN in your Web app and validated it with Verify.

## Resources

* [Two-factor authentication with Nexmo Verify](https://github.com/Nexmo/ruby-2fa)
* [Nexmo Client Library for Ruby](https://github.com/Nexmo/nexmo-ruby)
* [Verify API](/verify)
* [Verify API reference guide](/api/verify)
