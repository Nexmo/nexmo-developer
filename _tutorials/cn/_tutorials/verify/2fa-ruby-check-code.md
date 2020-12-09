---
title:  Check the verification code
description:  Check that the code the user enters is the same as the one that was sent

---

Check the verification code
===========================

The final part of the process is to have the user enter the code they received and confirm that it matches the one that was sent by the Verify API.

First, add a new route:

**`config/routes.rb`** 

```ruby
Rails.application.routes.draw do
  devise_for :users
  resources :verifications, only: [:edit, :update]

  root to: 'kittens#index'
end
```

Then, create a basic controller:

**`app/controllers/verifications_controller.rb`** 

```ruby
class VerificationsController < ApplicationController
  skip_before_action :verify_user!
 
  def edit
  end
 
  def update
  end
end
```

Note from the above that is important to skip the `before_action` we added to the `ApplicationController` earlier so that the browser doesn’t end up in an infinite loop of redirects.

Create a view to enable the user to fill in their verification code:

**`app/views/verifications/edit.html.erb`** 

```html
<div class="panel panel-default devise-bs">
  <div class="panel-heading">
    <h4>Verify code</h4>
  </div>
  <div class="panel-body">
    <%= form_tag verification_path(id: params[:id]), method: :put do %>
      <div class="form-group">
        <%= label_tag :code %><br />
        <%= number_field_tag :code, class: "form-control"  %>
      </div>
      <%= submit_tag 'Verify', class: "btn btn-primary" %>
    <% end %>
  </div>
</div>

<%= link_to 'Send me a new code', :root %>
```

The user then submits their code to the new `update` action. Within this action you need to take the `request_id` and `code` and pass them to the `check_verification_request` method:

**`app/controllers/verifications_controller.rb`** 

```ruby
def update
  confirmation = Nexmo::Client.new.verify.check(
    request_id: params[:id],
    code: params[:code]
  )
 
  if confirmation['status'] == '0'
    session[:verified] = true
    redirect_to :root, flash: { success: 'Welcome back.' }
  else
    redirect_to edit_verification_path(id: params[:id]), flash[:error] = confirmation['error_text'] 
  end
end
```

When the verification check is successful, the user’s status is set to verified and they are redirected to the main page. If the check is unsuccessful, a message displays describing what went wrong

