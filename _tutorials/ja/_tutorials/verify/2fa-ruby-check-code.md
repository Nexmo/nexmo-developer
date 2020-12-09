---
title:  確認コードを確認する
description:  ユーザーが入力したコードが、送信されたコードと同じであることを確認してください

---

確認コードをチェックする
============

プロセスの最後のパートでは、受信したコードをユーザーに入力して、Verify APIによって送信されたコードと一致することを確認します。

まず、新しいルートを追加します：

**`config/routes.rb`** 

```ruby
Rails.application.routes.draw do
  devise_for :users
  resources :verifications, only: [:edit, :update]

  root to: 'kittens#index'
end
```

次に、基本的なコントローラを作成します：

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

上記から、ブラウザがリダイレクトの無限ループに陥らないように、以前`ApplicationController`に追加した`before_action`をスキップすることが重要です。

ユーザーが確認コードを入力できるようにするビューを作成します：

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

その後、ユーザーはコードを新しい`update`アクションに送信します。このアクションでは、`request_id`と`code`を取得し、`check_verification_request`メソッドに受け渡す必要があります：

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

検証チェックが成功すると、ユーザーのステータスは検証済みに設定され、メインページにリダイレクトされます。チェックに失敗すると、何が問題になったかを示すメッセージが表示されます

