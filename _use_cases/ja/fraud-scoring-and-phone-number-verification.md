---
title:  不正スコアリングと電話番号の検証

products: number-insight

description:  Number Insight AdvancedとVerify APIを併用して、独自の不正検知システムを構築できます。この手法で、不正取引から組織を守りつつ、多くのお客様にとって摩擦のない処理を行うことができます。

languages:
  - Node


---

不正スコアリングと電話番号の検証
================

[Number Insight Advanced](/number-insight)と[Verify API](/verify/api-reference/)を併用して、独自の不正検知システムを構築できます。この手法で、不正取引から組織を守りつつ、多くのお客様にとって摩擦のない処理を行うことができます。

このチュートリアルの内容
------------

このチュートリアルでは、お客様が提供した番号を、Number Insight Advanced APIを使用してプリスクリーニングし、チェック結果が不正の可能性を示した場合のみ、番号をPINコードを用いて検証する方法について説明します。

ユーザーが電話番号を提供してアカウントを登録できるアプリケーションを構築します。その番号を、Number Insight Advanced APIを使用してチェックし、ユーザーのIPアドレスと同じ国のものであるかを判別します。番号が属する国（またはローミング国）とユーザーのIPアドレスの国（またはローミング国）が一致しない場合、その番号に不正の可能性があるとしてフラグを立てます。次に、Verify APIの2要素認証（2FA）機能を使用して、ユーザーが番号を所有していることを確認します。

これを行うには、以下の手順に従います。

