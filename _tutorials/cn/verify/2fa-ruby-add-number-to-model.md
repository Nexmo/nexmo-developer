---
title:  需要电话号码
description:  确保用户在注册帐户时提供了电话号码

---

需要电话号码
======

首先要求用户在注册时输入电话号码。通过生成新的数据库迁移来做到这一点：

```sh
rails generate migration add_phone_number_to_users
```

编辑 `db/migrate/..._add_phone_number_to_users.rb` 文件，以将新列添加到 `user` 模型：

```ruby
class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
  end
end
```

通过执行以下命令来应用更改：

```sh
rake db:migrate
```

使用 Devise 可以直接编辑用户。默认情况下，这些视图是隐藏的，因此我们需要获取其副本才能进行更改。Devise 通过 Rails 生成器使这项操作变得很简单，您将使用 `rails generate:devise:views:templates` 运行 Rails 生成器。

但由于示例应用程序使用 `devise-bootstrap-templates` gem，因此您需要使用不同版本的生成器：

```sh
rails generate devise:views:bootstrap_templates
```

此操作会将多个视图模板复制到 `app/views/devise` 中，但您只对 `app/views/devise/registrations/edit.html.erb` 感兴趣，因此请删除其余的视图模板。

然后，修改编辑模板，以在电子邮件字段之后为用户添加用于输入电话号码的字段：

```html
<div class="form-group">
  <%= f.label :phone_number %> <i>(Leave blank to disable two factor authentication)</i><br />
  <%= f.number_field :phone_number, class: "form-control", placeholder: "e.g. 447555555555 or 1234234234234"  %>
</div>
```

最后，您需要让 Devise 注意到这个额外参数：

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

要向您的帐户添加电话号码，请运行 `rails server`，然后浏览到 http://localhost:3000/，并使用您在上一步中注册的帐户详细信息登录。

点击屏幕右上角的电子邮件地址，输入您的电话号码和注册时使用的密码，然后点击"更新"。这会将您的电话号码保存到数据库中。

