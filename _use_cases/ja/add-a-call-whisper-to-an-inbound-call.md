---
title:  着信コールにCall Whisperを追加する

products: voice/voice-api

description:  「電話番号は、看板、テレビ広告、Webサイト、新聞など、広告のいたるところに掲載されています。多くの場合、これらの番号はすべて同じコールセンターにリダイレクトされます。コールセンターのエージェントは、その人が電話をかけている理由と、広告を見た場所を尋ねる必要があります。Call Whisperを使用すると、これがとても簡単になります。」

languages:
  - Node
*** ** * ** ***
音声 - 着信コールにCall Whisperを追加する
==============================
電話番号は、看板、テレビ広告、Webサイト、新聞など、広告のいたるところに掲載されています。多くの場合、これらの番号はすべて同じコールセンターにリダイレクトされます。コールセンターのエージェントは、その人が電話をかけている理由と、広告を見た場所を尋ねる必要があります。
Call Whisperを使用すると、着信コールのコンテキストをコールセンターのオペレーターにアナウンスしてから発信者に接続します。このチュートリアルでは、このアプローチを実装するアプリケーションについて説明します。ユーザーは2つの番号のいずれかに電話をかけます。アプリケーションがコールに応答し、発信者に保留メッセージが流れます。その間、アプリケーションはコールセンターのオペレーターに電話をかけ、ダイヤルされた番号に応じて異なるCall Whisperを再生し、発信者との会話にオペレーターを接続します。
例はExpressを使用してnode.jsで記述されており、コードは[GitHub](https://github.com/Nexmo/node-call-whisper)にあります。
このチュートリアルの内容
------------
着信コールにCall Whisperを追加するビルド方法を説明します。
* [仕組み](#how-it-works) - 誰が誰に電話をかけているのか、サンプルアプリケーション全体でプロセスがどのように流れているのかの概要を説明します。
* [始める前に](#before-you-begin) - このチュートリアルに必要なアプリケーションと番号を設定してください。
* [コードの使用を開始する](#getting-started-with-code) - リポジトリのクローンを作成し、アプリケーションを実行します。
* [コードを試行する](#code-walkthrough) - アプリケーションがどのように機能するかについてのより細かい点を確認します。
* [その他の資料](#further-reading) - 役に立つと思われる他の資料をチェックしてください。
仕組み
---
```sequence_diagram
User->>Vonage number: User calls either of\nthe numbers linked\n to this Application
Vonage number-->>Application: /answer
Application->>Operative: Connects to operative's number
Note left of Operative: When operative\nanswers
Operative-->>Application: /answer_outbound
Application->>Operative: Announces key information\nabout original caller
Note left of Operative: Callers are connected
```
始める前に
-----
コードを取得して実行する前に、最初にやるべきことがいくつかあります。
### Vonageにサインアップする
まだお持ちでない場合は、[Vonage APIアカウントにサインアップしてください](https://dashboard.nexmo.com/sign-up)。
### CLIをセットアップする
このチュートリアルでは [Nexmoコマンドラインツール](https://github.com/Nexmo/nexmo-cli)を使用しますので、先に進む前にインストールされていることを確認してください。
### 電話番号を2つ購入する
異なる番号に電話をかけるとWhispersが異なることを確認するために、2つの電話番号が必要になります。このコマンドを2回実行し、購入した番号をメモしておきます。
```bash
$ nexmo number:buy --country_code US --confirm
```
### アプリケーションを作成する
新しいVonageアプリケーションを作成し、秘密鍵を保存します。これは後で必要になります。このコマンドの「answer」引数と「event」引数の両方について、`https://example.com`をご自分のアプリケーションのURLに置き換えます。
```bash
nexmo app:create "Call Whisper" https://example.com/answer https://example.com/event --keyfile app.key
```
このコマンドは秘密鍵を取得し、`app.key`に安全に配置します。次のコマンドで使用するアプリケーションIDをメモしておいてください。
### アプリケーションに番号をリンクする
各番号に対して以下のコマンドを1回実行して、アプリケーションを両方の番号にリンクします。
```bash
nexmo link:app [NEXMO_NUMBER] [APP_ID]
```

> `nexmo app:list`コマンドと`nexmo number:list`コマンドを使用して、いつでもアプリまたは番号のリストを取得できます。
コードの使用を開始する
-----------
このプロジェクトのコードはGitHubの[https://github.com/Nexmo/node-call-whisper](https://github.com/Nexmo/node-call-whisper)にあります。これはExpressを使用するnode.jsプロジェクトで構成されており、皆さんのニーズに適応できる実例を提供することを目的としています。
### リポジトリのクローンを作成する
リポジトリのクローンを作成するか、リポジトリをローカルマシンの新しいディレクトリにダウンロードします。
### 設定を構成する
アプリケーションは、実行する前に、あなたとあなたのアプリケーションについて詳しく知る必要があります。`.env-example`ファイルを`.env`にコピーし、この新しいファイルを編集して、使用する設定を反映します。
  - CALL_CENTER_NUMBER：携帯電話番号など、コールセンターに連絡するための電話番号
  - INBOUND_NUMBER_1：購入した番号の1つ
  - INBOUND_NUMBER_2：購入した別の番号
  - DOMAIN`：アプリが実行される場所のドメイン名。たとえば、私のものは次のとおりです。 `ff7b398a.ngrok.io
### 依存関係をインストールする
コードをダウンロードしたディレクトリで、`npm install`を実行します。これにより、このプロジェクトに必要なExpressとその他の依存関係が導入されます。
### サーバーを起動する
設定が完了し、依存関係が整ったら、アプリケーションの準備は完了です。以下を使用して実行してください：
`npm start`
デフォルトでは、アプリケーションはポート5000で実行されます。`ngrok`を使用する場合は、今すぐトンネルを開始できます。

> ngrokトンネル名が変更された場合は、`nexmo app:update`コマンドを使用してアプリケーションのURLを更新することを忘れないでください。
試行手順
----
デモを試してみましょう。このためには、2台の電話（1台は「発信者」、もう1台は「コールセンターのオペレーター」）が必要なので、友人に依頼するか、Skypeを使用して最初の電話をかける必要があります。
1. 購入した番号のいずれかに電話をかけます。
2. 発信者にはグリーティングメッセージが聞こえ、コールセンターのオペレーターの電話番号が鳴ります。
3. コールセンターのオペレーターが応答すると、元の発信者に接続される前に「Whisper」のメッセージが流れます。
4. もう一度試してみてください。今回は、他の番号に電話して、別の「Whisper」を聞いてください。
コードを試行する
--------
デモは楽しいですが、ご自分で構築したいという方がおそらく見たいと思うポイントがいくつかあります。このセクションでは、プロセスの各ステップのコードの主要なセクションを確認して、物事が起きる場所を見つけ、このアプリケーションをニーズに合わせて調整できるようにします。
### 着信コールに応答し、発信コールを開始する
Vonageアプリケーションにリンクされている番号の1つに誰かが電話をかけると、Vonageは着信コールを受信します。その後、Vonageはその呼び出しをあなたのWebアプリケーションに通知します。これは、Webアプリの`answer_url`エンドポイント（この場合は`/answer`）に対して[Webhookリクエスト](/voice/voice-api/webhook-reference#answer-webhook)を行うことで実行されます。電話に出ると、アプリケーションはその発信者をコールセンターのオペレーターに接続します。
**lib/routes.js** 
```js
  app.get('/answer', function(req, res) {
    var answer_url = 'http://'+process.env['DOMAIN']+'/on-answer'
    console.log(answer_url);
      res.json([
        {
          "action": "talk",
          "text": "Thanks for calling. Please wait while we connect you"
        },
        {
          "action": "connect",
          "from": req.query.to,
          "endpoint": [{
            "type": "phone",
            "number": process.env['CALL_CENTER_NUMBER'],
            "onAnswer": {"url": answer_url}
          }]
        }
      ]);
  });
```
*注：詳細については、[音声用APIの関連情報](/api/voice)を参照してください。* 
返される応答は、[NCCO](https://developer.nexmo.com/voice/voice-api/ncco-reference)（Nexmo Call Control Objects）の配列です。最初のものは発信者が聞く音声メッセージで、2番目のものは他の発信者に接続し、相手が電話に出たときに使用するURLを指定します。
### Whisperを再生し、コールを接続する
コールセンターのオペレーターが電話に応答すると、アプリケーションでは`/on-answer`エンドポイントである`onAnswer`のURLが使用されます。これは、どの番号がダイヤルされたかを調べ、どのようなアナウンスをするかを決定するコードです。
**lib/routes.js** 
```js
// Define the topics for the inbound numbers
var topics = {}
topics[process.env['INBOUND_NUMBER_1']] = 'the summer offer';
topics[process.env['INBOUND_NUMBER_2']] = 'the winter offer';
```
コールが接続されると、`talk` NCCOアクションを使用してエージェントにCall Whisperを再生し、どの広告キャンペーンについてのものであるかを伝えてから、カンファレンスで待機している発信者に接続します。
**lib/routes.js** 
```js
  app.get('/on-answer', function(req, res) {
    // we determine the topic of the call based on the inbound call number
    var topic = topics[req.query.from]
    res.json([
      // We first play back a little message telling the call center operator what
      // the call relates to. This "whisper" can only be heard by the call center operator
      {
        "action": "talk",
        "text": "Incoming call regarding "+topic
      }
    ]);
  });
```
ここにはWhisperをカスタマイズするのに役立つ、非常に多くの可能性があります。`onAnswer`の`url`を使用して発信者の番号を渡して検索することにより、その人を名前で呼んだり、その他の情報を提供したりできます。可能性は無限大ですが、このチュートリアルでは、皆さんがそれに基づいて構築したりカスタマイズしたりすることができる実用的な例を紹介します。
関連情報

---

* [https://github.com/Nexmo/node-call-whisper](https://github.com/Nexmo/node-call-whisper)には、このサンプルアプリケーションのすべてのコードが含まれています。
* 音声でできるその他の機能については、[音声ガイド](/voice)をご覧ください。
* [音声用APIの関連情報](/api/voice)には、各エンドポイントの詳細なドキュメントが掲載されています。

