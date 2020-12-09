---
title:  Number Insight Advanced API

products: number-insight

description:  番号の有効性とリーチャビリティに関する包括的な情報にアクセスする方法について説明します。

languages:
  - Node


---

Number Insight Advanced API
===========================

Number Insight APIは、世界中の電話番号に関するリアルタイムの情報を提供します。Basic、Standard、Advancedの3つのレベルがあります。

Advancedレベルでは、詐欺やスパムから組織を保護するのに役立つ、最も包括的なデータを提供します。BasicレベルおよびStandardレベルとは異なり、Advanced APIには、通常[Webhook](/concepts/guides/webhooks)を介して非同期的にアクセスします。

このチュートリアルでは、
------------

このチュートリアルでは、Node.jsとExpressに単純なRESTful Webサービスを作成します。このサービスは、電話番号を受け入れ、番号が使用可能になったときにその番号に関するインサイト情報を返します。

これを実現するには、次の手順を実行します。

1. [プロジェクトを作成する](#create-the-project) - Node.js/Expressアプリケーションを作成します。
2. [`nexmo`パッケージをインストールする](#install-the-nexmo-package) - Vonage機能をプロジェクトに追加します。
3. [アプリケーションをインターネットに公開する](#expose-your-application-to-the-internet) - `ngrok`を使用して、VonageがWebhook経由でアプリケーションにアクセスできるようにします。
4. [基本的なアプリケーションを作成する](#create-the-basic-application) - 基本的な機能を構築します。
5. [非同期リクエストを作成する](#create-the-asynchronous-request) - Number Insight Advanced APIを作成します。
6. [Webhookを作成する](#create-the-webhook) - 受信インサイトデータを処理するコードを記述します。
7. [アプリケーションをテストする](#test-the-application) - 動作することを確認します。

準備
---

このチュートリアルを完了するには、以下が必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up) - APIキーおよびシークレット用
* [ngrok](https://ngrok.com/) - 開発用Webサーバーをインターネット経由でVonageのサーバーにアクセスできるようにする

プロジェクトを作成する
-----------

アプリケーション用のディレクトリを作成し、そのディレクトリに`cd`して、 Node.jsパッケージマネージャー`npm`を使用して、アプリケーションの依存性用の`package.json`ファイルを作成します。

```sh
$ mkdir myapp
$ cd myapp
$ npm init
```

Enterキーを押して、既定値を受け入れます。

次に、[Express](https://expressjs.com) Webアプリケーションフレームワークと[body-parser](https://www.npmjs.com/package/body-parser)パッケージをインストールします。

```sh
$ npm install express body-parser  --save
```

`nexmo`パッケージのインストール
-------------------

ターミナルウィンドウで次の`npm`コマンドを実行して、Vonage Node Server SDKをインストールします。

```sh
$ npm install nexmo --save
```

アプリケーションをインターネットに公開する
---------------------

Number Insight APIがリクエストの処理を終了すると、[Webhook](/concepts/guides/webhooks)経由でアプリケーションに警告します。Webhookは、Vonageのサーバーがお客様のサーバーと通信するためのメカニズムを提供します。

アプリケーションがVonageのサーバーにアクセスできるようにするには、アプリケーションがインターネットに公開されている必要があります。開発中およびテスト中にこれを簡単に実現するには、ngrokを使用します。[ngrok](https://ngrok.com)は、安全なトンネルを介してローカルサーバーをパブリックインターネットに公開するサービスです。詳細については、[こちらのブログ記事](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)をご覧ください。

[ngrok](https://ngrok.com)をダウンロードしてインストールし、次のコマンドで起動します。

```sh
$ ./ngrok http 5000
```

これにより、ローカルマシンのポート5000で実行されているWebサイトのパブリックURL（HTTPおよび HTTPS）が作成されます。

http://localhost:4040の`ngrok`Webインターフェースを使用して、`ngrok`が提供するURLをメモします。このチュートリアルを完了するには、URLが必要です。

基本的なアプリケーションを作成する
-----------------

次のコードを使用してアプリケーションディレクトリに`index.js`ファイルを作成し、`VONAGE_API_KEY`、`VONAGE_API_SECRET`、および`WEBHOOK_URL`の定数を独自の値に置き換えます。

```javascript
const app = require('express')();
const bodyParser = require('body-parser');

app.set('port', 5000));
app.use(bodyParser.json());

const VONAGE_API_KEY = // Your Vonage API key
const VONAGE_API_SECRET = // Your Vonage API secret
const WEBHOOK_URL = // e.g. https://bcac78a0.ngrok.io/webhooks/insight

app.get('/insight/:number', function(request, response) {
    console.log("Getting information for " + request.params.number);
}); 

app.listen(app.get('port'), function() {
    console.log('Listening on port', app.get('port'));
});
```

ターミナルで次のコマンドを実行し、表示される結果を受け取ってテストします。

```sh
$ node index.js
Listening on port 5000
```

ブラウザで次のURLを入力し、`https://bcac78a0.ngrok.io`を、`ngrok`が提供するホスト名に置き換えます。

    https://bcac78a0.ngrok.io/insight/123456

すべて正常に動作している場合は、`Getting information for 123456`がターミナルに表示されます。

非同期リクエストを作成する
-------------

これでアプリケーションが電話番号を受信できるようになったので、Number Insight Async APIへの非同期リクエストを作成する必要があります。

まず、アカウントの詳細が含まれる`Nexmo`のインスタンスを作成するコードを記述します。

```javascript
const Nexmo = require('nexmo');
const nexmo = new Nexmo({
    apiKey: VONAGE_API_KEY,
    apiSecret: VONAGE_API_SECRET
});
```

次に、`/insight/:number`ルートを拡張してNumber Insight APIを呼び出し、興味のある番号と、応答を処理するWebhookのURLを渡します。Webhookは、後の手順で作成します。

```javascript
app.get('/insight/:number', function(request, response) {
    console.log("Getting information for " + request.params.number);
    nexmo.numberInsight.get({
        level: 'advancedAsync',
        number: request.params.number,
	callback: WEBHOOK_URL
    }, function (error, result) {
	if (error) {
	    console.error(error);
	} else {
	    console.log(result);
	}
    });
});
```

Number Insight Advanced APIを呼び出すと、実際のインサイトデータが使用可能になる前に、リクエストを確認する応答が即時に返されます。コンソールに記録しているのは、この応答です。

```sh
{
  request_id: '3e6e31a4-3efb-49ab-8751-5a43e4de6406',
  number: '447700900000',
  remaining_balance: '17.775',
  request_price: '0.03000000',
  status: 0
}
```

リクエスト本文の`status`フィールドには、操作が成功したかどうかが示されます。[Number Insight APIの関連情報ドキュメント](/api/number-insight#getNumberInsightAsync)で説明されているように、0の値は成功を示し、0以外の値は失敗を示します。

Webhook
-------

Insight APIは、`POST`リクエストを介してアプリケーションに結果を返すため、次のように`/webhooks/insight`ルートハンドラを`app.post()`として定義する必要があります。

```javascript
app.post('/webhooks/insight', function (request, response) {
    console.dir(request.body);
    response.status(204).send();
});
```

ハンドラは、着信JSONデータをコンソールに記録し、`204`のHTTP応答を Vonageのサーバーに送信します。

> HTTPステータスコード204は、サーバーが要求を正常に満たし、応答ペイロード本文で送信する追加のコンテンツがないことを示します。

アプリケーションをテストする
--------------

`index.js`を実行します。

```sh
$ node index.js
```

ブラウザのアドレスバーに次の形式でURLを入力し、`https://bcac78a0.ngrok.io`を`ngrok`のURLに、`INSIGHT_NUMBER`を任意の電話番号に置き換えます。

    http://YOUR_NGROK_HOSTNAME/insight/NUMBER

最初の確認応答の後、コンソールには次のような情報が表示されます。

```sh
{
  "status": 0,
  "status_message": "Success",
  "lookup_outcome": 0,
  "lookup_outcome_message": "Success",
  "request_id": "55a7ed8e-ba3f-4730-8b5e-c2e787cbb2b2",
  "international_format_number": "447700900000",
  "national_format_number": "07700 900000",
  "country_code": "GB",
  "country_code_iso3": "GBR",
  "country_name": "United Kingdom",
  "country_prefix": "44",
  "request_price": "0.03000000",
  "remaining_balance": "1.97",
  "current_carrier": {
    "network_code": "23410",
    "name": "Telefonica UK Limited",
    "country": "GB",
    "network_type": "mobile"
  },
  "original_carrier": {
    "network_code": "23410",
    "name": "Telefonica UK Limited",
    "country": "GB",
    "network_type": "mobile"
  },
  "valid_number": "valid",
  "reachable": "reachable",
  "ported": "not_ported",
  "roaming": {
    "status": "not_roaming"
  }
}
```

アプリケーションをテストするときは、次の点を考慮してください。

* Insight Advanced APIでは、Standard APIでは利用できない固定電話に関する情報は提供されません。
* Insight APIへのリクエストは無料ではありません。不要な料金の発生を避けるため、`ngrok`ダッシュボードを使用して、開発中に以前のリクエストを再実行することを検討してください。

まとめ
---

このチュートリアルでは、Number Insight Advanced Async APIを使用してWebhookにデータを返す単純なアプリケーションを作成しました。

チュートリアルでは、IPアドレスの一致、リーチャビリティ、ローミングステータスなど、Advanced API固有の機能の一部については触れていません。これらの機能の使用方法については、[ドキュメント](/number-insight/overview)を参照してください。

次の作業
----

以下のリソースは、アプリケーションでNumber Insightを使用する際の参考になります。

* GitHubにあるこのチュートリアルの[ソースコード](https://github.com/Nexmo/ni-node-async-tutorial)
* [Number Insight APIの製品ページ](https://www.nexmo.com/products/number-insight)
* [Basic、Standard、Advanced Insight APIの比較](/number-insight/overview#basic-standard-and-advanced-apis)
* [Webhookガイド](/concepts/guides/webhooks)
* [Number Insight Advanced APIの関連情報](/api/number-insight#getNumberInsightAsync)
* [ngrokトンネルを使用してローカル開発サーバーをVonage APIに接続する](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)
* [その他のチュートリアル](/number-insight/tutorials)

