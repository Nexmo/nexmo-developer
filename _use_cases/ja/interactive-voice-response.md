---
title:  自動音声応答（IVR）

products: voice/voice-api

description:  ユーザーがキーパッドで情報を入力して音声応答を聞くための自動電話システムを構築する

languages:
  - PHP


---

自動音声応答（IVR）
===========

自動音声応答（IVR）サービスを提供することで、ユーザーは簡単な問い合わせを簡単かつ素早く行えます。このチュートリアルでは、シンプルなテキスト読み上げ（TTS）プロンプトとキーパッド入力を用いて、IVRを実現するアプリケーションの構築方法について説明します。

お客様が配送会社に電話して、注文状況を調べるというシナリオで考えます。お客様は注文番号の入力を求められ、入力すると（サンプルコードでランダムに生成した）注文状況を音声で知ることができます。

このチュートリアルは、[簡単なIVR](https://www.nexmo.com/use-cases/interactive-voice-response/)のユースケースに基づきます。コードはすべて[GitHub](https://github.com/Nexmo/php-phone-menu)で公開されています。

このチュートリアルの内容
------------

* [セットアップする](#setting-up-for-ivr) - アプリケーションを作成し、コードを指定するよう設定し、このチュートリアルで使用する番号を設定します。

* [通話を発信する](#try-it-yourself) - アプリケーションに電話をかけ、プロンプトに従って音声情報を聞きます。

* [コードの確認：着信コールを処理する](#handle-an-inbound-call) - 着信コールへの最初の応答を作成する方法です。

* [コードの確認：テキスト読み上げ挨拶文を送信する](#send-text-to-speech-greeting) - 応答時にテキスト読み上げでユーザーに挨拶します。

* [コードの確認：IVR経由でユーザー入力を要求する](#request-user-input-via-ivr-interactive-voice-response) - テキスト読み上げプロンプトを作成してユーザー入力を要求します。

* [コードの確認：ユーザー入力に応答する](#respond-to-user-input) - ユーザーの注文番号の入力を処理し、テキスト読み上げで状況を返します。

* [より良いテキスト読み上げにするためのヒント](#tips-for-better-text-to-speech-experiences) - より良い音声応答にするために使用できるヘルパーメソッドについて説明します。

* [次のステップ](#next-steps) - さらに知識を得るための詳しい資料です。

IVRをセットアップする
------------

このチュートリアルを進めるためには、次のものが必要です。

* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)。
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli)がインストールされ、セットアップされている。
* VonageがアプリにWebhookリクエストを送信するための、一般にアクセス可能なPHP Webサーバー。ローカル開発の場合、[ngrok](https://ngrok.com)をお勧めします。
* [チュートリアルのコード](https://github.com/Nexmo/php-phone-menu)。リポジトリを複製するか、使用するマシンにzipファイルをダウンロードして解凍してください。
* [使用方法を確認する `ngrok`](/tools/ngrok)

音声アプリケーションを作成する
---------------

Vonageアプリケーションには、Vonageエンドポイントに接続し、製品を簡単に使用するために必要なセキュリティおよび構成情報が含まれています。Vonage製品の呼び出しは、アプリケーションのセキュリティ情報を使用して行います。呼び出しが接続されると、VonageはWebhookエンドポイントと通信して、呼び出しを管理できます。

Nexmo CLIを使用して音声API用のアプリケーションを作成できます。これには、次のコマンドを使用します。`YOUR_URL`セグメントは自身のアプリケーションのURLに置き換えます。

```bash
nexmo app:create phone-menu YOUR_URL/answer YOUR_URL/event
Application created: 5555f9df-05bb-4a99-9427-6e43c83849b8
```

このコマンドは、`app:create`コマンドを使用して新しいアプリを作成します。パラメーターは次のとおりです。

* `phone-menu` - このアプリケーションに付ける名前
* `YOUR_URL/answer` - Vonage番号への着信コールを受信すると、Vonageは [GET] リクエストを行い、このWebhookエンドポイントからのコールフローを制御するNCCOを取得します。
* `YOUR_URL/event` - コールステータスが変化すると、Vonageはステータス更新をこのWebhookエンドポイントに送信します

このコマンドは、アプリケーションを識別するUUID（Universally Unique Identifier）を返します。後で使用するため、コピーしておくことをお勧めします。

電話番号を購入する
---------

アプリケーションへの着信コールを処理するには、Vonageの番号が必要です。使用する番号がすでにある場合は、次のセクションに移り、既存の番号とアプリケーションを関連付けてください。

[Nexmo CLI](https://github.com/nexmo/nexmo-cli)を使用して、電話番号を購入できます。

```bash
nexmo number:buy --country_code GB --confirm
Number purchased: 441632960960
```

`number:buy`コマンドで、どの国の番号にするかを[ISO 3166-1 alpha-2形式](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)で指定できます。`--confirm`も指定することで、番号の選択を確認する必要がありません。利用可能な最初の番号が購入されます。

これで、作成済みのアプリケーションを示す電話番号をセットアップできるようになりました。

電話番号をVonageアプリケーションにリンクする
-------------------------

次に、作成した *電話メニュー* アプリケーションに各電話番号をリンクします。アプリケーションに関連付けられた番号に関連するイベントが発生すると、Vonageはイベントに関する情報とともに、WebリクエストをWebhookエンドポイントに送信します。これを行うには、Nexmo CLIで`link:app`コマンドを使用します。

```bash
nexmo link:app 441632960960 5555f9df-05bb-4a99-9427-6e43c83849b8
```

パラメーターは使用する電話番号と、[音声アプリケーションを作成](#create-a-voice-application)したときに返されたUUIDです。

実際にやってみましょう。
------------

コードサンプルの詳細な説明はありますが、詳細に踏み込む前に、まずはアプリケーションを試してみましょう。上記の手順で作成しリンクした番号とアプリケーションを使用して、コードを取得して実行します。

[リポジトリ](https://github.com/Nexmo/php-phone-menu)のクローンを作成していない場合は、まず作成します。

プロジェクトディレクトリにComposerを使用して依存関係をインストールします。

    composer install

`config.php.dist`を`config.php`にコピーし、編集してベースURL（上記でアプリケーションをセットアップした際に使用したものと同じURL）を追加します。

> ngrokを使用している場合、トンネルURLをランダムに生成します。他の構成を行う前にngrokを起動しておくと、エンドポイントとなるURLを把握できて便利です（有料ngrokユーザーはトンネル名を予約できます）。また、設定したURLを更新する必要がある場合は、`nexmo app:update`コマンドがあることも知っておきましょう。

すべて設定できたら、PHP Webサーバーを起動します。

    php -S 0:8080 ./public/index.php

起動したら、Vonage番号に電話をかけ、指示に従います。コードは、コールの開始時や呼び出し中などに、`/event`へのWebhookを受信します。システムがコールに応答すると、Webhookが`/answer`に着信し、コードがいくつかのテキスト読み上げで応答してユーザーの入力を待ちます。ユーザーが入力すると、Webhookにより`/search`に送信され、再度コードがテキスト読み上げで応答します。

ここまで、実際の動作を見てきました。では、各要素はどのように機能しているのでしょうか。PHPコードのすべての説明と、PHPコードがコールフローを管理している方法についてお読みください。

着信コールを処理する
----------

Vonageは、Vonage番号への着信を受信すると、[音声アプリケーションの作成](#create-a-voice-application)時に設定したイベントWebhookエンドポイントにリクエストを送信します。Webhookはまた、 *DTMF* 入力がユーザーから収集されるたびに送信されます。

このチュートリアルコードでは、簡単なルーターを使用して、これらの着信Webhookを処理します。ルーターは、リクエストされたURIパスを決定し、これを使用して、電話メニューから発信者のナビゲーションをマッピングします。これは、WebアプリケーションのURLと同じです。

Webhook本体からのデータが取得され、リクエスト情報でメニューに渡されます。

```php
<?php

// public/index.php

require_once __DIR__ . '/../bootstrap.php';

$uri = ltrim(strtok($_SERVER["REQUEST_URI"],'?'), '/');
$data = file_get_contents('php://input');
```

Vonageは、コールステータスが変更されるたびにWebhookを送信します。たとえば、電話が`ringing`の場合、コールは`answered`または`complete`になります。アプリケーションは`switch()`ステートメントを使用して`/event`エンドポイントで受信したデータをログに記録し、デバッグプロセスに使用します。その他のすべてのリクエストは、ユーザー入力を処理するコードに送られます。コードは次のようになります。

```php
<?php

// public/index.php

switch($uri) {
    case 'event':
        error_log($data);
        break;
    default:
        $ivr = new \NexmoDemo\Menu($config);
        $method = strtolower($uri) . 'Action';

        $ivr->$method(json_decode($data, true));

        header('Content-Type: application/json');
        echo json_encode($ivr->getStack());
}
```

`/event`ではないリクエストは`Menu`オブジェクトの`Action`メソッドにマップされます。着信したリクエストデータはそのメソッドに渡されます。ルーターは、NCCO（Nexmo Call Control Object）を取得し、これを正しい`Content-Type`でJSON形式の本文として応答で送信します。

コールバックURLを含むことができるNCCOを生成するときに、アプリケーションのベースURLを知る必要があるため、`$config`配列が`Menu`オブジェクトに渡されます。

```php
<?php

// src/Menu.php

public function __construct($config)
{
    $this->config = $config;
}
```

NCCOを生成する
---------

Nexmo Call Control Object（NCCO）は、音声APIコールフローの操作に使用されるJSON配列です。Vonageでは、コールの各段階を制御するために応答WebhookでNCCOが返されなければなりません。

NCCOを管理するために、このサンプルアプリケーションでは配列操作といくつかの簡単なメソッドを使用しています。

ルーターはJSONへのエンコーディングを処理し、`Menu`オブジェクトはその`getStack()`メソッドを使用してNCCOスタックへのアクセスを提供します。

```php
<?php

// src/Menu.php

public function getStack()
{
    return $this->ncco;
}
```

また、NCCOスタックを管理するための基礎となる、いくつかのヘルパーメソッドもあります。これらは、独自アプリケーションで役に立ちます。

```php
<?php

// src/Menu.php

protected function append($ncco)
{
    array_push($this->ncco, $ncco);
}

protected function prepend($ncco)
{
    array_unshift($this->ncco, $ncco);
}
```

### テキスト読み上げ挨拶文を送信する

コールに応答すると、VonageはWebhookをアプリケーションの`/answer`エンドポイントに送信します。ルーティングコードはこれを`Menu`オブジェクトの`answerAction()`メソッドに送信します。このメソッドは、挨拶を含むNCCOを追加することから始まります。

```php
<?php

// src/Menu.php

public function answerAction()
{
    $this->append([
        'action' => 'talk',
        'text' => 'Thanks for calling our order status hotline.'
    ]);

    $this->promptSearch();
}
```

これは、シンプルなテキスト読み上げメッセージを返す方法の分かりやすい例です。

### IVR（自動音声応答）経由でユーザー入力を要求する

このサンプルアプリケーションでは、ユーザーは注文IDを提供する必要があります。この部分では、最初に別の「トーク」NCCOをプロンプトに追加します（挨拶が含まれている場合、注文番号を要求するたびにユーザーに挨拶することになります）。次のNCCOは、ユーザーの入力を受信する場所です。

```php
<?php

// src/Menu.php

protected function promptSearch()
{
    $this->append([
        'action' => 'talk',
        'text' => 'Using the numbers on your phone, enter your order number followed by the pound sign'
    ]);

    $this->append([
        'action' => 'input',
        'eventUrl' => [$this->config['base_path'] . '/search'],
        'timeOut' => '10',
        'submitOnHash' => true
    ]);
}
```

NCCOの`eventUrl`オプションを使用して、ユーザーがデータを入力した際にWebhookを送信する場所を指定します。これは、基本的にHTML`<form>`の`action`プロパティで行う動作と同じです。これは、`$config`配列とベースURLが使用される場所です。

他にも、`input`固有のプロパティをいくつか使用します。`timeOut`で、ユーザーが注文番号を入力する時間を増やし、`submitOnHash`で、注文IDの最後にシャープ記号（イギリス英語の通話者にとってはハッシュ記号「\#」）を付けることでユーザーの待ち時間がなくなります。

### ユーザー入力に応答する

ユーザーが入力した後、VonageはWebhookを`input`で定義された`eventUrl`に送信します。`eventUrl`を`/search`に設定したため、コードはリクエストを`searchAction`にルートします。リクエストには、ユーザーが入力した数字を格納した`dtmf`フィールドが含まれます。この入力データを使用して、ユーザーに返すサンプルデータをランダムに生成します。実際のアプリケーションでは、情報をデータベースからフェッチするなど、もっと実用的な方法で行います。次のようなアクションになります。

```php
<?php

// src/Menu.php

public function searchAction($request)
{
    if(isset($request['dtmf'])) {
        $dates = [new \DateTime('yesterday'), new \DateTime('today'), new \DateTime('last week')];
        $status = ['shipped', 'backordered', 'pending'];

        $this->append([
            'action' => 'talk',
            'text' => 'Your order ' . $this->talkCharacters($request['dtmf'])
                      . $this->talkStatus($status[array_rand($status)])
                      . ' as  of ' . $this->talkDate($dates[array_rand($dates)])
        ]);
    }

    $this->append([
        'action' => 'talk',
        'text' => 'If you are done, hangup at any time. If you would like to search again'
    ]);

    $this->promptSearch();
}
```

検索アクションから分かるように、サンプルアプリケーションはユーザーにおかしなデータを返信しています。着信した`dtmf`データフィールドからの注文番号、ランダムの注文状況、ランダムな日付（本日、昨日、または1週間前）を音声による「更新」として含むNCOOがあります。独自のアプリケーションでは、よりロジカル、つまり論理的なものになるでしょう。

注文情報がユーザーに渡されると、いつでも電話を切ってよいことが通知されます。注文プロンプトNCCOを追加するメソッドが再利用されます。これにより、ユーザーは別の注文を検索できますが、毎回挨拶を聞くことはありません。

より良いテキスト読み上げのためのヒント
-------------------

`Menu`クラスには、アプリケーションデータを音声プロンプトに変換する処理を改善するためのメソッドがいくつかあります。このアプリケーションには、次のようなものがあります。

* ステータスが最後に報告された日付
* 注文番号
* 注文状況

これらの値を、ユーザーに明確に伝えることができるメソッドがあります。1つ目は、`talkDate`メソッドです。これは日付形式の文字列を返すもので、話し言葉に適しています。

```php
<?php

// src/Menu.php

protected function talkDate(\DateTime $date)
{
    return $date->format('l F jS');
}
```

2つ目は、`talkCharacters`メソッドです。これは文字列の各文字間にスペースを配置するもので、これにより文字列を個々に読み取ることができます。これは、注文番号の報告に使用されています。

```php
<?php

// src/Menu.php

protected function talkCharacters($string)
{
    return implode(' ', str_split($string));
}
```

3つ目は`talkStatus`メソッドです。これは、単純な検索を使用して非常に簡潔な定数をより会話的なフレーズに変換するものです。

```php
<?php

// src/Menu.php

protected function talkStatus($status)
{
    switch($status){
        case 'shipped':
            return 'has been shipped';
        case 'pending':
            return 'is still pending';
        case 'backordered':
            return 'is backordered';
        default:
            return 'can not be located at this time';
    }
}
```

まとめ
---

これで、ユーザーからの入力を収集して、（偽のものですが）情報を返答するインタラクティブな電話メニューが構築できました。`talk` NCOOを使用してユーザーに通知するのではなく、`connect` NCCOでコールを特定の部署に転送したり、`record` NCCOでユーザーからのボイスメールを取得したりすることができます。

次のステップ
------

こうしたタイプのアプリケーションを構築する際に便利なリソースをいくつかご紹介します。

* [読み上げ機能ガイド](https://developer.nexmo.com/voice/voice-api/guides/customizing-tts) - 提供されているさまざまな音声と、より良い音声出力を制御するためのSSML（音声合成マークアップ言語）に関する情報があります。
* [Twitter IVR](https://www.nexmo.com/blog/2018/06/26/twitter-interactive-voice-response-dr/) - もう1つのサンプルです。内容はたわいのないものですが、Pythonで記述されたサンプルアプリとして優れた例です。
* [AWS LambdaでPythonを使用したプロンプトコールによるテキスト読み上げ](https://www.nexmo.com/blog/2018/02/16/text-speech-prompt-calls-using-python-aws-lambda-dr/) - 同様のアプリケーションですが、これはAWS Lambda（サーバーレスプラットフォーム）とPythonを使用した例です。
* [DTMFを処理するためのコードサンプル](https://developer.nexmo.com/voice/voice-api/code-snippets/handle-user-input-with-dtmf) - このチュートリアルで使用したユーザーのキーパッド入力を処理する各種プログラミング言語の例です。

