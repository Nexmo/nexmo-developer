---
title:  发送验证请求
description:  通过发出验证请求开始验证过程

---

发送验证请求
======

用户将其电话号码添加到帐户后，当用户登录网站时，您可以使用该电话号码来验证用户的身份。

要使用 Verify API，您需要将 `nexmo` gem 添加到您的项目中。您还需要配置 `nexmo` gem 以使用您的 API 密钥和密码，您将从 `.env` 文件加载 API 密钥和密码。

将以下行添加到应用程序的 `Gemfile`：

    gem 'nexmo'
    gem 'dotenv-rails', groups: [:development, :test]

然后，在应用程序的路由目录中创建 `.env` 文件，并使用您在[开发人员 Dashboard](https://dashboard.nexmo.com) 中找到的 API 密钥和密码对其进行配置：

**`.env`** 

    VONAGE_API_KEY=your_api_key
    VONAGE_API_SECRET=your_api_secret

向您的 `ApplicationController` 添加 `before_action`，以检查用户是否启用了双因素身份验证。如果启用，请务必验证用户的身份，然后再允许他们继续执行其他操作：

**`app/controllers/application_controller.rb`** 

```ruby
before_action :verify_user!, unless: :devise_controller?
 
def verify_user!
  start_verification if requires_verification?
end
```

要确定用户是否需要验证，请检查他们是否注册了电话号码，以及是否尚未设置 `:verified` 会话属性：

**`app/controllers/application_controller.rb`** 

```ruby
def requires_verification?
  session[:verified].nil? && !current_user.phone_number.blank?
end
```

要开始验证过程，请调用 `Nexmo::Client` 对象的 `send_verification_request`。您无需传递 API 密钥和密码，因为它们已通过您在 `.env` 配置的环境值进行了初始化：

**`app/controllers/application_controller.rb`** 

```ruby
def start_verification
  result = Nexmo::Client.new.verify.request(
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

> 请注意，您向验证请求传递 Web 应用程序的名称。用户收到的文本消息将使用该名称，以便他们可以识别消息的来源。

如果消息成功发送，则需要将用户重定向到用于输入所收到代码的页面。您将执行此操作并在下一步中检查代码是否正确。

