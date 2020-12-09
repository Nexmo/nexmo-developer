---
title:  Require a phone number
description:  Ensure that users supply a phone number when registering for an account

---

Require a phone number
======================

Start by requiring that users include a phone number when registering. Do this by generating a new database migration:

```sh
rails generate migration add_phone_number_to_users
```

Edit the `db/migrate/..._add_phone_number_to_users.rb` file to add a new column to the `user` model:

```ruby
class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
  end
end
```

Apply the change by executing:

```sh
rake db:migrate
```

Devise enables you to edit a user right out of the box. By default these views are hidden, so we need to get a copy of them to make changes to. Devise makes this pretty easy through a Rails generator, which you would run using `rails generate:devise:views:templates`.

However, because the sample application uses the `devise-bootstrap-templates` gem, you need to use a different version of the generator:

```sh
rails generate devise:views:bootstrap_templates
```

This copies multiple view templates into `app/views/devise`, but you are only interested in `app/views/devise/registrations/edit.html.erb`, so delete the rest.

Then, amend the edit template to add a field for the user to enter a phone number, directly after the email field:

```html
<div class="form-group">
  <%= f.label :phone_number %> <i>(Leave blank to disable two factor authentication)</i><br />
  <%= f.number_field :phone_number, class: "form-control", placeholder: "e.g. 447555555555 or 1234234234234"  %>
</div>
```

Finally, you need to make Devise aware of this extra parameter:

**`app/controllers/application_controller.rb`** 

```ruby
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number])
  end
end
```

To add a phone number to your account, run `rails server`, then navigate to http://localhost:3000/ and log in using the account details you registered with in the previous step.

Click your email address at the top right of the screen, enter your phone number and the password you used to register with and click Update. This will save your phone number to the database.

