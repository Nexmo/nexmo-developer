---
title:  番号を検証する

products: number-insight

description:  RubyコードからNumber Insightと開発者用APIを使用して、番号を呼び出したりメッセージを送ったりするコストを検証し、サニタイズし、決定することができます。

languages:
  - Ruby


---

番号を検証する
=======

Number Insight APIを使用すると、顧客が提供した番号を検証して不正行為を防止し、将来的にその顧客に再度連絡を取ることができるようになります。また、番号のフォーマットや、その番号が携帯電話か固定電話かなど、他にも役立つ情報を提供してくれます。

Number Insight APIには次の3つの製品レベルがあります。

* Basic API：番号がどの国に属しているかを検出し、その情報を使用して数字を正しくフォーマットします。
* Standard API：番号が固定電話か携帯電話かを判断し（音声とSMS連絡先のどちらかを選択）、仮想番号をブロックします。
* Advanced API：番号に関連するリスクを計算します。

> [Basic、Standard、Advanced API](/number-insight/overview#basic-standard-and-advanced-apis)の詳細をご覧ください。
> **注** ：Number Insight Basic APIへのリクエストは無料です。他のレベルのAPIはコストが発生します。詳細については、[APIリファレンス](/api/number-insight)を参照してください。

[RubyサーバーSDK](http://github.com/nexmo/nexmo-ruby)を使えば、Number Insight APIに簡単にアクセスできます。また、価格設定APIなどの他のAPIとの連携も可能になります。これは、電話番号の検証とサニタイズだけでなく、このチュートリアルの[コストを計算する](#calculate-the-cost)のセクションで説明するように、その電話番号にテキストメッセージや音声通話を送信するためのコストの確認ができることを意味します。

このチュートリアルの内容
------------

RubyサーバーSDKを使用して電話番号をサニタイズ、および検証する方法を学びます。

* [開始する前に](#before-you-begin)、このチュートリアルを完了するために必要なものがあることを確認してください。
* GitHubでチュートリアルのソースコードを複製して[プロジェクトを作成](#create-the-project)し、Vonageアカウントの詳細を使用して構成します
* RubyサーバーSDKを含む[依存関係をインストール](#install-the-dependencies)します
* コードがどのように動作するかを知るために[コードを試行します](#code-walkthrough)

始める前に
-----

このチュートリアルを完了するには、以下のものが必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)の `api_key`と`api_secret` - まだ取得していない場合は、アカウントのサインアップを行ってください。
* GitHubの[チュートリアルソースコード](https://github.com/Nexmo/ruby-ni-customer-number-validation)へのアクセス権

プロジェクトを作成する
-----------

[チュートリアルのソースコード](https://github.com/Nexmo/ruby-ni-customer-number-validation)リポジトリを複製します。

    git clone git@github.com:Nexmo/ruby-ni-customer-number-validation.git

プロジェクトフォルダに変更します。

    cd ruby-ni-customer-number-validation

`.env-example`ファイルを`.env`にコピーし、[Dashboard](https://dashboard.nexmo.com)からAPIキーとシークレットを設定するために`.env`を編集します。

    VONAGE_API_KEY="(Your API key)"
    VONAGE_API_SECRET="(Your API secret)"

依存関係をインストールする
-------------

プロジェクトの依存関係をインストールするために、`bundle install`を実行します。

```ruby
$ bundle install
Fetching gem metadata from https://rubygems.org/...
Resolving dependencies...
Using bundler 1.16.4
Using dotenv 2.1.1
Using jwt 2.1.0
Using nexmo 5.4.0
Bundle complete! 2 Gemfile dependencies, 4 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

コードを試行する
--------

このチュートリアルプロジェクトはアプリケーションではなく、Number Insight APIの使用方法を示すコードスニペットのコレクションです。この試行では、各スニペットを順番に実行し、それがどのように動作するかを学びます。

### 国を決定する

このサンプルでは、Number Insight Basic APIを使用して、番号が属する国を調べます。

#### コードを実行する

`snippets/1_country_code.rb` rubyファイルを実行します。

    $ ruby snippets/1_country_code.rb

これは、国際形式の電話番号と、電話番号が登録されている名前、コード、プレフィックス番号を返します。

```ruby
{
    "status" => 0,
    "status_message" => "Success",
    "request_id" => "923c7054-3201-4146-b6df-23bfe929cd03",
    "international_format_number" => "442079460000",
    "national_format_number" => "020 7946 0000",
    "country_code" => "GB",
    "country_code_iso3" => "GBR",
    "country_name" => "United Kingdom",
    "country_prefix" => "44"
}
```

#### 仕組み

まず、`nexmo`クライアントオブジェクトを、`.env`ファイルで設定したAPIキーとシークレットで作成します。

```ruby
require 'nexmo'
nexmo = Nexmo::Client.new(
  api_key: ENV['VONAGE_API_KEY'],
  api_secret: ENV['VONAGE_API_SECRET']
)
```

次に、Number Insight Basic APIを呼び出し、`number`を渡して、次の情報を提供します。

```ruby
puts nexmo.number_insight.basic(number:  "442079460000")
```

### 番号をサニタイズする

顧客が国際形式ではない電話番号を提供する場合があります。つまり、国際プレフィックス番号が含まれていません。このサンプルでは、Number Insight Basic APIを使用して番号を正しくフォーマットする方法を紹介しています。

> ほとんどのVonage APIは電話番号が国際形式であることを想定しているため、Number Insight Basic APIを使用して、使用する前に番号をサニタイズすることができます。

#### コードを実行する

`snippets/2_cleanup.rb` rubyファイルを実行します。

    $ ruby snippets/2_cleanup.rb

これは、提供されたローカル番号（`020 3198 0560`、英国（`GB`) の番号）を`44`のプレフィックス番号付きの国際形式で返します。

    "442031980560"

#### 仕組み

国際形式の電話番号を取得するには、ローカル形式の電話番号と国コードを指定してNumber Insight Basic APIを呼び出します。

```ruby
insight = nexmo.number_insight.basic(
  number:  "020 3198 0560",
  country: 'GB'
)

p insight.international_format_number
```

### 番号の種類を決定する（固定電話または携帯電話）

Number Insight Standard APIは、Basic APIよりも電話番号に関するより多くの情報を提供しており、Basic APIが提供するすべてのデータが含まれています。その中でも特に便利なのが、どのような *タイプ* の番号を扱っているが分かる機能で、その番号に連絡するのに最適な方法が決められます。

#### コードを実行する

`snippets/3_channels.rb` rubyファイルを実行します。

    $ ruby snippets/3_channels.rb

この電話番号はイギリスの固定電話に割り当てられており、SMSよりも音声の方が良い選択になることが分かります。

```ruby
{
    "network_code" => "GB-FIXED",
            "name" => "United Kingdom Landline",
         "country" => "GB",
    "network_type" => "landline"
}
```

#### 仕組み

番号のタイプを調べるには、Number Insight Standard APIを呼び出して、ここで示すように国コードを含むローカル番号を渡します。

```ruby
insight = nexmo.number_insight.standard(
  number:  "020 3198 0560",
  country: 'GB'
)
```

また、`country`を指定せずに、国際形式で`number`を渡すこともできます。

```ruby
insight = nexmo.number_insight.standard(
  number:  "442031980560"
)
```

そして、現在の通信会社の情報を検索して、番号の種類（携帯電話か固定電話か）を表示します。

```ruby
p insight.current_carrier
```

### コストを計算する

Number Insight APIと[価格設定](/api/developer/pricing)APIを併用して、その番号がどのネットワーク上にあるか、その番号に電話をかけたり、SMSを送信したりするにはいくらかかるかを判断できます。

#### コードを実行する

`snippets/4_cost.rb` rubyファイルを実行します。

    $ ruby snippets/4_cost.rb

応答は、SMSメッセージを送信するための費用、または電話番号への音声通話の1分あたりの料金を示します。

```ruby
{
      :sms => [{
                "type" => "landline",
               "price" => "0.03330000",
            "currency" => "EUR",
              "ranges" => [441, 442, 443],
        "network_code" => "GB-FIXED",
        "network_name" => "United Kingdom Landline"}],
    :voice => [{
               "type" => "landline",
              "price" => "0.01200000",
           "currency" => "EUR",
             "ranges" => [441, 442, 443],
       "network_code" => "GB-FIXED",
       "network_name" => "United Kingdom Landline"}]
}
```

この出力は、この番号が固定電話であることを示しており、音声通話が最適で、1分あたり0\.12ユーロの費用で通話できることが分かります。

#### 仕組み

このコードはまずNumber Insight Standard APIを呼び出し、番号が現在登録されているネットワークや発信国に関する情報を提供します（この機能はBasic APIでも利用可能です）。

```ruby
insight = nexmo.number_insight.standard(
  number:  '020 3198 0560',
  country: 'GB'
)

# Store the network and country codes
current_network = insight.current_carrier.network_code
current_country = insight.country_code
```

その後、[価格設定](/api/developer/pricing)APIを使用して、その国のすべての通信会社の通話とテキスト送信のコストを取得します。

```ruby
# Fetch the voice and SMS pricing data for the country
sms_pricing = nexmo.pricing.sms.get(current_country)
voice_pricing = nexmo.pricing.voice.get(current_country)
```

Ruby RESTクライアントAPIで価格データを取得するためのその他のオプションは次のとおりです。

* `nexmo.pricing.sms.list()` または`nexmo.pricing.voice.list()` - *すべての* 国の価格データを取得します
* `nexmo.pricing.sms.prefix(prefix)` または`nexmo.pricing.voice.prefix(prefix)` - 英国の`44`のように、特定の国際プレフィックス番号の価格データを取得します

次に、コードは、番号が属する特定のネットワークのコストを検索し、その情報を表示します。

```ruby
# Retrieve the network cost from the pricing data
sms_cost = sms_pricing.networks.select{|network| network.network_code == current_network}
voice_cost = voice_pricing.networks.select{|network| network.network_code == current_network}

p({
  sms: sms_cost,
  voice: voice_cost
})
```

### 携帯電話番号を検証する

Number Insight Advanced APIを使用すると、番号を検証して、その番号が本物である可能性が高く、信頼できる方法で顧客に連絡できるかどうかを判断できます。携帯電話の番号については、番号がアクティブかどうか、ローミング中であるかどうか、到達可能でIPアドレスと同じ場所にあるかどうかを検出することもできます。Advanced APIには、Basic APIとStandard APIのすべての情報が含まれます。

#### コードを実行する

`snippets/5_validation.rb` rubyファイルを実行します。

    $ ruby snippets/5_validation.rb

この場合、応答はその番号が`valid`であることを示しています。

```ruby
"valid"
```

電話番号から数桁の数字を削除してプログラムを再実行すると、Number Insight Advanced APIは、その番号が`not_valid`であることをレポートします。

```ruby
"not_valid"
```

Number Insight Advanced APIで番号が有効かどうかを判断できない場合は、`unknown`という応答が表示されます。

```ruby
"unknown"
```

#### 仕組み

このコードは、Basic APIで使用できる機能を使用して、以前と同様に番号の国際表記を要求しますが、Advanced APIには次のものも含まれています。

```ruby
insight = nexmo.number_insight.advanced(
  number:  "020 3198 0560",
  country: 'GB'
)
```

また、応答から`valid_number`フィールドを返して表示します。このフィールドの値は、`valid`、`not_valid`、または`unknown`のいずれかです。

```ruby
p insight.valid_number
```

まとめ
---

このチュートリアルでは、番号の国際形式を検証して決定し、その番号への通話やSMSメッセージの送信にかかる費用を計算する方法を学びました。

リソースと関連情報
---------

* Number Insightで可能なその他の機能については、[Number Insightガイド](/number-insight)をご覧ください。
* Number Insightに関する[ブログ記事](https://www.nexmo.com/?s=number+insight)をご覧ください。
* 各エンドポイントの詳細なドキュメントについては、[Number Insight API リファレンス](/api/number-insight)を参照してください。

