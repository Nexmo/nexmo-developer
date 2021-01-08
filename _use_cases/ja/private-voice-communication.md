---
title: プライベート音声通信
products: voice/voice-api
description: ユーザーが実際の番号を非公開にしたまま、お互いに電話をかけられるようにします。
languages:
    - Node
navigation_weight: 2

---

プライベート音声通信
==========

このユースケースでは、[プライベート音声通話ユースケース](https://www.nexmo.com/use-cases/private-voice-communication/)に記載されているアイデアを実装する方法を示します。Vonageの[Node Server SDK](https://github.com/Nexmo/nexmo-node)を使用して音声プロキシを構築し、仮想番号を使用して参加者の実際の電話番号を隠す方法について説明します。完全なソースコードは[GitHubリポジトリ](https://github.com/Nexmo/node-voice-proxy)でも入手可能です。

概要
---

2人のユーザーが自分のプライベートな電話番号を明かさずに、お互いに電話をかけられるようにしたい場合があります。

たとえば、ライドシェアリングサービスを運営している場合は、ユーザー同士が話し合って乗車時間や場所を調整できるようにする必要があります。しかし、プライバシーを保護する義務があるため、ユーザーの電話番号を伏せておく必要があります。また、ユーザーがサービスを使用せずにライドシェアを直接手配することは、ビジネス収益の損失という観点から、望ましくありません。

VonageのAPIを使用すると、その通話の参加者に対して、実際の番号を知られないようにするための一時的な番号を提供できます。発信者には、その通話中に使用する一時的な番号だけが表示されます。やり取りの必要がなくなったら、一時的な番号は無効になります。

[GitHubリポジトリ](https://github.com/Nexmo/node-voice-proxy)からソースコードをダウンロードできます。

準備
---

このユースケースを進めるためには、以下のものが必要になります。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli)がインストールされ、設定されている

コードリポジトリ
--------

[GitHubリポジトリを含むコード](https://github.com/Nexmo/node-voice-proxy)がある。

手順
---

アプリケーションを構築するには、次の手順を実行します。

* [概要](#overview)
* [準備](#prerequisites)
* [コードリポジトリ](#code-repository)
* [手順](#steps)
* [構成](#configuration)
* [音声用APIアプリケーションを作成する](#create-a-voice-api-application)
* [Webアプリケーションを作成する](#create-the-web-application)
* [仮想番号をプロビジョニングする](#provision-virtual-numbers)
* [コールを作成する](#create-a-call) 
  * [電話番号を検証する](#validate-the-phone-numbers)
  * [電話番号を実際の番号にマッピングする](#map-phone-numbers-to-real-numbers)
  * [確認のSMSを送信する](#send-a-confirmation-sms)

* [着信コールを処理する](#handle-inbound-calls)
* [実際の電話番号を仮想番号に逆マッピングする](#reverse-map-real-phone-numbers-to-virtual-numbers)
* [コールをプロキシする](#proxy-the-call)
* [まとめ](#conclusion)
* [詳細情報](#further-information)

構成
---

設定を含む`.env`ファイルを作成する必要があります。作成方法については、[GitHub Readme](https://github.com/Nexmo/node-voice-proxy#configuration)をご覧ください。このユースケースを実行すると、APIキー、APIシークレット、アプリケーションID、デバッグモード、プロビジョニングされた番号などの変数に必要な値を構成ファイルに入力できます。

音声用APIアプリケーションを作成する
-------------------

音声用APIアプリケーションはVonage構造です。記述しようとしているアプリケーションと混同しないようにしてください。代わりに、これはAPIを操作するために必要な認証および構成設定のための「コンテナ」となります。

Nexmo CLIを使用して音声用APIアプリケーションを作成できます。アプリケーションの名前と2つのWebhookエンドポイントのURLを指定する必要があります。1つ目は、仮想番号で着信コールを受信したときにVonageのAPIがリクエストを行うエンドポイントで、もう1つはAPIがイベントデータを投稿できるエンドポイントです。

次のNexmo CLIコマンドのドメイン名をngrokドメイン名（[ngrokの実行方法](https://developer.nexmo.com/tools/ngrok/)）に置き換え、プロジェクトのルートディレクトリで実行します。

```shell
nexmo app:create "voice-proxy" --capabilities=voice --voice-answer-url=https://example.com/proxy-call--voice-event-url=https://example.com/event--keyfile=private.key
```

このコマンドは、認証情報を含む`private.key`というファイルをダウンロードし、一意のアプリケーションIDを返します。このIDは、以降の手順で必要になるので、メモしておきます。

Webアプリケーションを作成する
----------------

このアプリケーションは、ルーティングに[Express](https://expressjs.com/)のフレームワークを使用し、音声用APIの操作に[Vonage Node Server SDK](https://github.com/Nexmo/nexmo-node)を使用します。`dotenv`は、`.env`テキストファイルを使用してアプリケーションを設定できるようにするために使用されます。

`server.js`では、コードがアプリケーションの依存性を初期化し、Webサーバーを起動します。ルートハンドラはアプリケーションのホームページ（`/`）に実装されており、`node server.js`を実行し、ブラウザで`http://localhost:3000`にアクセスすることで、サーバーが実行されているかどうかをテストできます。

```javascript
"use strict";

const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.set('port', (process.env.PORT || 3000));
app.use(bodyParser.urlencoded({extended: false }));

const config = require(__dirname + '/../config');

const VoiceProxy = require('./VoiceProxy');
const voiceProxy = new VoiceProxy(config);

app.listen(app.get('port'),function() {
  console.log('VoiceProxy App listening on port', app.get('port'));
});
```

コードは、`VoiceProxy`クラスのオブジェクトをインスタンス化して、仮想番号に送信されたメッセージを目的の受信者の実際の番号にルーティングします。プロセスのプロキシ処理については、[コールをプロキシする](#proxy-the-call)で説明していますが、現時点では、このクラスは次のステップで設定するAPIキーとシークレットを使用してVonage Server SDKを初期化することに注意してください。これにより、アプリケーションで音声通話を発信および着信できるようになります。

```javascript
const VoiceProxy = function(config) {
  this.config = config;
  
  this.nexmo = new Nexmo({
      apiKey: this.config.VONAGE_API_KEY,
      apiSecret: this.config.VONAGE_API_SECRET
    },{
      debug: this.config.VONAGE_DEBUG
    });
  
  // Virtual Numbers to be assigned to UserA and UserB
  this.provisionedNumbers = [].concat(this.config.PROVISIONED_NUMBERS);
  
  // In progress conversations
  this.conversations = [];
};
```

仮想番号をプロビジョニングする
---------------

仮想番号は、アプリケーションユーザーから実際の電話番号を隠すために使用されます。

次のワークフロー図は、仮想番号のプロビジョニングおよび設定のプロセスを示しています。

```sequence_diagram
参加者アプリ
参加者Vonage
参加者ユーザーA
参加者ユーザーB
アプリの注、Vonage：初期化
アプリ->>Vonage：番号を検索
Vonage->>アプリ：見つかった番号 
アプリ->> Vonage：番号のプロビジョニング
Vonage->>アプリ：プロビジョニングされた番号
アプリ->> Vonage：番号の設定
Vonage->>アプリ：設定された番号
```

仮想番号をプロビジョニングするには、条件を満たす使用可能な番号を検索します。たとえば、音声機能を持つ特定の国の電話番号は次のとおりです。

```code
source: '_code/voice_proxy.js'
from_line: 2
to_line: 47
```

次に、必要な番号をレンタルして、アプリケーションに関連付けます。

> **注：** 一部のタイプの番号では、レンタルするために住所が必要です。プログラムで番号を取得できない場合は、[Dashboard](https://dashboard.nexmo.com/buy-numbers)にアクセスし、必要に応じて番号をレンタルすることができます。

アプリケーションに関連付けられた番号に関連するイベントが発生すると、Vonageはイベントに関する情報とともに、リクエストをWebhookエンドポイントに送信します。設定後、後で使用するために電話番号を保存します。

```code
source: '_code/voice_proxy.js'
from_line: 48
to_line: 79
```

仮想番号をプロビジョニングするには、ブラウザで`http://localhost:3000/numbers/provision`にアクセスしてください。

これで、ユーザー間の通信を隠すのに必要な仮想番号が設定されました。

> **注：** 本番アプリケーションでは、仮想番号のプールから選択します。ただし、この機能をそのまま使用して、追加の番号をレンタルする必要があります。

コールを作成する
--------

コールを作成するワークフローは次のとおりです。

```sequence_diagram
参加者アプリ
参加者Vonage
参加者ユーザーA
参加者ユーザーB
アプリの注、Vonage：会話の開始
アプリ->> Vonage：基本的なNumber Insight
Vonage-->>アプリ：Number Insightの応答
アプリ->>アプリ：各参加者の実際の番号/仮想番号のマッピング
アプリ->> Vonage：SMSからユーザーA
Vonage->> ユーザーA：SMS
アプリ->>Vonage：SMSからユーザーB
Vonage->> ユーザーB：SMS
```

次のコールは以下を行います。

* [電話番号を検証する](#validate-phone-numbers)
* [電話番号を実際の番号にマッピングする](#map-phone-numbers)
* [確認のSMSを送信する](#send-confirmation-sms)

```code
source: '_code/voice_proxy.js'
from_line: 89
to_line: 103
```

### 電話番号を検証する

アプリケーションユーザーが電話番号を入力したら、Number Insightを使用して有効であることを確認します。電話番号が登録されている国も確認できます。

```code
source: '_code/voice_proxy.js'
from_line: 104
to_line: 124
```

### 電話番号を実際の番号にマッピングする

電話番号が有効であることが確認できたら、実際の番号を[仮想番号にマッピングし](#provision-virtual-voice-numbers)、コールを保存します。

```code
source: '_code/voice_proxy.js'
from_line: 125
to_line: 159
```

### 確認のSMSを送信する

プライベート通信システムでは、あるユーザーが別のユーザーに連絡すると、発信者は自分の電話から仮想番号を呼び出します。

SMSを送信し、呼び出す必要がある仮想番号を、会話の参加者に通知します。

```code
source: '_code/voice_proxy.js'
from_line: 160
to_line: 181
```

ユーザーはお互いにSMSをすることはできません。この機能を有効にするには、[プライベートSMS通信](/use-cases/private-sms-communication)を設定する必要があります。

**注** ：このユースケースでは、各ユーザーはSMS経由で仮想番号を受け取っています。他のシステムでは、メール、アプリ内通知、または事前定義された番号を使用して通知できます。

着信コールを処理する
----------

Vonageは、仮想番号への着信コールを受信すると、[音声アプリケーションの作成](#create-a-voice-application)時に設定したWebhookエンドポイントにリクエストを送信します。

```sequence_diagram
参加者アプリ
参加者Vonage
参加者ユーザーA
参加者ユーザーB
ユーザーAの注、Vonage：ユーザーAはユーザーBの\nVonage番号を呼び出します
ユーザーA->> Vonage：仮想番号を呼び出します
Vonage-> > アプリ：着信コール（発信者、宛先）
```

着信Webhookから`to`と`from`を抽出し、音声プロキシビジネスロジックに渡します。

```javascript
app.get('/proxy-call', function(req, res) {
  const from = req.query.from;
const to = req.query.to;

const ncco = voiceProxy.getProxyNCCO(from,to);
  res.json(ncco);
});
```

実際の電話番号を仮想番号に逆マッピングする
---------------------

これで、コールを発信する電話番号と受信者の仮想番号が分かったので、着信仮想番号を、発信する実際の電話番号に逆マッピングします。

```sequence_diagram
参加者アプリ
参加者Vonage
参加者ユーザーA
参加者ユーザーB
ユーザーA->> Vonage：
Vonage->>アプリ：
アプリの右側の注：ユーザーBの実際の番号を\n検索
アプリ->> アプリ：番号マッピングルックアップ
```

コールの方向は次のように識別できます。

* `from`番号はユーザーAの実際の番号で、`to`番号はユーザーBのVonage番号です。
* `from`番号はユーザーBの実際の番号で、`to`番号はユーザーAのVonage番号です。

```code
source: '_code/voice_proxy.js'
from_line: 182
to_line: 216
```

番号検索を実行したら、あとはコールをプロキシするだけです。

コールをプロキシする
----------

仮想番号が関連付けられている電話番号にコールをプロキシします。`from`番号は常に仮想番号で、`to`は実際の電話番号です。

```sequence_diagram
参加者アプリ
参加者Vonage⏎参加者ユーザーA
参加者ユーザーB
ユーザーA->> Vonage：
Vonage->> アプリ：
アプリ->> Vonage：接続（プロキシ）
アプリの右側の注：ユーザーの\n実際の番号への\nプロキシ着信コール
Vonage->> ユーザーB：コール
ユーザーAの注、ユーザーB：ユーザーAが\nユーザーBに電話をかけた。ただしユーザーA\nとユーザーBは\n互いに\n実際の番号を\n知らない。
```

これを行うには、[NCCO（Nexmo Call Control Object）](/voice/voice-api/ncco-reference)を作成します。このNCCOでは、`talk`アクションを使用してテキストを読み上げます。`talk`が完了すると、`connect`アクションはコールを実際の番号に転送します。

```code
source: '_code/voice_proxy.js'
from_line: 217
to_line: 252
```

NCCOは、WebサーバーによってVonageに返されます。

```javascript
app.get('/proxy-call', function(req, res) {
  const from = req.query.from;
const to = req.query.to;

const ncco = voiceProxy.getProxyNCCO(from,to);
  res.json(ncco);
});
```

まとめ
---

プライベート通信用の音声プロキシを構築する方法を学びました。電話番号のプロビジョニングと設定、Number Insightの実行、匿名性を確保するための実際の番号の仮想番号へのマッピング、着信コールの処理および別のユーザーへのコールのプロキシを行いました。

詳細情報
----

* [音声用 API](/voice/voice-api/overview)
* [NCCO の関連情報](/voice/voice-api/ncco-reference)
* [GitHubリポジトリ](https://github.com/Nexmo/node-voice-proxy)

