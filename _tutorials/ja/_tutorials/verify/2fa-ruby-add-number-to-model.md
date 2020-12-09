---
title:  電話番号を要求する
description:  アカウント登録時にユーザーが電話番号を提供することを要求します

---

電話番号を要求する
=========

登録時にユーザーに電話番号を含めることを要求することから始めます。これは、新しいデータベース移行を生成することによって行います：

```sh
rails generate migration add_phone_number_to_users
```

`db/migrate/..._add_phone_number_to_users.rb`ファイルを編集して、`user`モデルに新しい列を追加します：

```ruby
class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
  end
end
```

次を実行して、変更を適用します：

```sh
rake db:migrate
```

Deviseを使用すると、すぐにユーザーを編集できます。デフォルトでは、これらのビューは非表示になっているため、変更を加えるにはそれらのコピーを取得する必要があります。Deviseを使用すると、Railsジェネレータを使用して、`rails generate:devise:views:templates`を使用して簡単に実行できます。

ただし、サンプルアプリケーションは `devise-bootstrap-templates` gemを使用するため、ジェネレータの別のバージョンを使用する必要があります：

```sh
rails generate devise:views:bootstrap_templates
```

これにより、複数のビューテンプレートが`app/views/devise`にコピーされますが、興味があるのは`app/views/devise/registrations/edit.html.erb`だけなので、残りのビューを削除してください。

次に、編集テンプレートを修正して、電子メールフィールドの直後に、ユーザーが電話番号を入力するためのフィールドを追加します：

```html
<div class="form-group">
  <%= f.label :phone_number %> <i>(Leave blank to disable two factor authentication)</i><br />
  <%= f.number_field :phone_number, class: "form-control", placeholder: "e.g. 447555555555 or 1234234234234"  %>
</div>
```

最後に、Deviseにこの追加パラメータを認識させる必要があります：

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

アカウントに電話番号を追加するには、`rails server`を実行し、http://localhost:3000/に移動し、前の手順で登録したアカウントの詳細を使用してログインします。

画面右上のメールアドレスをクリックし、登録に使用した電話番号とパスワードを入力して、[Update (更新)]をクリックします。これにより、電話番号がデータベースに保存されます。

