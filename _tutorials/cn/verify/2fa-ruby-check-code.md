---
title:  检查验证码
description:  检查用户输入的验证码是否与发送的验证码相同

---

检查验证码
=====

该过程的最后一部分是让用户输入他们收到的代码，并确认它与 Verify API 发送的代码一致。

首先，添加新路由：

**`config/routes.rb`** 

```ruby
Rails.application.routes.draw do
  devise_for :users
  resources :verifications, only: [:edit, :update]

  root to: 'kittens#index'
end
```

然后，创建基本控制器：

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

从上面的内容可以注意到，必须跳过我们先前添加到 `ApplicationController` 的 `before_action`，这样浏览器才不会陷入重定向的无限循环中。

创建视图，以使用户填写他们的验证码：

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

然后，用户将其代码提交给新的 `update` 操作。在此操作中，您需要使用 `request_id` 和 `code` 并将它们传递给 `check_verification_request` 方法：

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

验证检查成功后，用户的状态设置为"已验证"，系统会将他们重定向到主页。如果检查不成功，则显示一条消息说明发生了什么问题

