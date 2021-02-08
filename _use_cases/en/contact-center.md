---
title: Contact Center Augmentation
products: voice/voice-api
description: "This tutorial shows you how to add programmable assistance to your contact center"
languages:
    - Node
navigation_weight: 5    
---

# Contact Center Augmentation

In this tutorial, you will implement the following contact center scenario:

* The user calls your Vonage number,
* The initial greeting is read out, and the user chooses an option from the menu provided,
* The user is connected to an agent,
* After the agent closes the call, the user is transferred to a customer satisfaction survey.

For a better understanding of the flow, see [Call Flow](/voice/voice-api/guides/call-flow#switching-between-scripted-call-and-live-conversation) guide.

## Prerequisites

To complete this tutorial, you need:

* A [Vonage account](https://dashboard.nexmo.com/sign-up),
* The [Nexmo CLI](/application/nexmo-cli) installed and set up,
* [ngrok](https://ngrok.com/) - to make your development web server accessible to Vonage's servers over the Internet,
* [Node.JS](https://nodejs.org/en/download/) installed,
* two phone calling devices with PSTN numbers assigned - "user phone" and "agent phone", for example, two mobile phones or an application with calling capability like [Vonage Business](https://www.vonage.com/unified-communications/features) app.

## Install the dependencies

Install the [express](https://expressjs.com) web application framework and [body-parser](https://www.npmjs.com/package/body-parser) packages:

```sh
$ npm install express body-parser
```

## Purchase a Vonage number

If you don't already have one, buy a Vonage number to receive inbound calls.

First, list the numbers available in your country (replace `GB` with your two-character [country code](https://www.iban.com/country-codes)):

```sh
nexmo number:search GB
```

Purchase one of the available numbers. For example, to purchase the number `447700900001`, execute the following command:

```sh
nexmo number:buy 447700900001
```

## Create a Voice API application

Use the CLI to create a Voice API application with the webhooks that will be responsible for answering a call on your Vonage number (`/webhooks/answer`) and logging call events (`/webhooks/events`), respectively.

These webhooks need to be accessible by Vonage's servers, so in this tutorial you will use `ngrok` to expose your local development environment to the public Internet. [This article](/tools/ngrok) explains how to install and run `ngrok`.

Run `ngrok` using the following command:

```sh
ngrok http 3000
```

Make a note of the temporary host name that `ngrok` provides and use it in place of `example.com` in the following command:

```sh
nexmo app:create "CCApp" --capabilities=voice --voice-event-url=https://example.com/webhooks/event --voice-answer-url=https://example.com/webhooks/answer --keyfile=private.key
```

The command returns an application ID (which you should make a note of) and your private key information (which you can safely ignore for the purposes of this tutorial).

## Link your number

You need to link your Vonage number to the Voice API application that you created. Use the following command:

```sh
nexmo link:app VONAGE_NUMBER VONAGE_APPLICATION_ID
```

You're now ready to write your application code.


## Write your answer webhook

When Vonage receives an inbound call on your virtual number, it will make a request to your `/webhooks/answer` route. This route should accept an HTTP `GET` request and return a [Nexmo Call Control Object (NCCO)](/voice/voice-api/ncco-reference) that tells Vonage how to handle the call.

Your NCCO should use the `talk` action to greet the caller, and the `input` action to get user [DTMF input](/voice/voice-api/guides/dtmf#collecting-input) (key pressed):

```js
const app = require('express')()
const bodyParser = require('body-parser')
const https = require('https')
const Vonage = require('@vonage/server-sdk')

const vonage = new Vonage({
  apiKey: VONAGE_API_KEY,
  apiSecret: VONAGE_API_SECRET,
  applicationId: VONAGE_APPLICATION_ID,
  privateKey: VONAGE_APPLICATION_PRIVATE_KEY_PATH
})

app.use(bodyParser.json())

app.get('/webhooks/answer', (request, response) => {
  console.log('answer: ', request.query)

  const ncco = [{
    action: 'talk',
    text: 'Thank you for calling Example Inc.! Press 1 to talk to the sales department, press 2 to get technical support.',
    bargeIn: true
  },
    {
      action: 'input',
      eventUrl: [
        `${request.protocol}://${request.get('host')}/webhooks/input`],
      type: [ 'dtmf' ],
      dtmf: {
        maxDigits: 1
      }
    }
  ]

  response.json(ncco)
})
```

## Write your event webhook

Implement a webhook that captures call events so that you can observe the lifecycle of the call in the console:

```js
app.post('/webhooks/event', (request, response) => {
  console.log('event:', request.body)
  response.sendStatus(200);
})
```

Vonage makes a `POST` request to this endpoint every time the call status changes.

## Write your input webhook

DTMF input results will be sent to the specific URL you set in the `input` action: `/webhooks/input`. Add a webhook to process the result and add some user interaction.

In case of a successful recognition, the request payload will look as follows:

```json
{
  "speech": {
  },
  "dtmf": {
    "digits": "1",
    "timed_out": true
  },
  "from": USER_NUMBER,
  "to": VONAGE_NUMBER,
  "uuid": "abfd679701d7f810a0a9a44f8e298b33",
  "conversation_uuid": "CON-64e6c8ef-91a9-4a21-b664-b00a1f41340f",
  "timestamp": "2020-04-17T17:31:53.638Z"
}
```

Retrieve the user's input from the `dtmf.digits` array to determine the options they selected. To connect both user and agent of the corresponding department, you'll create an outbound call to the agent endpoint. You can use a test phone number in this sample for simplicity, for example, your mobile number. In real life, the endpoint might be a PSTN number or [SIP endpoint](/voice/sip/concepts/programmable-sip) to connect your existing PBX or contact center. It could also be a WebRTC client if you are developing your contact center solution from scratch - the Vonage [Client SDK](/client-sdk/overview) provides everything you need to implement your own Contact Center agent application.

Finally, both calls (legs) should be moved to one conference room (named [conversation](/voice/voice-api/ncco-reference#conversation)). To do that, you should use `conversation` action with the same `name` both for the user call (the inbound leg) and the agent leg (the outbound call). To generate the conversation name, you may use any unique ID generation method, for example, using the actual timestamp.

> As an option, you may use `connect` action in the NCCO to connect the user to the agent. The difference is that with `connect`, the call will be immediately completed when any of the call participants hang up, and there is only one leg left. So, it would be impossible to transfer the user to the survey after the call; if that's not needed in your case, `connect` is a bit more handy option. If you want the user still connected after the agent completes the call, choose `conversation` as shown in the example below.

Add the code to handle the input callback:

```js
app.post('/webhooks/input', (request, response) => {
  console.log('input:', request.body)

  // generating unique conversation name
  var conversationName = 'conversation_' + Date.now()

  console.log('conversationName: ', conversationName)

  // selecting agent/department endpoint
  var departmentId = request.body.dtmf.digits
  var department = ''
  var departmentNumber = ''

  switch (departmentId) {
    case '1':
      department = 'Sales'
      departmentNumber = AGENT_NUMBER
      break
    case '2':
      department = 'Support'
      departmentNumber = OTHER_AGENT_NUMBER //you can use the same number for the sample
      break
    default:
      break
  }

  var ncco = ''

  if (department != '') {
      // NCCO for the user leg
    ncco = [{
      action: 'talk',
      text: 'Please wait while we connect you to ' + department
    }, {
      action: 'conversation',
      name: conversationName
    }
    ]

    // creating the agent leg and moving it to the same conversation
    vonage.calls.create({
      to: [
        {
          type: 'phone',
          number: departmentNumber
        }
      ],
      from: {
        type: 'phone',
        number: VONAGE_NUMBER
      },
      ncco: [
        {
          action: 'conversation',
          name: conversationName
        }]

    }, (error, response) => {
      if (error) console.error('outbound error:', error)
      if (response) {
          console.log('outbound ok')
      }
    })
  } else { // something went wrong, fallback route
    ncco = [{
      action: 'talk',
      text: 'Press 1 to talk to the sales department, press 2 to get technical support.',
      bargeIn: true
    }, {
      action: 'input',
      eventUrl: [
        `${request.protocol}://${request.get('host')}/webhooks/input`
      ],
      dtmf: {
        maxDigits: 1
      }
    }]
  }
  
  response.json(ncco)
})  
```

## Add survey NCCO

Next, to implement the customer satisfaction survey at the end of the call, you should handle `completed` event for the agent's leg. It will arrive at the same event webhook, so you should extend the event webhook with [transfer request](/voice/voice-api/code-snippets/transfer-a-call-inline-ncco) to the survey NCCO. In order to do that, you have to store the user and the agent leg identifiers:

```
var userLegId = ''
var agentLegId = ''

app.get('/webhooks/answer', (request, response) => {
  console.log('answer: ', request.query)

  userLegId = request.query.uuid

  console.log('userLegId: ', userLegId)
  

...

app.post('/webhooks/input', (request, response) => {
  console.log('input:', request.body)

    // creating the agent's leg and moving it to the same conversation
    vonage.calls.create({
        ...
    }, (error, response) => {
      if (error) console.error('outbound error:', error)
      if (response) {
        agentLegId = response.uuid
        console.log('agentLegId: ', agentLegId)
      }
    })
  } else ...
```

> In the real-life scenario, you should implement a cache to store the pairs of user/agent leg identifiers. The sample code shown in this tutorial will work properly only for one concurrent call.

Extend your event webhook with REST API update call method with inline NCCO with `talk` and `input` actions to move the user leg to the survey part:

```js
app.post('/webhooks/event', (request, response) => {
  console.log('event:', request.body)

  if (request.body.uuid == agentLegId && request.body.status == 'completed') {
    vonage.calls.update(userLegId, {
      action: 'transfer',
      destination: {
        type: 'ncco',
        ncco: [ {
          action: 'talk',
          text: 'Please valuate quality of service by entering a digit, 1 to 5'
        },
        {
          action: 'input',
          type: [ 'dtmf' ],
          dtmf: {
            maxDigits: 1
          },
          eventUrl: [ `${request.protocol}://${request.get('host')}/webhooks/survey` ]
        }
        ]
      }
    }, (err, res) => {
      if (err) {
        console.error('transfer error:', err)
      } else {
        console.log('transfer ok')
      }
    })
  }
  
  response.sendStatus(200)
})
```

## Write your survey webhook

Add survey webhook to print the results:

```js
app.post('/webhooks/survey', (request, response) => {
  console.log('survey: ', request.body)

  var phone = request.body.from
  var date = request.body.timestamp
  var score = request.body.dtmf.digits

  console.log('[%s] User %s gave %d', date, phone, score)

  const ncco = [
    {
      action: 'talk',
      text: 'Thank you, good bye.'
    }
  ]

  response.json(ncco)
})
```

## Create your Node.js server

Finally, write the code to instantiate your Node.js server:

```js
const port = 3000
app.listen(port, () => console.log(`Listening on port ${port}`))
```

## Test your application

1. Run your Node.js application by executing the following command:

```sh
node index.js
```

2. Call your Vonage number from "user phone" and listen to the welcome message.

3. Open the dial pad and press 1 or 2.

3. Answer the inbound call "agent phone".

4. Hang up on the agent phone.

5. Listen to the survey message and press any key on the first device.

6. Observe the console log to see the survey result.

## Troubleshooting

If you don't hear the user and agent sound, potentially it might be because the two legs are being processed in different locations. You can determine this by seeing different `conversation_uuid_to` values in the `transfer` events for user and agent legs. To fix that, try to configure the SDK to use a specific data center as described in the [Troubleshooting guide](/voice/voice-api/guides/troubleshooting/node#regions):

```js
const options = {
  apiHost: 'api-us-1.nexmo.com',
  restHost: 'rest-us-1.nexmo.com'
}

const vonage = new Vonage({
  apiKey: VONAGE_API_KEY,
  apiSecret: VONAGE_API_SECRET
  applicationId: VONAGE_APPLICATION_ID,
  privateKey: VONAGE_APPLICATION_PRIVATE_KEY_PATH
}, options)
```

## Conclusion

With Vonage Voice API you can empower your existing contact center solution with IVR of any logic complexity, which depends only on your target use case and is virtually unlimited. Or you can build your own solution from scratch using the Voice API and [Client SDK](/client-sdk/overview). Switching between the scripted part of the call and live conversation (and back) gives you the ability to mix any phone calling use cases and create a seamless customer experience.

## Where Next?
* Find out more about [Call Flow](/voice/voice-api/guides/call-flow) with the Voice API
* Learn how to build a call menu (Interactive Voice Response) from scratch by following [our tutorial](/voice/voice-api/tutorials/ivr)
* Improve customer experience with [Speech Recognition](/voice/voice-api/guides/asr), as an alternative or together with DTMF input;
* See how to use [Call Recording](/voice/voice-api/guides/recording) for future references and post-call analytics;
* Get direct access to the media with [WebSockets](/voice/voice-api/guides/websockets) for real-time analytics and AI integration.
* Check [Vonage AI](https://www.ai.vonage.com/) offering to get IVR or voice bot built by our experts for your specific use-case.
