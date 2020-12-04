---
title:  連結SMSを受信する

products: messaging/sms

description:  受信SMSが、単一のSMSで許可されている最大長を超えた場合、受信SMSは分割されます。これらの分割されたSMSを再構成して完全なメッセージにするのは、自力で行わなければなりません。このチュートリアルでは、その方法を説明します。

languages:
  - Node
*** ** * ** ***
連結SMSを受信する
==========
[特定の長さを超える](/messaging/sms/guides/concatenation-and-encoding)SMSメッセージは、2つ以上のより短いメッセージに分割され、複数のSMSとして送信されます。
SMS APIを使用して、単一SMSで許可されているバイト長よりも長い[着信SMS](/messaging/sms/guides/inbound-sms)を受信する場合、[Webhook](/concepts/guides/webhooks)に送信されたメッセージが単一のものか、複数に分割されたSMSの一部なのかをチェックする必要があります。メッセージに複数の部分がある場合は、再構成して完全なメッセージテキストを表示する必要があります。
このチュートリアルでは、その方法を説明します。
このチュートリアルの内容
------------
このチュートリアルでは、着信SMSをWebhook経由で受信するExpressフレームワークを使用した単純なNode.jsアプリケーションを作成して、メッセージが単体なのか複数のSMSに分かれているのかを判別します。
着信SMSが複数の部分に分かれている場合、アプリケーションはすべてのメッセージを受信するまで待機してから、正しい順序でこれらを結合してユーザーに表示します。
これを実現するには、次の手順を実行します。
1. [プロジェクトを作成する](#create-the-project) - Node.js/Expressアプリケーションを作成します
2. [アプリケーションをインターネットに公開する](#expose-your-application-to-the-internet) - `ngrok`を使用して、VonageがWebhook経由でアプリケーションにアクセスできるようにします
3. [基本的なアプリケーションを作成する](#create-the-basic-application) - 着信SMSを受信するWebhookを使用してアプリケーションを構築します
4. [Vonageを使用してWebhookを登録する](#register-your-webhook-with-nexmo) - VonageのサーバーにWebhookについて指示します
5. [テストSMSを送信する](#send-a-test-sms) - Webhookが着信SMSを受信できることを確認します。
6. [複数に分割されているSMSを処理する](#handle-multi-part-sms) - 複数に分割されているSMSを単一のメッセージに再構成します
7. [連結SMSの受信をテストする](#test-receipt-of-a-concatenated-sms) - 実際に動かして確認します
準備
---
このチュートリアルを完了するには、次のものが必要です。
* [Vonageアカウント](https://dashboard.nexmo.com/sign-up) - APIキーおよびシークレット用
* [ngrok](https://ngrok.com/) -（オプション）開発用Webサーバーをインターネット経由でVonageのサーバーにアクセスできるようにする
プロジェクトを作成する
-----------
アプリケーション用のディレクトリを作成し、そのディレクトリに`cd`して、Node.jsパッケージマネージャー`npm`を使用して、アプリケーションの依存性用の`package.json`ファイルを作成します。
```sh
mkdir myapp
cd myapp
npm init
```
Enterキーを押して、`server.js`と入力する`entry point`以外の既定値を受け入れます。
次に、[Express](https://expressjs.com) Webアプリケーションフレームワークと[body-parser](https://www.npmjs.com/package/body-parser)パッケージをインストールします。
```sh
npm install express body-parser --save
```
アプリケーションをインターネットに公開する
---------------------
SMS APIは、いずれかの仮想番号宛てのSMSを受信すると、[Webhook](/concepts/guides/webhooks)経由でアプリケーションに警告します。Webhookは、Vonageのサーバーがお客様のサーバーと通信するためのメカニズムを提供します。
アプリケーションがVonageのサーバーにアクセスできるようにするには、アプリケーションがインターネットに公開されている必要があります。開発中およびテスト中にこれを簡単に実現するには、ngrokを使用します。[ngrok](https://ngrok.com)は、安全なトンネルを介してローカルサーバーをパブリックインターネットに公開するサービスです。詳細については、[こちらのブログ記事](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)をご覧ください。
[ngrok](https://ngrok.com)をダウンロードしてインストールし、次のコマンドで起動します。
```sh
ngrok http 5000
```
これにより、ローカルマシンのポート5000で実行されているWebサイトのパブリックURL（HTTPおよび HTTPS）が作成されます。
http://localhost:4040の`ngrok`Webインターフェースを使用して、`ngrok`が提供するURLをメモします。このチュートリアルを完了するには、URLが必要です。
基本的なアプリケーションを作成する
-----------------
アプリケーションディレクトリに、次のコードで`server.js`ファイルを作成します。このファイルが開始点になります。
```javascript
require('dotenv').config();
const app = require('express')();
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app
    .route('/webhooks/inbound-sms')
    .get(handleInboundSms)
    .post(handleInboundSms);
const handleInboundSms = (request, response) => {
    const params = Object.assign(request.query, request.body);
    // Send OK status
    response.status(204).send();
}
app.listen('5000');
```
このコードは次のようなことを行います。
* 依存関係を初期化します（[POST] リクエストを解析するための`express`フレームワークと`body-parser`）。
* [GET] と [POST] の両方の要求に応じるExpressで`/webhooks/inbound-sms`ルートを登録します。これは、当社の仮想番号の1つがSMSを受信したときに、VonageのAPIが当社のアプリケーションと通信するために使用するWebhookです。
* 着信SMSを受信したことを知らせるメッセージを表示し、VonageのAPIにHTTP`success`応答を返す、`handleInboundSms()`と呼ばれるルートのハンドラ関数を作成します。この最後のステップは重要です。これをしないと、VonageはタイムアウトになるまでSMSを配信し続けます。
* ポート5000でアプリケーションサーバーを実行します。
VonageにWebhookを登録する
-------------------
これでWebhookが作成できたので、Vonageにその場所を伝える必要があります。[Vonageアカウントのダッシュボード](https://dashboard.nexmo.com/)にログインし、[設定](https://dashboard.nexmo.com/settings)ページにアクセスします。
アプリケーションでは、Webhookは`/webhooks/inbound-sms`にあります。Ngrokを使用している場合、設定する必要のある完全なWebhookエンドポイントは、`https://demo.ngrok.io/webhooks/inbound-sms`に似ています。ここでの`demo`は、Ngrokが提供するサブドメインです（通常は`0547f2ad`のようになります）。
**着信メッセージのWebhook URL** というラベルの付いたフィールドに Webhookエンドポイントを入力し、[変更を保存] ボタンをクリックします。
```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/screenshots/smsInboundWebhook.png
```
これで、仮想電話番号のいずれかがSMSを受信すると、Vonageはメッセージの詳細を使用してそのWebhookエンドポイントを呼び出します。
テストSMSを送信する
-----------
1. 新しいターミナルウィンドウを開き、`server.js`ファイルを実行し、着信SMSをリッスンします。
   ```sh
   node server.js
   ```
2. モバイルデバイスからVonage番号に、「これは短いテキストメッセージです」などの短いテキストメッセージのテストSMSを送信します。
すべてが正しく設定されていれば、`server.js`を実行しているターミナルウィンドウに、`Inbound SMS received`メッセージが表示されるはずです。
では、受信したSMSを解析してメッセージに何が含まれているかを確認するコードを書いてみましょう。
1. [CTRL\+C] を押すと、実行中の`server.js`アプリケーションが終了します。
2. `server.js`に`displaySms()`という新しい関数を作成します。
   ```javascript
   const displaySms = (msisdn, text) => {
       console.log('FROM: ' + msisdn);
       console.log('MESSAGE: ' + text);
       console.log('---');
   }
   ```
3. また、`server.js`で、コードが`204`応答を送信する直前に、以下のパラメーターを使用して`displaySms()`の呼び出しを追加します。
   ```javascript
   displaySms(params.msisdn, params.text);
   ```
4. `server.js`を再起動し、モバイルデバイスから別のショートメッセージを送信します。今回、ターミナルウィンドウで`server.js`を実行すると、以下のように表示されるはずです。
   ```sh
   Inbound SMS received
   FROM: <YOUR_MOBILE_NUMBER>
   MESSAGE: This is a short text message.
   ```
5. `server.js`を実行したままにしておきますが、今回はモバイルデバイスを使用して、1回のSMSが許可するよりもかなり長いメッセージを送信します。たとえば、ディケンズの『二都物語』の冒頭の一文などです。
       It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
6. `server.js`を実行しているターミナルウィンドウの出力を確認します。次のようなものが表示されます。
       ---
       Inbound SMS received
       FROM: <YOUR_MOBILE_NUMBER>
       MESSAGE: It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epo
       ---
       Inbound SMS received
       FROM: <YOUR_MOBILE_NUMBER>
       MESSAGE: ch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything
       ---
       Inbound SMS received
       FROM: <YOUR_MOBILE_NUMBER>
       MESSAGE: e the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of compariso
       ---
       Inbound SMS received
       FROM: <YOUR_MOBILE_NUMBER>
       MESSAGE:  before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far lik
       ---
       Inbound SMS received
       FROM: <YOUR_MOBILE_NUMBER>
       MESSAGE: n only.
       ---
何が起きたかと言うと、メッセージが1回のSMSのバイト数制限を超えていたため、複数のSMSメッセージとして送信されました。
このようなメッセージを意図した形式でユーザーに表示するためには、受信メッセージがこのように分割されているかどうかを検出して、分割されたものを再構成する必要があります。

> 上記の出力では、分割されたSMSが正しい順序で到着しなかったことに注目してください。これはよくあるので、このような事態に対処するためにWebhookをコーディングする必要があります。
複数パーツのSMSを処理する
--------------
Vonage は、着信SMSが連結されるときに、4つの特別なパラメーターを Webhookに渡します（SMSが分割されていない場合、リクエストには表示されません）。それらを使用して、次のように個々のパーツをもとの1つのメッセージに組み立てることができます。
  - concat:true - メッセージが連結されるとき
  - concat-ref - 特定のメッセージパーツが属するSMSを特定できるようにする一意の参照
  - concat-total - SMS全体を構成するパーツの総数
  - concat-part - 正しい順序でパーツを再構成するための、メッセージ全体におけるパーツの位置
### メッセージが連結されているかどうかを検出する
まず、メッセージが連結されているかどうかを検出する必要があります。`handleInboundSms()`関数を修正して、単一パートのSMSを通常の方法でユーザーに表示しますが、後の手順で実装する複数パーツのSMSのための追加処理を実行します。
```javascript
const handleInboundSms = (request, response) => {
    const params = Object.assign(request.query, request.body);
    if (params['concat'] == 'true') {
        // Perform extra processing
    } else {
        // Not a concatenated message, so just display it
        displaySms(params.msisdn, params.text);
    }   
    
    // Send OK status
    response.status(204).send();
}
```
### 後で処理するために複数パーツのSMSを格納する
すべてのパーツが揃ってから処理するために、大きなメッセージの一部である着信SMSのパーツを保存する必要があります。
`concat_sms`と言う`handleInboundSms()`関数の外側の配列を宣言します。受信SMSが長いメッセージの一部である場合は、それを配列に格納します。
```javascript
let concat_sms = []; // Array of message objects
const handleInboundSms = (request, response) => {
    const params = Object.assign(request.query, request.body);
    if (params['concat'] == 'true') {
        /* This is a concatenated message. Add it to an array
           so that we can process it later. */
        concat_sms.push({
            ref: params['concat-ref'],
            part: params['concat-part'],
            from: params.msisdn,
            message: params.text
        });
    } else {
        // Not a concatenated message, so just display it
        displaySms(params.msisdn, params.text);
    }   
    
    // Send OK status
    response.status(204).send();
}
```
### すべてのメッセージパーツを集める
メッセージをそのパーツから再構築する前に、指定されたメッセージ参照のすべてのパーツが揃っていることを確認する必要があります。すべてのパーツが正しい順序で到着する保証はありません。そのため、`concart-part`が`concat-total`と等しいかどうかをチェックするだけではありません。
このためには、`concat_sms`配列をフィルタリングして、受信したばかりのSMSと同じ`concat-ref`を共有するSMSオブジェクトだけを含むようにします。フィルタリングされた配列の長さが`concat-total`と同じであれば、そのメッセージのすべてのパーツを取得したことになり、再構築できます。
```javascript
    if (params['concat'] == 'true') {
        /* This is a concatenated message. Add it to an array
           so that we can process it later. */
        concat_sms.push({
            ref: params['concat-ref'],
            part: params['concat-part'],
            from: params.msisdn,
            message: params.text
        });
        /* Do we have all the message parts yet? They might
           not arrive consecutively. */
        const parts_for_ref = concat_sms.filter(part => part.ref == params['concat-ref']);
        // Is this the last message part for this reference?
        if (parts_for_ref.length == params['concat-total']) {
            console.dir(parts_for_ref);
            processConcatSms(parts_for_ref);
        }
    } 
```
### メッセージパーツを再構築する
これですべてのメッセージパーツが揃いましたが、必ずしも正しい順番ではありません。`Array.sort()`関数を使用して、これらを`concat-part`の順番で再構築できます。そのための`processConcatSms()`関数を作成します。
```javascript
const processConcatSms = (all_parts) => {
    // Sort the message parts
    all_parts.sort((a, b) => a.part - b.part);
    // Reassemble the message from the parts
    let concat_message = '';
    for (i = 0; i < all_parts.length; i++) {
        concat_message += all_parts[i].message;
    }
    displaySms(all_parts[0].from, concat_message);
}
```
連結SMSの受信をテストする
--------------
`server.js`を実行し、モバイルデバイスを使用して、上記の[テストSMSを送信する](#send-a-test-sms)セクションのステップ5で送信した、長いテキストメッセージを再送信します。
すべてを正しくコーディングしていれば、`server.js`ウィンドウに、個々のメッセージパーツが送信されるはずです。すべてのパーツを受信すると、完全なメッセージが表示されます。
    [ { ref: '08B5',
        part: '3',
        from: '<YOUR_MOBILE_NUMBER>',
        message: ' before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far lik' },
      { ref: '08B5',
        part: '1',
        from: '<YOUR_MOBILE_NUMBER>',
        message: 'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epo' },
      { ref: '08B5', part: '5', from: 'TEST-NEXMO', message: 'n only.' },
      { ref: '08B5',
        part: '2',
        from: '<YOUR_MOBILE_NUMBER>',
        message: 'ch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything' },
      { ref: '08B5',
        part: '4',
        from: '<YOUR_MOBILE_NUMBER>',
        message: 'e the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of compariso' } ]
    FROM: <YOUR_MOBILE_NUMBER>
    MESSAGE: It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.
    ---
まとめ
---
このチュートリアルでは、分割されたメッセージパートを連結SMSに再構築する方法を示す簡単なアプリケーションを作成しました。着信SMS Webhookへの、`concat`、`concat-ref`、`concat-total`、および`concat-part`リクエストパラメーターと、それらを使用して次の判断を行う方法について学習しました。
* 着信SMSが連結されているかどうか
* 特定のメッセージパーツがどのメッセージに属するか
* メッセージ全体を構成するメッセージパーツの数
* メッセージ全体の中での特定のメッセージパーツの順序
次の作業

---

以下のリソースは、アプリケーションでNumber Insightを使用する際の参考になります。

* GitHubにあるこのチュートリアルの[ソースコード](https://github.com/Nexmo/sms-node-concat-tutorial)
* [SMS API製品ページ](https://www.nexmo.com/products/sms)
* [着信SMSの考え方](/messaging/sms/guides/inbound-sms)
* [Webhookガイド](/concepts/guides/webhooks)
* [SMS用APIの関連情報](/api/sms)
* [ngrokトンネルを使用してローカル開発サーバーをVonage APIに接続する](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)
* [その他のSMS APIチュートリアル](/messaging/sms/tutorials)

