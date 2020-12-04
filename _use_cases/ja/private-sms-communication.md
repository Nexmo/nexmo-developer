---
title:  プライベートSMS通信

products: messaging/sms

description:  このチュートリアルでは、実際の電話番号を相手に明かさずに、2者間のSMS通信を機能させる方法を示します。

languages:
  - Node
*** ** * ** ***
プライベートSMS通信
===========
実際の電話番号を明かさずに、2者がSMSを交換したい場合があります。
たとえば、タクシー予約サービスを運営している場合は、顧客と運転手が連絡をとり、乗車時間や場所などを調整できるようにする必要があります。しかし、プライバシー保護のため、顧客の電話番号が運転手に知られないようにする必要があります。また逆に、顧客が運転手の番号を知り、アプリケーションを介さずにタクシーサービスを直接予約できるようにもしたくありません。
このチュートリアルの内容
------------
このチュートリアルは、[プライベートSMSのユースケース](https://www.nexmo.com/use-cases/private-sms-communication)に基づきます。仮想電話番号を使用して、Node.jsとNode Server SDKでSMSプロキシシステムを構築し、参加者の実際の番号を隠す方法について説明します。
アプリケーションを構築するには、次の手順を実行します。
* [基本的なWebアプリケーションを作成する](#create-the-basic-web-application) - 基本的なアプリケーションフレームワークを構築します
* [アプリケーションを構成する](#configure-the-application) - APIキーとシークレット、およびプロビジョニングした仮想番号を使用します
* [チャットを作成する](#create-a-chat) - ユーザーの実際の番号と仮想番号のマッピングを作成します
* [着信SMSを受信する](#receive-inbound-sms) - 仮想番号で着信SMSをキャプチャし、ターゲットユーザーの実際の番号に転送します
準備
---
このチュートリアルを完了するには、以下のものが必要です。
* [Vonageアカウント](https://dashboard.nexmo.com/sign-up) - APIキーおよびシークレット用、仮想番号のレンタル用。
* [Vonage番号](https://developer.nexmo.com/concepts/guides/glossary#virtual-number) - 各ユーザーの実際の番号を非表示にします。番号は、[Developer Dashboard](https://dashboard.nexmo.com/buy-numbers)でレンタルできます。
* GitHubの[ソースコード](https://github.com/Nexmo/node-sms-proxy) - インストール手順は、[README](https://github.com/Nexmo/node-sms-proxy/blob/master/README.md)をご確認ください。
* [Node.js](https://nodejs.org/en/download/)がインストールされ、構成されていること。
* [ngrok](https://ngrok.com/) -（オプション）開発用Webサーバーをインターネット経由でVonageのサーバーにアクセスできるようにする。
基本的なWebアプリケーションを作成する
--------------------
このアプリケーションは、ルーティングに[Express](https://expressjs.com/)のフレームワークを使用し、SMSの送受信に[Node Server SDK](https://github.com/Nexmo/nexmo-node)をします。`.env`テキストファイルにアプリケーションを構成できるように、`dotenv`を使用します。
`server.js`でアプリケーションの依存性を初期化し、Webサーバーを起動します。アプリケーションのホームページ（`/`）のルートハンドラを提供します。これにより、`http://localhost:3000`にアクセスして、サーバーが実行されているかどうかをテストできます。
```javascript
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const SmsProxy = require('./SmsProxy');
const app = express();
app.set('port', (process.env.PORT || 3000));
app.use(bodyParser.urlencoded({ extended: false }));
app.listen(app.get('port'), function () {
    console.log('SMS Proxy App listening on port', app.get('port'));
});
const smsProxy = new SmsProxy();
app.get('/', (req, res) => {
    res.send('Hello world');
})
```
ここでは、`SmsProxy`クラスのオブジェクトをインスタンス化して、仮想番号に送信されたメッセージを目的の受信者の実際の番号にルーティングします。[SMSのプロキシ](#proxy-the-sms)で実際のプロキシプロセスを説明しますが、現時点では、このクラスは次のステップで設定するAPIキーとシークレットを使用して`nexmo`を初期化することに注意してください。これにより、アプリケーションでSMSを送受信できるようになります。
```javascript
const Nexmo = require('nexmo');
class SmsProxy {
    constructor() {
        this.nexmo = new Nexmo({
            apiKey: process.env.VONAGE_API_KEY,
            apiSecret: process.env.VONAGE_API_SECRET
        }, {
                debug: true
            });
    }
    ...
```
アプリケーションを構成する
-------------
`.env`に提供された`example.env`ファイルをコピーし、Vonage APIキー、シークレット、Vonage番号を含むように変更します。この情報は、[Developer Dashboard](https://dashboard.nexmo.com)で確認できます。
    VONAGE_API_KEY=YOUR_VONAGE_API_KEY
    VONAGE_API_SECRET=YOUR_VONAGE_API_SECRET
    VONAGE_NUMBER=YOUR_VONAGE_NUMBER
チャットを作成する
---------
アプリケーションを使用するには、`/chat`ルートに`POST`リクエストを行い、2人のユーザーの実際の電話番号を渡します。（[チャットの開始](#start-the-chat)にサンプルリクエストが表示されます）
`/chat`のルートハンドラを以下に示します。
```javascript
app.post('/chat', (req, res) => {
    const userANumber = req.body.userANumber;
    const userBNumber = req.body.userBNumber;
    smsProxy.createChat(userANumber, userBNumber, (err, result) => {
        if (err) {
            res.status(500).json(err);
        }
        else {
            res.json(result);
        }
    });
    res.send('OK');
});
```
チャットオブジェクトは、`smsProxy`クラスの`createChat()`メソッドで作成されます。各ユーザーの実際の番号が格納されます。
```javascript
createChat(userANumber, userBNumber) {
    this.chat = {
        userA: userANumber,
        userB: userBNumber
    };
    this.sendSMS();
}
```
チャットが作成されました。次に、各ユーザーに他のユーザーとの連絡方法を知らせる必要があります。
### ユーザーを紹介する

> **注** ：このチュートリアルでは、各ユーザーはSMS経由で仮想番号を受け取ります。実稼働システムでは、これはメールやアプリ内通知を使用して、または事前定義された番号として通知できます。
`smsProxy`クラスの`sendSMS()`メソッドでは、`sendSms()`メソッドを使用して、各ユーザーの実際の番号から仮想番号に2つのメッセージを送信します。
```javascript
sendSMS() {
    /*  
        Send a message from userA to the virtual number
    */
    this.nexmo.message.sendSms(this.chat.userA,
                                process.env.VIRTUAL_NUMBER,
                                'Reply to this SMS to talk to UserA');
    /*  
        Send a message from userB to the virtual number
    */
    this.nexmo.message.sendSms(this.chat.userB,
                                process.env.VIRTUAL_NUMBER,
                                'Reply to this SMS to talk to UserB');
}
```
次に、これらの着信メッセージを仮想番号でインターセプトし、目的の受信者の実際の番号にプロキシする必要があります。
着信SMSを受信する
----------
あるユーザーが他のユーザーにメッセージを送信すると、ターゲットユーザーの実際の番号ではなく、アプリケーションの仮想番号に送信されます。Vonageが仮想番号で着信SMSを受信すると、その番号に関連付けられたWebhookエンドポイントにHTTPリクエストを行います。
`server.js`では、仮想番号がSMSを受信したときに、Vonageのサーバーがアプリケーションに対して行う`/webhooks/inbound-sms`リクエストのルートハンドラを提供します。ここでは`POST`リクエストを使用しますが、`GET`または`POST-JSON`を使用することもできます。これは、[アプリケーションをインターネットに公開する](#expose-your-application-to-the-internet)で説明したように、ダッシュボードで設定できます。
着信リクエストから`from`および`text`パラメーターを取得し、それらを`SmsProxy`クラスに渡して、送信先の実際の番号を決定します。
```javascript
app.get('/webhooks/inbound-sms', (req, res) => {
    const from = req.query.msisdn;
    const to = req.query.to;
    const text = req.query.text;
    // Route virtual number to real number
    smsProxy.proxySms(from, text);
    res.sendStatus(204);
});
```
メッセージの受信に成功したことを示す`204`ステータス（`No content`）を返します。受信を確認しないと、Vonageのサーバーは繰り返し配信を試みるため、このステップは重要です。
### SMSのルーティング方法を決定する
SMSを送信するユーザーの実際の番号がわかっているので、メッセージを他のユーザーの実際の番号に転送できます。このロジックは、`SmsProxy`クラスの`getDestinationRealNumber()`メソッドで実装されます。
```javascript
getDestinationRealNumber(from) {
    let destinationRealNumber = null;
    // Use `from` numbers to work out who is sending to whom
    const fromUserA = (from === this.chat.userA);
    const fromUserB = (from === this.chat.userB);
    if (fromUserA || fromUserB) {
        destinationRealNumber = fromUserA ? this.chat.userB : this.chat.userA;
    }
    return destinationRealNumber;
}
```
これで、メッセージの送信先となるユーザーを決定できるようになったので、あとは送信するだけです。
### SMSをプロキシする
目的の受信者の実際の電話番号にSMSをプロキシします。`from`番号は、常に仮想番号（ユーザーの匿名性を維持するため）で、`to`はユーザーの実際の電話番号です。
```javascript
proxySms(from, text) {
    // Determine which real number to send the SMS to
    const destinationRealNumber = this.getDestinationRealNumber(from);
    if (destinationRealNumber  === null) {
        console.log(`No chat found for this number);
        return;
    }
    // Send the SMS from the virtual number to the real number
    this.nexmo.message.sendSms(process.env.VIRTUAL_NUMBER,
                                destinationRealNumber,
                                text);
}
```
試行手順
----
### アプリケーションをインターネットに公開する
SMS APIは、仮想番号宛てのSMSを受信すると、[Webhook](/concepts/guides/webhooks)経由でアプリケーションに警告します。Webhookは、Vonageのサーバーがお客様のサーバーと通信するためのメカニズムを提供します。
アプリケーションがVonageのサーバーにアクセスできるようにするには、アプリケーションがインターネットに公開されている必要があります。開発中およびテスト中にこれを簡単に実現するには、ngrokを使用します。[ngrok](https://ngrok.com)は、安全なトンネルを介してローカルサーバーをパブリックインターネットに公開するサービスです。詳細については、[こちらのブログ記事](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)をご覧ください。
[ngrok](https://ngrok.com)をダウンロードしてインストールし、次のコマンドで起動します。
```sh
ngrok http 3000
```
これにより、ローカルマシンのポート3000で実行されているWebサイトのパブリックURL（HTTP および HTTPS）が作成されます。
http://localhost:4040の`ngrok`Webインターフェイスを使用して、`ngrok`が提供するURLをメモします。
[アカウント設定](https://dashboard.nexmo.com/settings)ページに移動し、[Inbound Messages (受信メッセージ)]テキストボックスにWebhookエンドポイントへの完全なURLを入力します。たとえば、`ngrok`を使用している場合、URLは次のようになります。
    https://33ab96a2.ngrok.io/webhooks/inbound-sms
[HTTP Method (HTTPメソッド)]ドロップダウンリストから`POST`を選択してください。これにより、Vonageは、アプリケーションが`POST`リクエストを介してメッセージ詳細が配信されることを期待しているのを認識します。
### チャットを開始する
アプリケーションの`/chat`エンドポイントに`POST`リクエストを行い、ユーザーの実際の番号をリクエストパラメーターとして渡します。
これには、[Postman](https://www.getpostman.com)を使用するか、次のような`curl`コマンドを使用して、`USERA_REAL_NUMBER`と`USERB_REAL_NUMBER`をユーザーのアカウント番号に置き換えることができます。
```sh
curl -X POST \
  'http://localhost:3000/chat?userANumber=USERA_REAL_NUMBER&userBNumber=USERB_REAL_NUMBER' 
```
### チャットを続ける
各ユーザーは、アプリケーションの仮想番号からテキストを受信する必要があります。ユーザーがその番号に返信すると、他のユーザーの実際の番号に配信されますが、仮想番号から送信されたように見えます。
まとめ
---
このチュートリアルでは、2人のユーザーが相手の実際の番号を見ることなくSMSを交換できるように、SMSプロキシを構築する方法を学びました。
次の作業

---

このサンプルアプリケーションを拡張し、同じ仮想番号を使用して複数のチャットをホストするには、`SmsProxy.createChat()`を使用してインスタンス化し、異なるユーザーのペアに対して個別の`chat`オブジェクトを永続化することができます。したがって、たとえば`chat`オブジェクトは、`userA`と`userB`の会話のために1つ、そして`userC`と`userD`の会話のために1つ持つことができます。

現在のチャットをすべて表示し、チャットが終わったら終了できるルートを作成できます。

このチュートリアルで学習した内容について詳しくは、次のリソースを参照してください。

* [GitHubのチュートリアルコード](https://github.com/Nexmo/node-sms-proxy)
* [プライベートSMSのユースケース](https://www.nexmo.com/use-cases/private-sms-communication)
* [SMS APIリファレンスガイド](/api/sms)
* [その他のSMS APIチュートリアル](/messaging/sms/tutorials)
* [Ngrokの設定と使用](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)

