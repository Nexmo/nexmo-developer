---
title:  録音した通話をAmazon Transcribeで書き起こす

products: voice/voice-api

description:  「このチュートリアルでは、Amazon Transcribe APIを使用して、Vonage音声APIで録音した電話での会話を書き起こす方法を紹介しています」

languages:
  - Node
*** ** * ** ***
録音した通話をAmazon Transcribeで書き起こす
==============================
このチュートリアルでは、音声APIコールを録音し、それをAmazon Transcribe APIを使用して書き起こす方法を学びます。
![アプリケーションの概要](/images/amazon-transcribe-vapi-tutorial.png "アプリケーションの概要")
準備
---
少なくとも2つの個人電話番号が必要です。
* 1つは、[Vonage番号](/numbers/overview)を呼び出し、電話会議を開始するためのものです。
* もう1つは、電話会議への参加のために、Vonage番号から呼び出すものです。
2つ以上の番号にアクセスできる場合は、電話会議の参加者としてそれらの番号を含めることもできます。[発信者を追加する](#adding-more-callers)を参照してください。
また、Vonageアカウントも必要です。まだお持ちでない場合は、[こちらでサインアップ](https://dashboard.nexmo.com/sign-up)してください。
Nexmo CLIをインストールして設定する
----------------------
このチュートリアルでは[Nexmoコマンドラインツール](https://github.com/Nexmo/nexmo-cli)を使用します。先に進む前に、インストールと設定が完了していることを確認してください。
ターミナルプロンプトで次の`npm`コマンドを実行してCLIツールをインストールします。
```sh
npm install -g nexmo-cli
```
Developer Dashboardにある`VONAGE_API_KEY`と`VONAGE_API_SECRET`で、CLIツールを設定します。
```sh
nexmo setup VONAGE_API_KEY VONAGE_API_SECRET
```
Vonage番号を購入する
-------------
まだお持ちでない場合は、着信コールを受信するためにVonage番号を購入してください。
1. `COUNTRY_CODE`を居住地の[2文字の国コード](https://www.iban.com/country-codes)に置き換えて、購入可能な番号をリストアップします。
   ```sh
   nexmo number:search COUNTRY_CODE
   ```
2. 番号のいずれかを購入します。
   ```sh
   nexmo number:buy 447700900001
   ```
音声APIアプリケーションを作成する
------------------
CLIを使用して、構築中のアプリケーションの設定の詳細を含む音声APIアプリケーションを作成します。これには、次が含まれます。
* あなたのVonage仮想番号
* 次の[Webhook](/concepts/guides/webhooks)エンドポイント： 
  * **応答Webhook** ：Vonage番号が着信コールを受信したときに、Vonageがリクエストするエンドポイント
  * **イベントWebhook** ：Vonageが通話状態の変更やエラーをアプリケーションに通知するために使用するエンドポイント

> **注** ：Webhookは、パブリックインターネット上でアクセスできる必要があります。テストのために[ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)を使用することを検討してください。`ngrok`を使用する場合は、`ngrok http 3000`を使用してポート3000で実行し、ngrokが提供する一時的なURLを取得し、URLが変更されないようにこのチュートリアルの期間中は実行したままにしておきます。
以下のコマンドの`example.com`を、あなた自身の公開URLまたは`ngrok`ホスト名で置き換えてください。アプリケーションディレクトリのルートで実行してください。これにより、アプリケーションIDが返され、`private.key`というファイルに認証の詳細がダウンロードされます。
```sh
nexmo app:create "Call Transcription" https://example.com/webhooks/answer https://example.com/webhooks/events --keyfile private.key
```
アプリケーションIDと`private.key`ファイルの場所をメモしておきます。これらは、後のステップで必要となります。
Vonage番号をリンクする
--------------
次のCLIコマンドを実行し、アプリケーションIDを使用してVonage番号と音声APIアプリケーションをリンクします。
```sh
nexmo link:app VONAGE_NUMBER APPLICATION_ID
```
AWSを設定する
--------
文字起こしは、[Amazon Web Services （AWS）](https://aws.amazon.com/)の一部であるAmazon Transcribe APIによって実行されます。Transcribe APIを使用するには、AWSアカウントが必要です。まだAWSアカウントを取得していない場合は、次のステップでAWSアカウントの作成方法が学べます。
また、次のことが必要です。
* 2つの新しい[S3](https://aws.amazon.com/s3/)バケットを作成して、生の通話音声と生成された文字起こしを保存します。
* [CloudWatchイベント](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/WhatIsCloudWatchEvents.html)を設定します。これにより、文字起こしが完了すると、サーバーレス[Lambda関数](https://aws.amazon.com/lambda/)がトリガーされます。
* 文字起こしがダウンロードできるようになったことをアプリケーションに通知するLambda関数を作成してデプロイします。
### AWSアカウントを作成する
[管理者ユーザーでAWSアカウントを作成します](https://docs.aws.amazon.com/transcribe/latest/dg/setting-up-asc.html)。後でシークレットを取得できないため、AWSキーとシークレットをメモしておきましょう。
### AWS CLIをインストールする
[このガイド](https://docs.aws.amazon.com/transcribe/latest/dg/setup-asc-awscli.html)を使用して、AWS CLIをインストールして設定します。
### S3ストレージバケットを作成する
以下のAWS CLIコマンドを使用して、選択したリージョン（この例では、`us-east-1`）に2つの新しいS3バケットを作成します。1つは生の通話音声用、もう1つは生成された文字起こし用です。これらはS3全体で一意の名前を付ける必要があります。他と同じにならない名前を作成してください。

> **重要** ：選択した`region`がAmazon Transcribe APIとCloudWatchイベントの両方を[サポート](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/)していることを確認してください。
```sh
aws s3 mb s3://your-audio-bucket-name --region us-east-1
aws s3 mb s3://your-transcription-bucket-name --region us-east-1 
```
アプリケーションを構成する
-------------
### コードを入手する
このプロジェクトのコードは[GitHub](https://github.com/Nexmo/amazon-transcribe-call)にあり、[Express](https://expressjs.com/) Webアプリケーションフレームワーク使用してnode.jsで記述されています。これは、ユーザー自身の要件に適合できる実践的な例です。
リポジトリのクローンを作成するか、リポジトリをローカルマシンの新しいディレクトリにダウンロードします。
### 依存関係をインストールする
アプリケーションディレクトリで`npm install`を実行し、必要な依存関係をインストールします。
  - aws-sdk：AWS node.js SDK
  - body-parser：node.js body-parserミドルウェア
  - express：node.js用のWebアプリケーションフレームワーク
  - nexmo：VonageサーバーSDK
  - serverless：Lambda関数をデプロイする
  - shortid：通話録音用のランダムなファイル名を生成
### 環境変数を設定する
ダウンロードした`private.key`ファイルをアプリケーションディレクトリのルートに移動します。
次に、`example.env`を`.env`にコピーし、以下の設定を行います。
設定 ｜ 説明
--｜--⏎`VONAGE_APPLICATION_ID`｜ 先ほど作成したVonage音声アプリケーションID
`VONAGE_PRIVATE_KEY_FILE`｜ 例：`private.key`
`OTHER_PHONE_NUMBER`｜ 会話を作成するために呼び出すことができる別の電話番号
`AWS_KEY`｜ AWSキー
`AWS_SECRET`｜ AWSシークレット
`AWS_REGION`｜ AWSリージョン（例：`us-east-1`）
`S3_PATH`｜`AWS_REGION`を含むS3バケットストレージへのパス（例：`https://s3-us-east-1.amazonaws.com`）
`S3_AUDIO_BUCKET_NAME`｜ 生の通話音声ファイルを格納するS3バケット
`S3_TRANSCRIPTS_BUCKET_NAME` ｜ 通話音声の書き起こしを格納するS3バケット
### Lambda関数をデプロイする
AWS Lambdaは、イベントに応じてコードを実行し、コードが必要とするコンピューティングリソースを自動的に管理するサービスです。これは「サーバーレス」関数の一例であり、「FAAS（Function as a Service）」とも呼ばれています。このチュートリアルでは、[サーバーレスフレームワーク](https://serverless.com/)を使用してLambda関数をテンプレート化してデプロイします。
まず、`serverless`ノードパッケージがインストールされていることを確認します。
```sh
serverless -v
```
バージョン番号が表示されれば問題ありません。表示されなければ、`npm`を使用して、`serverless`をインストールします。
```sh
npm install -g serverless
```
`transcribeReadyService`フォルダには、Lambda関数を定義する`handler.js`ファイルが含まれています。このLambdaは、CloudWatchが書き起こしジョブ完了イベントを受信すると、`POST`リクエストを`/webhooks/transcription`エンドポイントに行います。
`options.host`プロパティを公開サーバーのホスト名と一致するように変更します。
```javascript
const https = require('https');
exports.transcribeJobStateChanged = (event, context) => {
  let body = '';
  const options = {
    host: 'myapp.ngrok.io', // <-- replace this
    path: '/webhooks/transcription',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    }
  };
  const req = https.request(options, (res) => {
    res.on('data', (chunk) => {
      body += chunk;
    });
    context.succeed(body);
  });
  req.write(JSON.stringify(event));
  req.end();
};
```
CloudWatchイベントハンドラは、付属の`serverless.yml`ファイルで定義されています。`provider.region`がAWSのリージョンと一致していることを確認してください。
```yaml
service: vonage-transcribe
provider:
  name: aws
  runtime: nodejs10.x
  region: us-east-1 # <-- Specify your region
functions:
  transcribeJobStateChanged:
    handler: handler.transcribeJobStateChanged
    events:
      - cloudwatchEvent:
          event:
            source:
              - "aws.transcribe"
            detail-type:
              - "Transcribe Job State Change"
            detail:
              TranscriptionJobStatus:
                - COMPLETED
                - FAILED
```
`serverless`を使用して、このLambdaをデプロイします。
```sh
cd transcribeReadyService
serverless deploy
```

> **注** ：この処理は、完了するまでに数分かかります。何かをアップデートする必要がある場合は、以降のデプロイを高速化する必要があります。
コードを調べる
-------
メインアプリケーションコードは`index.js`ファイルにあります。
アプリケーションディレクトリには、以下のサブフォルダも含まれています。
  - recordings`：生の音声通話のmp3ファイルが含まれます。次を使用して一意のファイル名が付けられています： `shortid
  - transcripts：書き起こしジョブが完了したときにS3からダウンロードした、完成した書き起こしが含まれます
  - transcribeReadyService：Lambda関数とCloudWatchイベント定義YAMLが含まれます
### NodeサーバーSDKを使用する
`index.js`にある次のコードは、NodeサーバーSDKをインスタンス化します。これは、後で通話記録を保存するときに使用します。
```javascript
const Nexmo = require("nexmo")
const nexmo = new Nexmo({
  apiKey: "not_used", // Voice applications don't use API key or secret
  apiSecret: "not_used",
  applicationId: process.env.VONAGE_APPLICATION_ID,
  privateKey: __dirname + "/" + process.env.VONAGE_PRIVATE_KEY_FILE
})
```
### AWS SDKを使用する
以下のコードはAWS SDKを認証し、新しい`TranscribeService`と`S3`インスタンスを作成します。
```javascript
const AWS = require("aws-sdk")
AWS.config.update({
  region: process.env.AWS_REGION,
  accessKeyId: process.env.AWS_KEY,
  secretAccessKey: process.env.AWS_SECRET
})
const transcribeService = new AWS.TranscribeService()
const S3 = new AWS.S3()
```
### 応答Webhookを定義する
`/webhooks/answer`エンドポイントは、Vonageに通話の処理方法を指示する[Nexmo Call Control Object (NCCO)](/voice/voice-api/ncco-reference)を使用して着信コールに応答します。
これは、2つの入力`channels`があることを指定して、他の個人番号を呼び出すために`connect`アクションを使用し、通話音声を録音するために`record`アクションを使用します。`record`アクションは、コールが完了すると`POST`リクエストを`/webhooks/recording`エンドポイントにトリガーします。
```javascript
app.get('/webhooks/answer', (req, res) => {
  return res.json([{
      action: 'talk',
      text: 'Thanks for calling, we will connect you now'
    },
    {
      action: 'connect',
      endpoint: [{
        type: 'phone',
        number: process.env.OTHER_PHONE_NUMBER
      }]
    },
    {
      action: 'record',
      eventUrl: [`${req.protocol}://${req.get('host')}/webhooks/recording`],
      split: 'conversation',
      channels: 2,
      format: 'mp3'
    }
  ])
})
```
### イベントWebhookを定義する
`/webhooks/events`エンドポイントは、コールイベント（Vonageから`POST`リクエストとして送信されたもの）をログに記録し、コンソールに表示します。
```javascript
app.post('/webhooks/events', (req, res) => {
  console.log(req.body)
  return res.status(204).send("")
})
```
### 録音を保存する
`/webhooks/recording`エンドポイントは、通話録音を`recordings`フォルダに保存し、`uploadFile()`を呼び出して通話音声をS3にアップロードします。
```javascript
app.post('/webhooks/recording', (req, res) => {
  let audioFileName = `vonage-${shortid.generate()}.mp3`
  let audioFileLocalPath = `./recordings/${audioFileName}`
  nexmo.files.save(req.body.recording_url, audioFileLocalPath, (err, res) => {
    if (err) {
      console.log("Could not save audio file")
      console.error(err)
    }
    else {
      uploadFile(audioFileLocalPath, audioFileName)
    }
  })
  return res.status(204).send("")
})
```
### 録音をS3にアップロードする
`uploadFile()`関数は、実際にS3へのアップロードを実行し、書き起こし処理を開始します。
```javascript
function uploadFile(localPath, fileName) {
  fs.readFile(localPath, (err, data) => {
    if (err) { throw err }
    const uploadParams = {
      Bucket: process.env.S3_AUDIO_BUCKET_NAME,
      Key: fileName,
      Body: data
    }
    const putObjectPromise = S3.putObject(uploadParams).promise()
    putObjectPromise.then((data) => {
      console.log(`${fileName} uploaded to ${process.env.S3_AUDIO_BUCKET_NAME} bucket`)
      transcribeRecording({
        audioFileUri: process.env.S3_PATH + '/' + process.env.S3_AUDIO_BUCKET_NAME + '/' + fileName,
        transcriptFileName: `transcript-${fileName}`
      })
    })
  })
}
```
### 書き起こしジョブを送信する
`transcribeRecording()`関数は、Amazon Transcribe APIによる書き起こしのために音声ファイルを送信します。
`startTranscriptionJob()`のパラメーターで、`channelIdentification`が`true`に設定されていることに注意してください。これにより、各チャネルを個別に書き起こすようAmazon Transcribe APIに指示します。
パラメーターには、完成した書き起こしを指定したS3バケットに保存するための`OutputBucketName`も含まれています。
```javascript
function transcribeRecording(params) {
  const jobParams = {
    LanguageCode: 'en-GB',
    Media: {
      MediaFileUri: params.audioFileUri
    },
    MediaFormat: 'mp3',
    OutputBucketName: process.env.S3_TRANSCRIPTS_BUCKET_NAME,
    Settings: {
      ChannelIdentification: true
    },
    TranscriptionJobName: params.transcriptFileName
  }
  console.log(`Submitting file ${jobParams.Media.MediaFileUri} for transcription...`)
  const startTranscriptionJobPromise = transcribeService.startTranscriptionJob(jobParams).promise()
  startTranscriptionJobPromise.then((data) => {
    console.log(`Started transcription job ${data.TranscriptionJob.TranscriptionJobName}...`)
  })
}
```
### 書き起こしジョブを完了する
書き起こしジョブが完了したことをCloudWatchが認識すると、Lambdaをトリガーします。Lambda関数は、`POST`リクエストを`/webhooks/transcription`エンドポイントに作成し、書き起こし結果を出力します。
```javascript
app.post('/webhooks/transcription', (req, res) => {
  const jobname = req.body.detail.TranscriptionJobName
  const jobstatus = req.body.detail.TranscriptionJobStatus
  if (jobstatus === "FAILED") {
    console.log(`Error processing job ${jobname}`)
  } else {
    console.log(`${jobname} job successful`)
    const params = {
      TranscriptionJobName: jobname
    }
    console.log(`Getting transcription job: ${params.TranscriptionJobName}`)
    transcribeService.getTranscriptionJob(params, (err, data) => {
      if (err) {
        console.log(err, err.stack)
      }
      else {
        console.log("Retrieved transcript")
        downloadFile(data.TranscriptionJob.TranscriptionJobName + '.json')
      }
    })
  }
  return res.status(200).send("")
})
```
### 完成した書き起こしをダウンロードする
`downloadFile`関数は、完成した書き起こしファイルをS3バケットからローカルの`transcripts`フォルダにダウンロードします。ファイルの内容を解析する前に、ファイルが利用可能であることを確認する必要があるため、`displayResults`関数を呼び出す前に、`S3.getObject`の呼び出しをラップするようにします。
```javascript
function downloadFile(key) {
  console.log(`downloading ${key}`)
  const filePath = `./transcripts/${key}`
  const params = {
    Bucket: process.env.S3_TRANSCRIPTS_BUCKET_NAME,
    Key: key
  }
  const getObjectPromise = S3.getObject(params).promise()
  getObjectPromise.then((data) => {
    fs.writeFileSync(filePath, data.Body.toString())
    console.log(`Transcript: ${filePath} has been created.`)
    let transcriptJson = JSON.parse(fs.readFileSync(filePath, 'utf-8'))
    displayResults(transcriptJson)
  })
}
```
### 書き起こしを解析する
結果として得られる書き起こしのJSONファイルは、非常に複雑な構造をしています。ファイル（`results.transcripts`）の先頭には、通話全体の書き起こしがあり、`results.channel_labels`で、各チャネルの書き起こしの絞り込みができます。
```json
{
	"jobName": "transcript-vonage-9Eeor0OhH.mp3",
	"accountId": "99999999999",
	"results": {
		"transcripts": [{
			"transcript": "This is a test on my mobile phone. This is a test on my landline."
		}],
		"channel_labels": {
			"channels": [{
				"channel_label": "ch_0",
				"items": [{
					"start_time": "1.94",
					"end_time": "2.14",
					"alternatives": [{
						"confidence": "1.0000",
						"content": "This"
					}],
					"type": "pronunciation"
				}, {
					"start_time": "2.14",
					"end_time": "2.28",
					"alternatives": [{
						"confidence": "1.0000",
						"content": "is"
					}],
					"type": "pronunciation"
				}, 
        ...
```
書き起こしがダウンロードされた後に呼び出される`displayResults()`関数は、各チャネルの書き起こしを取得し、コンソールに表示します。
```javascript
function displayResults(transcriptJson) {
  const channels = transcriptJson.results.channel_labels.channels
  channels.forEach((channel) => {
    console.log(`*** Channel: ${channel.channel_label}`)
    let words = ''
    channel.items.forEach((item) => {
      words += item.alternatives[0].content + ' '
    })
    console.log(words)
  })
}
```
試行手順
----
### アプリケーションを実行する
1. アプリケーションのルートディレクトリで以下のコマンドを実行してアプリケーションを起動します。
   ```sh
   node index.js
   ```
2. 1台目の電話からVonage番号に電話します。電話に出たら、2台目の電話が鳴ります。電話に応答してください。
3. それぞれの受話器でいくつかの言葉を言ってから、両方の電話を切ります。
4. 書き起こしジョブが処理されている様子をコンソールで確認します（ **注** ： これには数分かかることがあります）。
```sh
{ end_time: '2019-08-13T11:33:10.000Z',
  uuid: 'df52c28f-d167-5319-a7e6-bc9d9c2b23d2',
  network: 'GB-FIXED',
  duration: '23',
  start_time: '2019-08-13T11:32:47.000Z',
  rate: '0.01200000',
  price: '0.00460000',
  from: '447700900002',
  to: '447700900001',
  conversation_uuid: 'CON-e01f1887-8a7e-4c6d-82ef-fd9280190e01',
  status: 'completed',
  direction: 'outbound',
  timestamp: '2019-08-13T11:33:09.380Z' }
recording...
{ start_time: '2019-08-13T11:32:47Z',
  recording_url:
   'https://api.nexmo.com/v1/files/d768cbb4-d68c-4ad0-8984-8222d2ccb6c5',
  size: 178830,
  recording_uuid: '01175e1e-f778-4b2a-aa7e-18b6fb493edf',
  end_time: '2019-08-13T11:33:10Z',
  conversation_uuid: 'CON-e01f1887-8e7e-4c6d-82ef-fd8950190e01',
  timestamp: '2019-08-13T11:33:10.449Z' }
vonage-srWr3XOmP.mp3 uploaded to vonage-transcription-audio bucket
Submitting file https://s3-us-east-1.amazonaws.com/vonage-transcription-audio/vonage-srWr3XOmP.mp3 for transcription...
Started transcription job transcript-vonage-srWr3XOmP.mp3...
transcript-vonage-srWr3XOmP.mp3 job successful
Getting transcription job: transcript-vonage-srWr3XOmP.mp3
Retrieved transcript
downloading transcript-vonage-srWr3XOmP.mp3.json
Transcript: ./transcripts/transcript-vonage-srWr3XOmP.mp3.json has been created.
*** Channel: ch_0
Hello this is channel zero .
*** Channel: ch_1
Hello back this is channel one . 
```
### 発信者を追加する
2つ以上の番号がある場合は、通話相手を追加して会話が可能です。`connect`アクションを`/webhooks/answer` NCCOにそれぞれ作成し、`record`アクションのチャネル数をそれに応じて増やすだけです。
関連情報

---

詳細については、次のリソースを参照してください。

* 音声用 API 
  * [音声API 通話録音ガイド](/voice/voice-api/guides/recording)
  * [「通話録音」コードスニペット](/voice/voice-api/code-snippets/record-a-call)
  * [音声用APIの関連情報](/api/voice)
  * [NCCO の関連情報](/voice/voice-api/ncco-reference)

* AWS 
  * [AWS node.js SDKリファレンス](https://aws.amazon.com/sdk-for-node-js/)
  * [Amazon Transcribe API機能](https://aws.amazon.com/transcribe/)
  * [Amazon Transcribe APIリファレンス](https://docs.aws.amazon.com/transcribe/latest/dg/API_Reference.html)
  * [Amazon S3ドキュメント](https://docs.aws.amazon.com/s3/)
  * [Amazon CloudWatchドキュメント](https://docs.aws.amazon.com/cloudwatch/)
  * [Amazon Lambda](https://docs.aws.amazon.com/lambda/)

