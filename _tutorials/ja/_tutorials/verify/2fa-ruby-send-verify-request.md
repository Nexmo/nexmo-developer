---
title:  確認リクエストを送信する
description:  検証リクエストを発行して検証プロセスを開始する

---

確認リクエストを送信する
============

ユーザーが自分の電話番号をアカウントに追加できるようになったので、サイトにログインするときにその番号を使用して確認することができます。

Verify APIを使用するには、プロジェクトに`nexmo` gemを追加する必要があります。APIキーとシークレットを使用するように`nexmo` gemを設定する必要もあります。これは`.env`ファイルからロードされます。

アプリケーションの`Gemfile`に次の行を追加します：

    gem 'nexmo'
    gem 'dotenv-rails', groups: [:development, :test]

次に、アプリケーションのルートディレクトリに`.env`ファイルを作成し、[Developer Dashboard](https://dashboard.nexmo.com)にあるAPIキーとシークレットを設定します：

**`.env`** 

    VONAGE_API_KEY=your_api_key
    VONAGE_API_SECRET=your_api_secret

ユーザーは2要素認証が有効になっているかどうかを確認する`before_action`を`ApplicationController`に追加します。その場合は、続行を許可する前に検証されていることを確認してください：

**`app/controllers/application_controller.rb`** 

```ruby
before_action :verify_user!, unless: :devise_controller?
 
def verify_user!
  start_verification if requires_verification?
end
```

ユーザーが確認を必要とするかどうかを判断するには、電話番号で登録されているかどうか、および`:verified`セッションプロパティが設定されていないことを確認します：

**`app/controllers/application_controller.rb`** 

```ruby
def requires_verification?
  session[:verified].nil? && !current_user.phone_number.blank?
end
```

検証プロセスを開始するには、`Nexmo::Client`オブジェクトで`send_verification_request`を呼び出します。APIキーとシークレットは、`.env`で設定した環境値によって既に初期化されているため、APIキーとシークレットを受け渡す必要はありません：

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

> 検証要求には、Webアプリケーションの名前を渡します。これは、ユーザーが受信したテキストメッセージで使用され、どこから来たかを認識することができます。

メッセージが正常に送信された場合は、受信したコードを入力できるページにユーザーをリダイレクトする必要があります。これを行い、次のステップでコードが正しいかどうかを確認します。