* [アプリケーションを作成する](#create-an-application) - ユーザーの電話番号を受け取るアプリケーションを作成します。
* [Vonage Node Server SDKをインストールする](#install-the-nexmo-rest-client-api-for-node) - Vonageの機能をアプリケーションに追加します。
* [アプリケーションを構成する](#configure-the-application) - APIキーとシークレット、およびその他の設定を構成ファイルから読み込みます。
* [電話番号を処理する](#process-a-phone-number) - ユーザーが送信した番号の処理ロジックを構築します。
* [不正の可能性をチェックする](#check-for-possible-fraud) - Number Insight APIを使用して、関連付けられているデバイスの場所を特定します。
* [確認コードを送信する](#send-a-verification-code) - 番号が確認手順をトリガーした場合、Verify APIを使用してユーザーの電話にコードを送信します。
* [確認コードをチェックする](#check-the-verification-code) - ユーザーが入力した確認コードが有効であるかチェックします。

準備
---

このチュートリアルを完了するためには、以下のものが必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)の `api_key`と`api_secret` - まだ取得していない場合は、アカウントのサインアップを行ってください。
* Node.jsと`express`パッケージの基本的知識。
* VonageがアプリにWebhookリクエストを送信できるように、一般にアクセス可能なWebサーバー。ローカル開発の場合、[ngrok](https://ngrok.com/)をお勧めします。

> [使用方法を確認する `ngrok`](/tools/ngrok)

アプリケーションを作成する
-------------

サーバーと不正検知ビジネスロジックとが分離するようにアプリケーションを構築します。

1. 基本的なアプリケーションのディレクトリを作成します。

   ```sh
   $ mkdir fraudapp;
   $ cd fraudapp;
   $ mkdir lib views 
   ```

2. `npm init`を使用してプロジェクトの`package.json`ファイルを作成し、プロンプトが表示されたら、エントリポイントとして`lib/server.js`ファイルを指定します。

3. 依存関係をインストールします。

   ```javascript
   $ npm install express dotenv pug body-parser --save
   ```

4. `lib/server.js`ファイルを作成します。これが、アプリケーションの開始点となり、他のすべてのパーツが動作します。`lib/app.js`ファイルが読み込まれ、`FraudDetection`クラスがインスタンス化されて`lib/routes.js`からのルートが組み込まれます。これらはすべて間をおかず作成されます。

   `lib/server.js`には次のコードを含めます。

   ```javascript
   // start a new app
   var app = require('./app')
   
   // load our fraud prevention module
   var FraudDetection = require('./FraudDetection');
   var fraudDetection = new FraudDetection();
   
   // handle all routes
   require('./routes')(app, fraudDetection);
   ```

### 初期ルートを定義する

`lib/routes.js`ファイルを作成して、アプリケーションのルートを定義します。ホームページ（`/`）が [GET] リクエストを受信したときにユーザーが番号を入力するためのフォームを表示するハンドラをコーディングします。

```javascript
module.exports = function(app, detector) {
  app.get('/', function(req, res) {
    res.render('index');
  });
};
```

### Webサーバーを起動する

Webサーバーを起動する`lib/app.js`ファイルを作成します。以下に示すコードは、サーバーを、`PORT`環境変数で指定したポート上、または`PORT`環境変数が設定されていない場合はポート5000で起動します。

```javascript
var express = require('express');
var bodyParser = require('body-parser');

// create a new express server
var app = express();
app.set('port', (process.env.PORT || 5000));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'))
app.set('view engine', 'pug')

// start the app and listen on port 5000
app.listen(app.get('port'), '127.0.0.1', function() {
  console.log('Fraud app listening on port', app.get('port'));
});

module.exports = app;
```

### 登録フォームを作成する

`pug`テンプレートエンジンを使用して、アプリケーションで必要なHTMLフォームを作成します。

1. 次の内容の基本ビューを`views/layout.pug`ファイルに作成します。

   ```pug
   doctype html
   html(lang="en")
     head
       title Vonage Fraud Detection
       link(href='style.css', rel='stylesheet')
     body
       #container
         block content
   ```

2. 登録する番号をユーザーが入力できるようにする`views/index.pug`ファイルを作成します。

   ```pug
   extends ./layout
   
   block content
     h1 Register your number
     form(method='post')
       .field
         label(for='number') Phone number
         input(type='text', name='number', placeholder='1444555666')
       .actions
         input(type='submit', value='Register')
   ```

Vonage Node Server SDKをインストールする
-------------------------------

ターミナルプロンプトで次のコマンドを実行し、[Vonage Node Server SDK](https://github.com/Nexmo/nexmo-node)パッケージをプロジェクトに追加します。

```sh
$ npm install nexmo --save
```

アプリケーションを構成する
-------------

`lib/server.js`ファイルの先頭に次の`require`ステートメントを組み込んで、`.env`ファイルから資格情報を読み込むようにアプリケーションを構成します。

```javascript
require('dotenv').config();
```

次のエントリをアプリケーションフォルダのルートにある`.env`ファイルに追加します。このとき、`YOUR_NEXMO_API_KEY`と`YOUR_NEXMO_API_SECRET`を[Developer Dashboard](https://dashboard.nexmo.com)のAPIキーとシークレットに置き換えます。

    NEXMO_API_KEY=YOUR_NEXMO_API_KEY
    NEXMO_API_SECRET=YOUR_NEXMO_API_SECRET
    IP=216.58.212.78 # USA IP
    # IP=212.58.244.22 # UK IP

`IP`エントリは、ユーザーがどの国からアプリケーションにアクセスしているかを特定するためにユーザーの現在のIPアドレスをシミュレートする、後の手順で使用します。1つはイギリス、もう1つは米国です。米国の`IP`はコメントアウトされているため、テスト用にユーザーの場所を変更することができます。

電話番号を処理する
---------

### 不正の可能性を判断する方法

これで、基本アプリケーションが起動し、番号を処理するロジックを記述することができます。

Number Insight APIからの情報を使用して、不正の可能性がある番号をチェックします。とりわけ、Number Insight Advanced APIから、その番号が属する国と、（番号が携帯電話のものでユーザーがローミングしている場合）関連付けられているデバイスが現在ある国が分かります。

本番環境では、ユーザーのIPアドレスはプログラムで判別します。このサンプルアプリケーションでは、ユーザーの現在のIPアドレスは`.env`ファイルの`IP`エントリから読み取り、[MaxMind GeoIP](https://www.maxmind.com)データベースを使用して地理的場所を判別します。

[MaxMind GeoLite 2 Country Database](https://dev.maxmind.com/geoip/geoip2/geolite2/)をダウンロードして、`Geolite2-Country.mmdb`ファイルをアプリケーションディレクトリのルートに解凍します。ターミナルプロンプトで、以下を実行してインストールします。

```sh
$ npm install maxmind --save
```

ユーザーの現在のIPアドレスがNumber Insightから報告されたものと異なる場合、Verify APIを使用して番号の所有者を確認するよう強制できます。この方法では、提供された番号がデバイスが属する国と異なる場合にのみ、確認手順を強制的に課します。

従って、アプリケーションは次の一連のイベントをトリガーする必要があります。

```sequence_diagram
Participant Browser
Participant App
Participant Vonage
Note over App,Vonage: Initialization
Browser->>App: User registers by \nsubmitting number
App->>Vonage: Number Insight request
Vonage-->>App: Number Insight response
Note over App,Vonage: If Number Insight shows that the \nuser and their phone are in different \ncountries, start the verification process
App->>Vonage: Send verification code to user's phone
Vonage-->>App: Receive acknowledgement that\nverification code was sent
App->>Browser: Request the code from the user
Browser->>App: User submits the code they received
App->>Vonage: Check verification code
Vonage-->>App: Code Verification status
Note over Browser,App: If either Number Insight response or verification step \nis satisfactory, continue registration
App->>Browser: Confirm registration
```

### 不正検出ロジックを作成する

アプリケーションの`lib`フォルダに`FraudDetection`クラスの`FraudDetection.js`ファイルを作成します。クラスコンストラクタで、最初に`Nexmo`のインスタンスを作成します。これに、`.env`構成ファイルにあるVonage APIキーとシークレットを指定します。

```javascript
var Nexmo = require('nexmo');

var FraudDetection = function(config) {
  this.nexmo = new Nexmo({
    apiKey: process.env.VONAGE_API_KEY,
    apiSecret: process.env.VONAGE_API_SECRET
  });
};

module.exports = FraudDetection;
```

次に、次のように`FraudDetection.js`ファイルを編集して、IPルックアップを作成します。

```javascript
var Nexmo = require('nexmo');
var maxmind = require('maxmind');

var FraudDetection = function(config) {
  this.nexmo = new Nexmo({
    apiKey: process.env.VONAGE_API_KEY,
    apiSecret: process.env.VONAGE_API_SECRET
  });

  maxmind.open(__dirname + '/../GeoLite2-Country.mmdb', (err, countryLookup) => {
    this.countryLookup = countryLookup;
  });
};

module.exports = FraudDetection;
```

ユーザーが電話番号を送信すると、これをユーザーの現在のIPとともに不正検知コードに渡します。不正検知ロジックで電話番号とユーザーの場所とが一致しないと判断された場合は、確認コードが送信されます。これは、次のように`lib/routes.js`に [POST] リクエストの`/`ルートハンドラを追加することで実装します。

```javascript
  app.post('/', function(req, res) {
    var number = req.body.number;

    detector.matchesLocation(number, req, function(matches){
      if (matches) {
        res.redirect('/registered');
      } else {
        detector.startVerification(number, function(error, result){
          res.redirect('/confirm?request_id='+result.request_id);
        });
      }
    });
  });
```

不正の可能性をチェックする
-------------

`FraudDetection`クラスで、ユーザーのIPをリクエストから抽出し、MaxMind国データベースを使用してユーザーがアプリケーションにアクセスしている国を判別します。

次に、Number Insight Advanced APIへの非同期リクエストを行い、ユーザーが登録した電話番号が現在ローミングされているかどうかを確認し、これによって、比較すべき正しい国を特定します。

このデータをすべて組み合わせることで、シンプルなリスクモデルを構築することができます。国が一致しない場合は次のステップをトリガーします。

次のメソッドを、`lib\FraudDetection.js`の`FraudDetection`クラスに追加します。

```javascript
FraudDetection.prototype.matchesLocation = function(number, request, callback) {
  var ip = process.env['IP'] || req.headers["x-forwarded-for"] || req.connection.remoteAddress;
  var geoData = this.countryLookup.get(ip);

  this.nexmo.numberInsight.get({
    level: 'advancedSync',
    number: number
  }, function(error, insight) {
    var isRoaming = insight.roaming.status !== 'not_roaming';

    if (isRoaming) {
      var matches = insight.roaming.roaming_country_code == geoData.country.iso_code;
    } else {
      var matches = insight.country_code == geoData.country.iso_code;

    }
    callback(matches)
  });
}
```

確認コードを送信する
----------

1. リスクモデルが不正の可能性がある番号を検知したときにVonageのVerify APIを使用して電話に確認コードを送信するよう、`lib\FraudDetection.js`を修正します。次のメソッドをクラスに追加します。

   ```javascript
   FraudDetection.prototype.startVerification = function(number, callback) {
     this.nexmo.verify.request({
       number: number,
       brand: 'ACME Corp'
     }, callback);
   };
   ```

2. `lib/routes.js`で、新しいルートを追加して、ユーザーが電話で受信した確認コードを入力できるようにします。

   ```javascript
   app.get('/confirm', function(req, res) {
     res.render('confirm', {
       request_id: req.query.request_id
     });
   });
   ```

3. `views/confirm.pug`で、確認コードを入力するためのユーザー向けの表示を作成します。

   ```pug
   extends ./layout
   
   block content
     h1 Confirm the code
     #flash_alert We have sent a confirmation code to your phone number. Please fill in the code below to continue.
     form(method='post')
       .field
         label(for='code') Code
         input(type='text', name='code', placeholder='1234')
         input(type='hidden', name='request_id', value=request_id)
       .actions
         input(type='submit', value='Confirm')
   ```

確認コードをチェックする
------------

1. `lib/routes.js`で、ユーザーが正しい確認コードを入力した場合は、ユーザーを`/registered`にリダイレクトします。それ以外の場合は、`/confirm`に戻します。

   ```javascript
   app.post('/confirm', function(req, res) {
     var code = req.body.code;
     var request_id = req.body.request_id;
   
     detector.checkVerification(request_id, code, function(error, result) {
       if (result.status == '0') {
         res.redirect('/registered');
       } else {
         res.redirect('/confirm');
       }
     });
   });
   ```

2. `lib/FraudDetection.js`で、ユーザーが送信したコードと、送信された確認用のリクエストIDとをチェックします。

   ```javascript
   FraudDetection.prototype.checkVerification = function(request_id, code, callback) {
     this.nexmo.verify.check({
       code: code,
       request_id: request_id
     }, callback);
   };
   ```

3. これらのステップに合格したユーザーには登録を確認する分かりやすいメッセージが表示されるよう、次のルートを`lib/routes.js`に追加します。

   ```javascript
   app.get('/registered', function(req, res) {
     res.render('registered');
   });
   ```

4. `lib/registered.pug`に従って表示を作成します。

   ```pug
   extends ./layout
   
   block content
     h1 Registered
     #flash_notice You are now fully signed up. Thank you for providing your phone number.
   ```

アプリケーションをテストする
--------------

1. アプリケーションを起動します。

   ```sh
   $ node lib/server.js
   ```

2. `ngrok`を実行します。

   ```sh
   $ ./ngrok http 5000
   ```

3. ブラウザで、`ngrok`が提供するアドレスに移動します（`https://7db5972b.ngrok.io`など）。

4. 電話番号を入力します。`.env`の`IP`エントリがモバイルデバイスの現在の場所と一致する場合は、デバイスが正常に登録されていることが表示されます。そうでない場合は、確認コードが送信され、登録前にその確認コードの入力を求められます。

まとめ
---

このチュートリアルでは、基本的な不正検知システムを構築しました。不正の可能性がある番号は、[Number Insight Advanced API](/verify/api-reference/)からの次の情報を使用してフラグを立てました。

* ユーザーの現在のIPの国
* 電話番号が属する国
* 番号のローミングステータス
* ローミング国

また、[Verify API](/verify)を使用して番号を確認する方法も説明しました。

次のステップ
------

こうしたタイプのアプリケーションを構築する際に便利なリソースをいくつかご紹介します。

* GitHubにあるこのチュートリアルの[ソースコード](https://github.com/Nexmo/node-verify-fraud-detection)
* 次の方法を示すコードサンプル 
  * Number Insight Advanced APIデータを非同期で[リクエスト](/number-insight/code-snippets/number-insight-advanced-async)および[受信](/number-insight/code-snippets/number-insight-advanced-async-callback)する方法
  * Verify APIを使用して確認コードを[送信](/verify/code-snippets/send-verify-request)および[チェック](/verify/code-snippets/check-verify-request)する方法

* ブログ記事： 
  * [Number Insight API](https://www.nexmo.com/?s=number+insight)
  * [Verify API](https://www.nexmo.com/?s=verify)

* APIリファレンスドキュメント： 
  * [Number Insight API](/number-insight/api-reference)
  * [Verify API](/verify/api-reference)

