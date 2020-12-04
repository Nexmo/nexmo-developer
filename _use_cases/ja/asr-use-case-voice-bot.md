---
title:  音声ボット

products: voice/voice-api

description:  「このチュートリアルでは、自動音声認識を使用して音声ボット/インタラクティブ音声アシスタントアプリケーションを作成する方法を説明します。」

languages:
  - Node
*** ** * ** ***
音声ボット/対話型音声アシスタント
=================
このチュートリアルでは、着信コールに応答する簡単なボットを作成します。ボットはあなたの現在地を尋ね、それに応じて実際の気象条件を共有します。これは、[Express](https://expressjs.com/) Webアプリケーションフレームワーク、[Weatherstack](https://weatherstack.com/) API、Vonage自動音声認識（Vonage Automatic Speech Recognition：ASR）機能を使用して実装します。
準備
---
このチュートリアルを完了するためには、以下のものが必要です。
* [Vonageアカウント](https://dashboard.nexmo.com/sign-up)
* [Nexmo CLI](/application/nexmo-cli)がインストールされ、セットアップされている
* [ngrok](https://ngrok.com/) - 開発用Webサーバーをインターネット経由でVonageのサーバーにアクセスできるようにする
* [Node.JS](https://nodejs.org/en/download/)がインストールされている
依存関係をインストールする
-------------
[Express](https://expressjs.com) Webアプリケーションフレームワークと[body-parser](https://www.npmjs.com/package/body-parser)パッケージをインストールします。
```sh
$ npm install express body-parser
```
Vonage番号を購入する
-------------
まだお持ちでない場合は、着信コールを受信するためのVonage番号を購入してください。
まず、お住まいの国で利用可能な番号をリストします（`GB`を2文字の[国コード](https://www.iban.com/country-codes)に置き換えてください）：
```sh
nexmo number:search GB
```
利用可能な番号のいずれかを購入してください。たとえば、番号`447700900001`を購入するには、次のコマンドを実行します。
```sh
nexmo number:buy 447700900001
```
音声用APIアプリケーションを作成する
-------------------
CLIを使用して、Vonage番号（`/webhooks/answer`）でのコールへの応答と通話イベントのログ記録（`/webhooks/events`）をそれぞれ行うWebhookで音声用APIアプリケーションを作成します。
これらのWebhookは、Vonageのサーバーからアクセスできる必要があるため、このチュートリアルでは、`ngrok`を使用してローカル開発環境をパブリックインターネットに公開します。[この記事](/tools/ngrok)では、`ngrok`をインストールして実行する方法について説明しています。
次のコマンドを使用して`ngrok`を実行します。
```sh
ngrok http 3000
```
`ngrok`提供する一時的なホスト名をメモしておき、次のコマンドで`example.com`の代わりに使用します。
```sh
nexmo app:create "Weather Bot" --capabilities=voice --voice-event-url=https://example.com/webhooks/event --voice-answer-url=https://example.com/webhooks/answer --keyfile=private.key
```
このコマンドは、アプリケーションID（メモしておく必要があります）と秘密鍵情報（このチュートリアルでは無視しても問題ありません）を返します。
番号をリンクする
--------
Vonage番号を、作成した先ほど作成し音声用APIアプリケーションにリンクする必要があります。次のコマンドを使用します。
```sh
nexmo link:app NEXMO_NUMBER NEXMO_APPLICATION_ID
```
これで、アプリケーションコードを書く準備ができました。
Weatherstackアカウントにサインアップする
--------------------------
このチュートリアルでは、Weatherstack APIを使用して気象情報を取得します。リクエストを行うには、APIキーを取得するための無料アカウントに[サインアップ](https://weatherstack.com/signup/free)する必要があります。
応答Webhookを記述する
--------------
Vonageが仮想番号で着信コールを受信すると、`/webhooks/answer`ルートにリクエストを送信します。このルートは、HTTP `GET`リクエストを受け入れて、Vonageにコールの処理方法を指示する[Nexmo Call Control Object（NCCO）](/voice/voice-api/ncco-reference)を返す必要があります。
NCCOは、`talk`アクションを使用して発信者に挨拶し、`input`アクションを使用してリスニングを開始します。
```js
'use strict'
const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const http = require('http')
app.use(bodyParser.json())
app.get('/webhooks/answer', (request, response) => {
  const ncco = [{
      action: 'talk',
      text: 'Thank you for calling Weather Bot! Where are you from?'
    },
    {
      action: 'input',
      eventUrl: [
        `${request.protocol}://${request.get('host')}/webhooks/asr`],
      type: [ "speech" ]
    },
    {
      action: 'talk',
      text: 'Sorry, I don\'t hear you'
    }
  ]
  response.json(ncco)
})
```
イベントWebhookを記述する
----------------
コンソールでコールのライフサイクルを監視できるように、通話イベントをキャプチャするWebhookを実装します。
```js
app.post('/webhooks/events', (request, response) => {
  console.log(request.body)
  response.sendStatus(200);
})
```
Vonageは通話ステータスが変更されるたびに、このエンドポイントに`POST`リクエストを送信します。
ASR Webhookを記述する
----------------
音声認識の結果は、入力アクションで設定した特定のURLに送信されます：`/webhooks/asr`Webhookを追加して結果を処理し、ユーザーとの対話を追加します。
認識に成功した場合、リクエストペイロードは次のようになります。
```json
{
  "speech": {
    "timeout_reason": "end_on_silence_timeout",
    "results": [
      {
        "confidence": 0.78097206,
        "text": "New York"
      }
    ]
  },
  "dtmf": {
    "digits": null,
    "timed_out": false
  },
  "from": "442039834429",
  "to": "442039061207",
  "uuid": "abfd679701d7f810a0a9a44f8e298b33",
  "conversation_uuid": "CON-64e6c8ef-91a9-4a21-b664-b00a1f41340f",
  "timestamp": "2020-04-17T17:31:53.638Z"
}
```
したがって、さらに分析するには、`speech.results`配列の最初の要素を使用する必要があります。気象条件データを取得するには、次のURLに対してHTTP `GET`リクエストを行う必要があります。
```http
GET http://api.weatherstack.com/current?access_key=<key>&query=<location>
```
前のコードブロックでは、`access_key`はWeatherstack APIキーであり、`query`はユーザーが話したこと（または少なくともユーザーが話すと予想されること）です。Weatherstackは、応答本文に多くの興味深いデータを提供します。
```json
{
  "request": {
    "type": "City",
    "query": "New York, United States of America",
    "language": "en",
    "unit": "m"
  },
  "location": {
    "name": "New York",
    "country": "United States of America",
    "region": "New York",
    "lat": "40.714",
    "lon": "-74.006",
    "timezone_id": "America/New_York",
    "localtime": "2020-04-17 13:33",
    "localtime_epoch": 1587130380,
    "utc_offset": "-4.0"
  },
  "current": {
    "observation_time": "05:33 PM",
    "temperature": 9,
    "weather_code": 113,
    "weather_icons": [
      "http://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"
    ],
    "weather_descriptions": [
      "Sunny"
    ],
    "wind_speed": 15,
    "wind_degree": 250,
    "wind_dir": "WSW",
    "pressure": 1024,
    "precip": 0,
    "humidity": 28,
    "cloudcover": 0,
    "feelslike": 7,
    "uv_index": 5,
    "visibility": 16,
    "is_day": "yes"
  }
}
```
アプリでは、`description`（「晴れ」）や`temperature`などの非常に単純なパラメーターのみを使用します。実際の気温ではなく天気予報を取得した方が良いですが、無料のWeatherstackアカウントでは`current`の気象状況しか取得できません。ここでは、これを使用します。
Weatherstackからの応答を受け取ったら、「今日のニューヨーク：晴れ、摂氏9度」というトークアクションを含む新しいNCCOを返します。
最後に、ASRコールバックを処理するコードを追加します。
```js
app.post('/webhooks/asr', (request, response) => {
  console.log(request.body)
  if (request.body.speech.results) {
    const city = request.body.speech.results[0].text
    http.get(
      'http://api.weatherstack.com/current?access_key=WEATHERSTACK_API_KEY&query=' +
      city, (weatherResponse) => {
        let data = '';
        weatherResponse.on('data', (chunk) => {
          data += chunk;
        });
        weatherResponse.on('end', () => {
          const weather = JSON.parse(data);
          console.log(weather);
          let location = weather.location.name
          let description = weather.current.weather_descriptions[0]
          let temperature = weather.current.temperature          
          console.log("Location: " + location)
          console.log("Description: " + description)
          console.log("Temperature: " + temperature)
          const ncco = [{
            action: 'talk',
            text: `Today in ${location}: it's ${description}, ${temperature}°C`
          }]
          response.json(ncco)
        });
      }).on("error", (err) => {
      console.log("Error: " + err.message);
    });
  } else {
    const ncco = [{
      action: 'talk',
      text: `Sorry I don't understand you.`
    }]
    response.json(ncco)
  }
})
```
ボットにロジックを追加することができます。たとえば、現在地が米国内の場合、気温を華氏に変換します。NCCOを作成する前に、このコードスニペットを追加します。
```js
if (weather.location.country == 'United States of America') {
  temperature = Math.round((temperature * 9 / 5) + 32) + '°F'
} else {
  temperature = temperature + '°C'
}
```
また、`temperature`変数の値に度数記号が含まれるようになったので、メッセージのテキストから度数記号を削除することを忘れないでください。
```js
text: `Today in ${location}: it's ${description}, ${temperature}`
```
Node.jsサーバーを作成する
----------------
最後に、Node.jsサーバーをインスタンス化するコードを記述します。
```js
const port = 3000
app.listen(port, () => console.log(`Listening on port ${port}`))
```
アプリケーションをテストする
--------------
1. 次のコマンドを実行して、Node.jsアプリケーションを実行します。
```sh
node index.js
```
1. Vonage番号に電話して、ウェルカムメッセージを聞いてください。
2. あなたのいる都市名をお話しください。
3. 実際の気象状況を聞き返してください。
まとめ
---
このチュートリアルでは、音声用APIを使用して、音声メッセージで質問したり、応答したりすることで発信者と対話するアプリケーションを作成しました。
作成したボットはシンプルなものでしたが、発信者の話を聞き、関連する情報も含めて応答することができました。あなたのケースや使用しているサービスに関連する適切なビジネスロジックを追加するだけで、IVRや顧客のセルフサービスアプリの基盤として使用することができます。
ご覧のとおり、自動音声認識（ASR）は、対話形式の音声ボットまたはIVR（対話型音声応答）/ IVA（対話型音声アシスタント）をすばやく実装するための簡単な方法です。より高い柔軟性やほぼリアルタイムの対話が必要な場合は、人工知能、分析、通話音声の文字起こしなど、非常に強力で高度なユースケースを実現する[WebSockets](/voice/voice-api/guides/websockets)機能をお試しください。
次の作業

---

このチュートリアルの次のステップとして実施していただけるさらにいくつかのリソースをご紹介します。

* [音声認識](/voice/voice-api/guides/speech-recognition)機能の詳細についてはこちらをご覧ください。
* SSMLを使用して[テキスト読み上げメッセージをカスタマイズする](/voice/voice-api/guides/customizing-tts)ことにより、ボットの音声をより自然にします。
* [WebSocket](/use-cases/voice-call-websocket-node)接続を介してrawメディアを取得して返送する方法をご覧ください。

