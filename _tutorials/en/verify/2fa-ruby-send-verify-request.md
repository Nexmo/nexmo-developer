---
title: Send the verification request
description: Commence the verification process by issuing a verification request
---

# Send the verification request

Now that a user can add their phone number to their account you can use that number to verify them when they log in to the site.

To use the Verify API, you will need to add the `vonage` gem to your project. You will also need to configure the `vonage` gem to use your API key and secret, which you will load from a `.env` file.

Add the following lines to the application's `Gemfile`:

```
gem 'vonage'
gem 'dotenv-rails', groups: [:development, :test]
```

Then, create a `.env` file in your application's route directory and configure it with your API key and secret which you will find in the [Developer Dashboard](https://dashboard.nexmo.com):

**`.env`**

```
VONAGE_API_KEY=your_api_key
VONAGE_API_SECRET=your_api_secret
```

Add a `before_action` to your `ApplicationController` that checks if the user has two-factor authentication enabled. If they do, make sure that they are verified before they are allowed to continue:

**`app/controllers/application_controller.rb`**

```ruby
before_action :verify_user!, unless: :devise_controller?
 
def verify_user!
  start_verification if requires_verification?
end
```

To determine if the user requires verification, check if they have registered with a phone number and that the `:verified` session property has not been set:

**`app/controllers/application_controller.rb`**

```ruby
def requires_verification?
  session[:verified].nil? && !current_user.phone_number.blank?
end
```

To start the verification process, call `send_verification_request` on the `Vonage::Client` object. You don’t need to pass in your API key and secret because it has already been initialized through the environment values you configured in `.env`:

**`app/controllers/application_controller.rb`**

```ruby
def start_verification
  result = Vonage::Client.new.verify.request(
    number: current_user.phone_number,
    brand: "Kittens and Co",
    sender_id: 'Kittens'
  )
  if result['status'] == '0'
    redirect_to edit_verification_path(id: result['request_id'])
  else
    sign_out current_user
    redirect_to :new_user_session, flash: {
      error: 'Could not verify your number. Please contact support.'
    }
  end
end
```

> Note that you  pass the verification request the name of the web application. This is used in the text message the user receives so that they can recognize where it came from.

If the message was sent successfully you need to redirect the user to a page where they can enter the code they received. You will do this and check if the code is correct in the next step.