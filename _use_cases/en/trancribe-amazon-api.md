---
title: Transcribe a recorded call with Amazon Transcribe
products: voice/voice-api
description: "This tutorial shows you how to use the Amazon Transcribe API to transcribe a phone conversation recorded with the Nexmo Voice API."
languages:
    - Node
---
# Transcribe a Recorded Call with Amazon Transcribe

In this tutorial, you will learn how to record a Voice API call and transcribe it using the Amazon Transcribe API.

![Application Overview](/assets/images/amazon-transcribe-vapi-tutorial.png "Application Overview")

## Prerequisites
You need at least two personal phone numbers:

* One to call your [Nexmo virtual number](/numbers/overview) and initiate the conference call.
* Another that your Nexmo number can call to include in the conference call.

If you have access to more than two numbers you can include them as participants in the conference call too. See [adding more callers](#adding-more-callers).

You also need a Nexmo account. [Sign up here](https://dashboard.nexmo.com/sign-up) if you don't already have one.

## Install and configure Nexmo CLI
This tutorial uses the [Nexmo command line tool](https://github.com/Nexmo/nexmo-cli), so ensure that it is installed and configured before proceeding.

Run the following `npm` command at a terminal prompt to install the CLI tool:

```sh
npm install -g nexmo-cli
```

Configure the CLI tool with your `NEXMO_API_KEY` and `NEXMO_API_SECRET`, which you will find in the Developer Dashboard:

```sh
nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```

## Purchase a Nexmo number
If you don't already have one, purchase a Nexmo number to receive inbound calls.

1. List the numbers available for purchase, replacing `COUNTRY_CODE` with your location's [two-character country code](https://www.iban.com/country-codes):

    ```sh
    nexmo number:search COUNTRY_CODE
    ```
2. Purchase one of the numbers:

    ```sh
    nexmo number:buy 447700900001
    ```

## Create a Voice API Application

Use the CLI to create a Voice API Application that contains configuration details for the application you are building. These include:

* Your Nexmo virtual number
* The following [webhook](/concepts/guides/webhooks) endpoints:
  * **Answer webhook**: The endpoint that Nexmo makes a request to when your Nexmo number receives an inbound call
  * **Event webhook**: The endpoint that Nexmo uses to notify your application about call state changes or errors

> **Note**: Your webhooks must be accessible over the public Internet. Consider using [ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) for testing purposes. If you do use `ngrok`, run it now on port 3000 using `ngrok http 3000` to get the temporary URLs that ngrok provides and leave it running for the duration of this tutorial to prevent the URLs from changing.

Replace `example.com` in the following command with your own public-facing URL or `ngrok` host name. Run it in the root of your application directory. This returns an application ID and downloads the authentication details in a file called `private.key`.

```sh
nexmo app:create "Call Transcription" https://example.com/webhooks/answer https://example.com/webhooks/events --keyfile private.key
```

Make a note of the Application ID and the location of the `private.key` file. You will need these in later steps.

## Link your Nexmo number

Run the following CLI command to link your Voice API Application with your Nexmo number using the Application ID:

```sh
nexmo link:app NEXMO_NUMBER APPLICATION_ID
```

## Configure AWS

The transcription is performed by the Amazon Transcribe API, which is part of [Amazon Web Services (AWS)](https://aws.amazon.com/). You need an AWS account to use the Transcribe API. If you haven't already got an AWS account, you'll learn how to create one in the next step.

You will also need to:

* Create two new [S3](https://aws.amazon.com/s3/) buckets to store the raw call audio and generated transcripts
* Configure a [CloudWatch event](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/WhatIsCloudWatchEvents.html). This triggers a serverless [Lambda function](https://aws.amazon.com/lambda/) when your transcription job is complete.
* Create and deploy the Lambda function that notifies your application that the transcript is available for download. 

### Create an AWS account

[Create an AWS account with an Administrator user](https://docs.aws.amazon.com/transcribe/latest/dg/setting-up-asc.html). Make a note of your AWS key and secret, because you cannot retrieve the secret later on.

### Install the AWS CLI
Install and configure the AWS CLI using [this guide](https://docs.aws.amazon.com/transcribe/latest/dg/setup-asc-awscli.html).

### Create S3 storage buckets

Use the following AWS CLI commands to create two new S3 buckets in your chosen region (`us-east-1` in this example), one for the raw call audio and the other for the generated transcripts. These must be uniquely named across S3, so be creative!

> **Important**: Ensure that the `region` you choose [supports](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/) both the Amazon Transcribe API and CloudWatch Events:

```sh
aws s3 mb s3://your-audio-bucket-name --region us-east-1
aws s3 mb s3://your-transcription-bucket-name --region us-east-1 
```

## Configure the application

### Get the code

The code for this project is [on GitHub](https://github.com/Nexmo/amazon-transcribe-call). It is written in node.js  using the [express](https://expressjs.com/) web application framework. It is a working example that you can adapt to suit your own requirements.

Either clone or download the repository to your local machine, in a new directory.

### Install dependencies

Run `npm install` in the application directory to install the required dependencies:

* `aws-sdk`: The AWS node.js SDK
* `body-parser`: node.js body-parsing middleware
* `express`: A web application framework for node.js
* `nexmo`: The REST API client library for node.js
* `serverless`: To deploy your Lambda function
* `shortid`: Generates random file names for call recordings

### Configure environment variables

Move your downloaded `private.key` file into the root of your application directory.

Then, copy `example.env` to `.env` and configure the following settings:

Setting | Description
--|--
`NEXMO_APPLICATION_ID` | The Nexmo Voice Application ID you created earlier
`NEXMO_PRIVATE_KEY_FILE` | For example: `private.key`
`OTHER_PHONE_NUMBER` | Another phone number you can call to create a conversation
`AWS_KEY` | Your AWS key
`AWS_SECRET` | Your AWS secret
`AWS_REGION` | Your AWS region, e.g. `us-east-1`
`S3_PATH` | Your path to S3 bucket storage, which should include the `AWS_REGION`, e.g. `https://s3-us-east-1.amazonaws.com`
`S3_AUDIO_BUCKET_NAME` | The S3 bucket which will contain the raw call audio files
`S3_TRANSCRIPTS_BUCKET_NAME` | The S3 bucket which will contain transcripts of the call audio

### Deploy your Lambda function

AWS Lambda is a service that runs code in response to events and automatically manages the computing resources that code requires. It is an example of a "serverless" function, also known as "Function as a Service" (FAAS). In this tutorial, you will use the [serverless framework](https://serverless.com/) to template and deploy your Lambda function.

First, ensure that the `serverless` node package is installed:

```sh
serverless -v
```

If it displays the version number, you are good to go. If not, install `serverless` using `npm`:

```sh
npm install -g serverless
```

The `transcribeReadyService` folder contains a `handler.js` file which defines the Lambda function. This lambda makes a `POST` request to the `/webhooks/transcription` endpoint when CloudWatch receives a transcription job complete event.

Change the `options.host` property to match your public-facing server's host name:

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

The CloudWatch event handler is defined in the accompanying `serverless.yml` file. Make sure that the `provider.region` matches your AWS region:

```yaml
service: nexmo-transcribe

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

Deploy this Lambda using `serverless`:

```sh
cd transcribeReadyService
serverless deploy
```

> **Note**: This process takes several minutes to complete. If you need to update anything, subsequent deployments should be faster.

## Examine the code

The main application code is in the `index.js` file.

The application directory also contains the following sub folders:

* `recordings`: Will contain the raw audio call mp3 files, uniquely named using `shortid`
* `transcripts`: Contains the completed transcripts, downloaded from S3 when the transcription jobs complete
* `transcribeReadyService`: Contains the Lambda function and CloudWatch event definition YAML

### Using the Nexmo REST API client library

The following code in `index.js` instantiates the Nexmo REST API client library, which you will use to save the call recordings later on:

```javascript
const Nexmo = require("nexmo")

const nexmo = new Nexmo({
  apiKey: "not_used", // Voice applications don't use API key or secret
  apiSecret: "not_used",
  applicationId: process.env.NEXMO_APPLICATION_ID,
  privateKey: __dirname + "/" + process.env.NEXMO_PRIVATE_KEY_FILE
})
```

### Using the AWS SDK

The following code authenticates the AWS SDK and creates new `TranscribeService` and `S3` instances:

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

### Defining the answer webhook

The `/webhooks/answer` endpoint responds to an incoming call with a [Nexmo Call Control Object (NCCO)](/voice/voice-api/ncco-reference) that tells Nexmo how to handle the call.

It uses a `connect` action to call your other personal number and a `record` action to record the call audio, specifying that there are two input `channels`. The `record` action triggers a `POST` request to the `/webhooks/recording` endpoint when the call completes:

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

### Defining the events webhook

The `/webhooks/events` endpoint logs call events (submitted by Nexmo as a `POST` request) and displays them to the console:

```javascript
app.post('/webhooks/events', (req, res) => {
  console.log(req.body)
  return res.status(204).send("")
})
```

### Saving the recording

The `/webhooks/recording` endpoint saves the call recording to the `recordings` folder and calls `uploadFile()` to upload the call audio to S3:

```javascript
app.post('/webhooks/recording', (req, res) => {

  let audioFileName = `nexmo-${shortid.generate()}.mp3`
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

### Uploading the recording to S3

The `uploadFile()` function performs the actual upload to S3 and starts the transcription process:

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

### Submitting the transcription job

The `transcribeRecording()` function submits the audio file for transcription by the Amazon Transcribe API.

Note in the parameters to `startTranscriptionJob()` that `channelIdentification` is set to `true`. This tells the Amazon Transcribe API to transcribe each channel separately.

The parameters also include `OutputBucketName` to store the completed transcript in the specified S3 bucket.

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

### Transcription job complete

When CloudWatch learns that the transcription job has completed, it triggers our Lambda. The Lambda function makes a `POST` request to the `/webhooks/transcription` endpoint with the results of the transcription:

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

### Downloading the completed transcript

The `downloadFile` function downloads the completed transcript file from the S3 bucket to the local `transcripts` folder. We want to ensure that the file is available before we attempt to parse its contents, so we wrap the call to `S3.getObject` in a promise before calling the `displayResults` function:

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

### Parsing the transcript

The resulting transcript JSON file has quite a complex structure. At the top of the file (`results.transcripts`) is the transcription of all the entire call and in `results.channel_labels` you can drill into the transcription for each channel:

```json
{
	"jobName": "transcript-nexmo-9Eeor0OhH.mp3",
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

The `displayResults()` function that is called after the transcript has been downloaded retrieves the transcription for each channel and displays it in the console:


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

## Try it out

### Running the application

1. Launch your application by running the following command in the application's root directory:

    ```sh
    node index.js
    ```

2. Call your Nexmo number from one phone. When the call is answered, your second phone should ring. Answer it.

3. Say a few words into each handset and then disconnect both.

4. Watch the transcription job being processed in your console. (**Note**: this can take several minutes):

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
nexmo-srWr3XOmP.mp3 uploaded to nexmo-transcription-audio bucket
Submitting file https://s3-us-east-1.amazonaws.com/nexmo-transcription-audio/nexmo-srWr3XOmP.mp3 for transcription...
Started transcription job transcript-nexmo-srWr3XOmP.mp3...
transcript-nexmo-srWr3XOmP.mp3 job successful
Getting transcription job: transcript-nexmo-srWr3XOmP.mp3
Retrieved transcript
downloading transcript-nexmo-srWr3XOmP.mp3.json
Transcript: ./transcripts/transcript-nexmo-srWr3XOmP.mp3.json has been created.
*** Channel: ch_0
Hello this is channel zero .
*** Channel: ch_1
Hello back this is channel one . 
```

### Adding more callers
If you have more than two numbers, you can add more callers to the conversation. Simply create a `connect` action for each in the `/webhooks/answer` NCCO and increase the number of channels in the `record` action accordingly.

## Further reading

The following resources will help you learn more:

* Nexmo Voice API
  * [Voice API call recording guide](/voice/voice-api/guides/recording)
  * ["Record a call" code snippet](/voice/voice-api/code-snippets/record-a-call)
  * [Voice API reference](/api/voice)
  * [NCCO reference](/voice/voice-api/ncco-reference)
* AWS
  * [AWS node.js SDK reference](https://aws.amazon.com/sdk-for-node-js/)
  * [Amazon Transcribe API features](https://aws.amazon.com/transcribe/)
  * [Amazon Transcribe API reference](https://docs.aws.amazon.com/transcribe/latest/dg/API_Reference.html)
  * [Amazon S3 documentation](https://docs.aws.amazon.com/s3/)
  * [Amazon CloudWatch documentation](https://docs.aws.amazon.com/cloudwatch/)
  * [Amazon Lambda](https://docs.aws.amazon.com/lambda/)