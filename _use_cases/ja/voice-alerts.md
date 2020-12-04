---
title:  音声ベースの重要なアラートを発信する

products: voice/voice-api

description:  このチュートリアルでは、電話でリストの人々に連絡し、メッセージを伝え、メッセージを受信したことを誰が確認したかを知る方法を学習します。これらの音声ベースの重要なアラートは、テキストメッセージに比べ長く通知し続けるため、メッセージに気づく可能性が高くなります。さらに、受信者の確認を行うことで、メッセージの送受信が成功したことを確認できます。

languages:
  - PHP
*** ** * ** ***
音声ベースの重要なアラートを発信する
==================
しつこく鳴り続ける電話は、テキストメッセージやプッシュアラートよりも見逃しにくいので、[重要なアラート](https://www.nexmo.com/use-cases/voice-based-critical-alerts)が適切な相手に届くようにする必要がある場合は、電話は利用可能な最良の選択肢のひとつです。
このチュートリアルでは、電話でリストの人々に連絡し、メッセージを伝え、メッセージを受信したことを誰が確認したかを知る方法を学習します。これらの音声ベースの重要なアラートは、テキストメッセージに比べ長く通知し続けるため、メッセージに気づく可能性が高くなります。さらに、受信者の確認を行うことで、メッセージの送受信が成功したことを確認できます。
準備
---
このチュートリアルを進めるためには、次のものが必要です。
* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* [Vonage PHPサーバーSDK](https://github.com/nexmo/nexmo-php)をインストールするための[Composer](http://getcomposer.org/)
* VonageがアプリへのWebhookリクエストを実行できるように、一般にアクセス可能なWebサーバー、または[ngrok](https://ngrok.com/)を使用して、外部からローカル開発プラットフォームにアクセスできるようにします。
* チュートリアルコードは[https://github.com/Nexmo/php-voice-alerts-tutorial](https://github.com/Nexmo/php-voice-alerts-tutorial)にあります。プロジェクトを複製するか、zipファイルをダウンロードしてください。
⚓ 音声アプリケーションを作成する
⚓ 仮想番号をプロビジョニングする
最初のステップ
-------
まず、このアプリケーションで使用するVonage番号を登録します。[アプリケーションの使用を開始する](https://developer.nexmo.com/concepts/guides/applications#getting-started-with-applications)手順に従ってください。ここでは番号を購入し、アプリケーションを作成して、その2つをリンクする方法について説明します。
アプリケーションの構成時に、`answer_url`と`event_url`の両方の部分として、公開されているWebサーバーまたはngrokエンドポイントのURLを指定する必要があります。これらのファイルは、このプロジェクトではそれぞれ`answer.php`と`event.php`と呼ばれています。たとえば、ngrok URLが`https://25b8c071.ngrok.io`の場合、設定は次のようになります。
* **answer\_url*  - https://25b8c071.ngrok.io/answer.php
* **event\_url*  - https://25b8c071.ngrok.io/event.php
アプリケーションを作成したら、認証に使用するキーを取得します。これを、`private.key`ファイルに保存して安全な場所に保管しておきます。これは、電話をかけるために後で必要になります。
アプリケーションを作成し、構成して電話番号をリンクしたら、コードを確認してください。その後、そのコードを実行してみます。
⚓ Nexmo Call Control Objectを作成する
⚓ 通話を作成する
アプリケーションを「話す」ことを教える
-------------------
人間が電話でアプリケーションに接続している場合、Vonage Call Control Objects（NCCO）を使用して人間が聞くものを制御します。NCCOは、着信と発信の両方に使用できます。一度通話が行われれば、それがどちらであったかはあまり関係ありません。
以前リンクした番号に電話がかかってきた場合、Vonageは、アプリケーションで構成した`answer_url`に対してリクエストを行い、応答がNCCOの配列であると想定します。
リポジトリの`answer.php`を見てみてください。これがNCCOを返すコードです。このケースでは、テキスト読み上げメッセージとユーザー入力のプロンプトがあります。
```php
$ncco = [
    [
        "action" => "talk",
        "voiceName" => "Jennifer",
        "text" => "Hello, here is your message. I hope you have a nice day."
    ],
    [
        "action" => "talk",
        "voiceName" => "Jennifer",
        "text" => "To confirm receipt of this message, please press 1 followed by the pound sign"
    ],
    [
        "action" => "input",
        "submitOnHash" => "true",
        "timeout" => 10
    ],
    [
        "action" => "talk",
        "voiceName" => "Jennifer",
        "text" => "Thank you, you may now hang up."
    ]
];
// Vonage expect you to return JSON with the correct headers
header('Content-Type: application/json');
echo json_encode($ncco);
```
これは、いくつかの異なるタイプのNCCOの動作を示しており、NCCOで何ができるのかが分かります（詳細は、[NCCOの関連情報](https://developer.nexmo.com/voice/voice-api/ncco-reference)を参照してください）。これらはすべてJSONオブジェクトで、コードによって出力が構築され、正しいJSONヘッダで応答として送信されます。
他の電話からVonage番号にダイヤルし、上記の動作を確認する絶好のタイミングです。自由に編集して、他に何ができるか確認してみてください。
通話中のイベントを追跡する
-------------
アプリケーションが監視なしで通話できるようにする場合は、通話のステータスに関する情報を含めることができると便利です。これを支援するため、Vonageはアプリケーションのセットアップ時に構成した`event_url`にWebhookを送信します。これらのWebhookには、電話が鳴っていることや、応答したことなどを示すステータスのアップデートが含まれています。
このためのコードはプロジェクトの`event.php`にあります。これは特定のステータスをチェックして、それらの情報をログファイルに書き込みます。
```php
<?php
// Vonage sends a JSON payload to your event endpoint, so read and decode it
$request = json_decode(file_get_contents('php://input'), true);
// Work with the call status
if (isset($request['status'])) {
    switch ($request['status']) {
    case 'ringing':
        record_steps("UUID: {$request['conversation_uuid']} - ringing.");
        break;
    case 'answered':
        record_steps("UUID: {$request['conversation_uuid']} - was answered.");
        break;
    case 'complete':
        record_steps("UUID: {$request['conversation_uuid']} - complete.");
        break;
    default:
        break;
    }
}
function record_steps($message) {
    file_put_contents('./call_log.txt', $message.PHP_EOL, FILE_APPEND | LOCK_EX);
}
```

> ここでの`record_steps()`関数は、テキストファイルへの書き込みという非常に基本的なログ記録の例です。これを任意のログ記録プロトコルに置き換えることができます。
`call_log.txt`の内容を調べることで、以前にアプリケーションを呼び出したときに何が起こったかを確認できます。このファイルは、特定の電話や行われた「会話」の各ステータスの記録を保持しています。各行には会話の識別子が含まれています。これは、発信メッセージを伝えるために一度に多くの発信コールをかけ始めるときに非常に重要になります。どのイベントがどの会話に属しているのでしょうか。
自分の番号に電話をかける際にいくつかのことを試してみて、そのときのログファイルを確認してみましょう。たとえば、次のようなことを試します。
* プロンプトが表示されたら、`1`ではない数字を入力する
* 電話には出ずにボイスメールに転送する
アプリケーションは、呼び出しを行うとすぐに処理をする準備ができるため、プロジェクトの発信部分を構築しましょう。
⚓ 複数の人に発信する
発信電話をかける
--------
重要なメッセージが一人にしか送信されず、見過ごされてしまわないように、複数の人に向けて[メッセージを発信](https://www.nexmo.com/use-cases/voice-broadcast)する必要があります。そのため、スクリプトは`config.php`で設定したすべての連絡先をループして、それぞれの連絡先がコールを受信するように要求します。
電話をかけるには、Vonageの認証情報、アプリケーション自体、電話をかけたい相手に関する情報を使用してPHPアプリケーションを構成する必要があります。
`config.php.example`を`config.php`にコピーし、独自の値を次に追加します。
* [Dashboard](https://dashboard.nexmo.com)にあるAPIキーとシークレット
* このチュートリアルの最初に作成したアプリケーションのID
* ユーザーが電話を発信するVonage番号
* アプリケーションの公開URL
* 発信メッセージの受信者の名前と番号の組み合わせ

> また、プロジェクトのトップレベルにある`private.key`にアプリケーションを作成した際に生成されたキーが、保存されていることを確認してください。
また、`composer install`を実行して、プロジェクトの依存関係を導入する必要があります。これには[Vonage PHPサーバーSDK](https://github.com/nexmo/nexmo-php)が含まれており、Vonage APIでの作業をより簡単にするためのヘルパーコードを提供しています。
リポジトリに戻ると、この手順に必要なコードは`broadcast.php`にあります。
```php
require 'vendor/autoload.php';
require 'config.php';
$basic  = new \Nexmo\Client\Credentials\Basic($config['api_key'], $config['api_secret']);
$keypair = new \Nexmo\Client\Credentials\Keypair(
    file_get_contents(__DIR__ . '/private.key'),
    $config['application_id']
);
$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic, $keypair));
$contacts = $config['contacts'];
foreach ($contacts as $name => $number) {
    $client->calls()->create([
        'to' => [[
            'type' => 'phone',
            'number' => $number
        ]],
        'from' => [
            'type' => 'phone',
            'number' => $config['from_number']
        ],
        'answer_url' => [$config['base_url'] . '/answer.php'],
        'event_url' => [$config['base_url'] . '/event.php'],
        'machine_detection' => 'continue'
    ]);
    // Sleep for half a second
    usleep(500000);
}
```
`broadcast.php`のコードは、設定したAPIキーとシークレット、アプリケーションID、および以前に保存した`private.key`ファイルを使用して、`Nexmo\Client`オブジェクトを作成します。これは、通話を行い、必要な[通話オプション](https://developer.nexmo.com/api/voice#createCall)を渡すためのシンプルなインターフェースを提供します。
`usleep()`メソッドで一時停止の指示がありますが、これは[APIレート制限](https://help.nexmo.com/hc/en-us/articles/207100288-What-is-the-maximum-number-of-calls-per-second-)に達しないようにするためです。
`php broadcast.php`を実行してアプリケーションをテストし、提供したすべての電話番号が一度に鳴るのを確認してください。ユーザーに返されるNCCOを修正することで、発話されたメッセージを修正できます。また、異なる音声と言語を指定することもできます（[NCCOの関連情報セクション](https://docs.nexmo.com/voice/voice-api/ncco-reference#talk)にあるオプションの一覧を参照してください）。

> コンテキストに渡したい追加のパラメーターがある場合は、`answer_url`にGETパラメーターを追加することができます。たとえば、人の名前を追加して、`answer.php`にリクエストが届いたときに、その名前にアクセスできます。
テキスト読み上げ機能ではなく録音されたものを使用したり、ユーザーからの応答を録音したりと、アプリケーションで実行できる操作は他にもいくつかあります。次のいくつかのセクションでは、それらの操作へのアプローチ方法を紹介します。
### テキスト読み上げの代わりに録音されたものを使用する
Vonageのテキスト読み上げ機能を使用する代わりに（あるいは同時に）録音済みメッセージを使用するには、アクション`stream`持つNCCOを使用します。`stream`を使用すると、発信者に向けてオーディオファイルを再生できます。「streamUrl」はオーディオファイルを指します。
```php
[
    "action" => "stream",
    "streamUrl" => ["https://example.com/audioFile.mp3"]
],
```

> 録音をテストしてみて、音量が大きすぎたり小さすぎたりする場合は、「レベル」を設定することで、通話中の録音の音量レベルを調整できます。デフォルト値は「0」となっており、0\.1刻みで音量を-1まで下げたり、1まで上げたりすることができます。
```php
[
    "action" => "stream",
    "level" => "-0.4",
    "streamUrl" => ["https://example.com/audioFile.mp3"]
],
```
詳細については、[ストリームに関するNCCOの関連情報](https://developer.nexmo.com/voice/voice-api/ncco-reference#stream)を参照してください。
### 留守番電話とボイスメールを操作する
どの番号が応答されずにボイスメールに送られたかを追跡したい場合は、`broadcast.php`で示したように、発信時に`machine_detection`パラメーターを追加できます。これには、`continue`と`hangup`の2つのオプションを設定できます。通話がボイスメールに送信されたことをログに記録する場合は、`continue`を選択し、HTTPリクエストをイベントWebhook（`event_url`で指定されたURL）に送信します。
```php
'answer_url' => ['https://example.com/answer.php'],
'event_url' =>  ['https://example.com/event.php'],
'machine_detection' => 'continue'
```
`event.php`では、スクリプトは「machine 」というステータスを探し、それに応じてイベントをログに記録します。
### メッセージの受信を確認する
メッセージが配信されると、ユーザーとして、メッセージを受け取ったことを確認するためにいくつかのキーを押すように求められます。これは、ユーザーに指示を与える`talk`アクションと、ボタンの押下をキャプチャする`input`アクションによって達成されます。
```php
[
  "action" => "input",
  "submitOnHash" => "true",
  "timeout" => 10
],
```
`submitOnHash`をtrueに設定することで、シャープ記号またはポンド記号（`#`）が入力されると、次のNCCOにコールが移動します。それ以外の場合は、指定された`timeout`秒数 （デフォルトは 3秒）待ってから自動的に処理を開始します。
イベントスクリプトでは、入力アクションを処理するコードが表示されます。入力アクションからのデータは、`dtmf`キーの下に、押された数値を値として届きます。
```php
if (isset($request['dtmf'])) {
  switch ($request['dtmf']) {
      case '1':
          record_steps("UUID: {$request['conversation_uuid']} - confirmed receipt.");
          break;
      default:
          record_steps("UUID: {$request['conversation_uuid']} - other button pressed ({$request['dtmf']}).");
          break;
  }
}
```
この例では、何が起こったかをログに記録していますが、ユーザー自身のアプリケーションでは、ユーザーのニーズに合わせて入力を保存したり、応答したりすることができます。
⚓ まとめ
発信通話アプリケーション
------------
これで、テキスト読み上げや録音済みのメッセージを発信したり、応答された通話とボイスメールに送信された通話を記録したり、メッセージを受信したユーザーから受信確認を受け取ったりすることができる、シンプルながらも実用的な音声アラートシステムが完成しました。
⚓ 関連情報
次の手順と関連情報

---

* [ローカル開発にNgrokを使用する](/tools/ngrok)
* [発信コールの作成](/voice/voice-api/guides/outbound-calls) - さまざまなプログラミング言語で通話を発信するためのコードスニペット
* [DTMFによるユーザー入力の処理](/voice/voice-api/code-snippets/handle-user-input-with-dtmf) - さまざまなテクノロジスタックのコードを使用してユーザーのボタン押下をキャプチャする例を示します。
* [NCCOリファレンス](/voice/voice-api/ncco-reference) - 通話制御オブジェクトのリファレンスドキュメント
* [音声用APIリファレンス](/api/voice) - APIリファレンスドキュメント

