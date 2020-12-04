---
title:  コールを追跡する

products: voice/voice-api

description:  着信コールごとに異なる番号を使用して追跡することにより、どのキャンペーンがうまく機能しているかを追跡できます。このチュートリアルでは、着信コールを処理する方法、着信コールを別の番号に接続する方法、あなたの各Vonage番号を呼び出した電話番号を追跡する方法を説明しています。

languages:
  - Node
*** ** * ** ***
すべてのVonage番号の使用状況を追跡する
======================
Vonage番号で受信したコールを追跡することにより、顧客とのコミュニケーションの有効性に関するインサイトを得ることができます。マーケティングキャンペーンごとに異なる番号を登録しておくことで、どの番号が一番効果があるのかがわかり、その情報をもとに今後のマーケティング活動を改善することができます。
ここでの例ではnode.jsを使用しており、すべてのコードは[GitHubで公開されています](https://github.com/Nexmo/node-call-tracker)が、このアプローチは他のテクノロジースタックでも同じように効果的に使用することができます。
準備
---
このチュートリアルを進めるためには、以下のものが必要になります。
* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli)がインストールされ、セットアップされている。
* VonageがアプリにWebhookリクエストを実行できるように、一般にアクセス可能なWebサーバー。ローカルで開発している場合、[ngrok](https://ngrok.com/)をお勧めします。
⚓ 音声アプリケーションを作成する
⚓ 音声対応電話番号を購入する
⚓ 電話番号をVonageアプリケーションにリンクする
はじめに
----
コードを入手して開始する前に、Vonageアプリケーションをセットアップし、それで使用するいくつかの番号を取得してください。Vonageアプリケーションを作成する際には、いくつかの[Webhook](https://developer.nexmo.com/concepts/guides/webhooks)エンドポイントを指定します。これらは、あなた自身のアプリケーション内のURLであり、あなたのコードが一般に公開されていなければならない理由です。発信者がVonage番号に電話をかけると、Vonageは指定した`answer_url`エンドポイントにWebリクエストを送信し、そこにある指示に従います。
呼び出し状態が変化するたびに更新を受信する`event_url` Webhookもあります。簡単にするために、このアプリケーションでは、コードは単にイベントをコンソールに出力して、アプリケーションの開発中にイベントを簡単に確認できるようにします。
最初のアプリケーションを作成するには、Nexmo CLIを使用して以下のコマンドを実行し、URLを2か所で置き換えます。
```bash
nexmo app:create --keyfile private.key call-tracker https://your-url-here/track-call https://your-url-here/event
```
このコマンドは、アプリケーションを識別するUUID（Universally Unique Identifier）を返します。安全な場所にコピーしておいてください。後で必要になります。
パラメーターは次のとおりです。
  - call-tracker - このアプリケーションに付ける名前
  - private.key` - 秘密鍵を保存するファイルの名前で、アプリケーションは`private.keyを期待しています
  - https://example.com/track-call` - Vonage番号への着信コールを受信すると、Vonageは`GETリクエストを行い、このWebhookエンドポイントからのコールフローを制御するNCCOを取得します
  - https://example.com/event - 通話ステータスが変更されると、VonageはこのWebhookエンドポイントにステータスの更新を送信します
このアプリケーションを試すには、いくつかのVonage番号が必要になります。番号を購入するには、Nexmo CLIと次のようなコマンドを再度使用します。
```bash
nexmo number:buy --country_code US --confirm
```
このコマンドには、[ISO 3166-1 alpha-2形式](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)の任意の国コードを使用できます。結果は購入した番号なので、それをコピーして（`nexmo numbers:list`でいつでもリストを取得できます）、作成したアプリケーションにリンクします。
```bash
nexmo link:app [number] [application ID]
```
使用したい番号の数だけ、購入とリンクの手順を繰り返します。

> 新規ユーザーの場合、番号を購入する前にアカウントにチャージする必要があります。
アプリケーションを設定して実行する
-----------------
コードはここから入手してください：[https://github.com/Nexmo/node-call-tracker](https://github.com/Nexmo/node-call-tracker)リポジトリをローカルマシンにクローンするか、zipファイルをダウンロードしてください。どちらでも構いません。
次のコマンドで依存関係をインストールします： `npm install`
次に、構成テンプレート`example.env`を`.env`というファイルにコピーします。このファイルでは、Vonageが接続する電話番号を設定する必要があります。これは近くにいて出られる電話であれば、どのような電話でも構いません。

> `PORT`設定を追加して、`.env`ファイルにポート番号を設定することもできます。
Webサーバーを起動するには： `npm start`
http://localhost:5000にアクセスして、すべてが期待どおりに機能していることを確認してください。応答として「Hello Vonage」が表示されます。
着信音声コールを処理する
------------
Vonageは、Vonage番号への着信コールを受信すると、[音声アプリケーションの作成](#get-started)時に設定したWebhookエンドポイントにリクエストを送信します。
```sequence_diagram
Participant App
Participant Vonage
Participant Caller
Note over Caller,Vonage: Caller calls one of\nthe tracking numbers
Caller->>Vonage: Calls Vonage number
Vonage->>App:Inbound Call(from, to)
```
発信者が電話をかけると、アプリケーションは着信Webhookを受信します。発信者が発信している番号（`to`番号）とダイヤルした番号（`from`番号）を抽出し、これらの値をコール追跡ロジックに渡します。
着信Webhookは`/track-call`ルートによって受信されます：
```js
app.get('/track-call', function(req, res) {
  var from = req.query.from;
  var to = req.query.to;
  var ncco = callTracker.answer(from, to);
  return res.json(ncco);
});
```
⚓ コールを追跡する
発信者を接続する前にコールを追跡する
------------------
実際にコールを追跡するロジックは、サンプルアプリケーションでは分離され、とても単純です。サーバーを再起動するとデータが失われるので、単純すぎるかもしれません。あなた自身のアプリケーションでは、この部分を拡張して、データベースやロギングプラットフォームに書き込んだり、またはご自分のニーズに合わせて他の何かに書き込むことができます。コールを追跡した後、アプリケーションは[Nexmo Call Control Object（NCCO）](https://developer.nexmo.com/voice/voice-api/ncco-reference)を返し、Vonageのサーバーに通話で次に何をすべきかを指示します。
このコードは`lib/CallTracker.js`にあります：
```js
/**
 * Track the call and return an NCCO that proxies a call.
 */
CallTracker.prototype.answer = function (from, to) {
  if(!this.trackedCalls[to]) {
    this.trackedCalls[to] = [];
  }
  this.trackedCalls[to].push({timestamp: Date.now(), from: from});
  
  var ncco = [];
  
  var connectAction = {
    action: 'connect',
    from: to,
    endpoint: [{
      type: 'phone',
      number: this.config.proxyToNumber
    }]
  };
  ncco.push(connectAction);
  
  return ncco;
};
```
NCCOは、`connect`アクションを使用して、発信者を設定ファイルで指定した番号への別の呼び出しに接続します。`from`番号はVonage番号である必要があるため、コードは追跡された番号を発信コールのCaller IDとして使用します。コール制御オブジェクトの[`connect`アクションまたは詳細については、NCCOのドキュメント](https://developer.nexmo.com/voice/voice-api/ncco-reference#connect)を確認してください。
まとめ
---
この方法では、一部のVonage番号をnode.jsアプリケーションにリンクし、それらの番号への着信コールの記録を作成し、発信者をアウトバウンド番号に接続することができます。タイムスタンプと発信者および着信者の番号を記録することで、このデータに対して必要な分析を実行して、ビジネスに最適な結果を得ることができます。
次の作業

---

このチュートリアルの次のステップとして実施していただけるさらにいくつかのリソースをご紹介します。

* [着信コールにCall Whisperを追加して、](https://developer.nexmo.com/tutorials/add-a-call-whisper-to-an-inbound-call)着信コールを発信コールに接続する前に、着信コールの詳細を発信コールにアナウンスします。
* [ngrokトンネルを使用してローカル開発サーバーをVonage APIに接続する](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)方法を説明したブログ記事をご覧ください。
* [「音声のWebhookの関連情報」](https://developer.nexmo.com/voice/voice-api/webhook-reference)には、`answer_url`エンドポイントと`event_url`エンドポイントの両方の着信Webhookの詳細を記載しています。
* Vonageコールのフローを制御するために使用できるその他のアクションの詳細については、[NCCOドキュメント](https://developer.nexmo.com/voice/voice-api/ncco-reference)を参照してください。

