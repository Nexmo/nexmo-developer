---
title: Voice Bot
products: voice/voice-api
description: "This tutorial shows you how to use Automatic Speech Recognition to create a voice bot/interactive voice assistant application."
languages:
    - Node
---

# Voice Bot / Interactive Voice Assitant

In this tutorial, you will create a simple bot answering an inbound phone call. The bot will ask for your location and share your actual weather conditions in response. You will implement this using the express web application framework, Weatherstack API and Vonage Automatic Speech Recognition (ASR) feature.

## Prerequisites

To complete this tutorial, you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up) - for your API key and secret
* [ngrok](https://ngrok.com/) - to make your development web server accessible to Nexmo's servers over the Internet

## Install the Nexmo CLI

You'll need a Nexmo virtual number to receive inbound calls. If you don't already have one, you can either purchase and configure numbers in the [Developer Dashboard](https://dashboard.nexmo.com) or use the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli). This tutorial uses the CLI.

Run the following at a terminal prompt to install the CLI and configure it with your API key and secret, which you will find in the [Developer Dashboard](https://dashboard.nexmo.com):

```sh
npm install -g nexmo-cli
nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```

## Purchase a Nexmo number

If you don't already have one, buy a Nexmo virtual number to receive inbound calls.

First, list the numbers available in your country (replace `GB` with your two-character [country code](https://www.iban.com/country-codes)):

```sh
nexmo number:search GB
```

Purchase one of the available numbers. For example, to purchase the number `447700900001`, execute the following command:

```sh
nexmo number:buy 447700900001
```

## Create a Voice API application

Use the CLI to create a Voice API application with the webhooks that will be responsible for answering a call on your Nexmo number (`/webhooks/answer`) and logging call events (`/webhooks/events`), respectively.

These webhooks need to be accessible by Nexmo's servers, so in this tutorial you will use `ngrok` to expose your local development environment to the public Internet. [This blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) explains how to install and run `ngrok`.

Run `ngrok` using the following command:

```sh
ngrok http 3000
```

Make a note of the temporary host name that `ngrok` provides and use it in place of `example.com` in the following command:

```sh
nexmo app:create "My Echo Server" https://example.com/webhooks/answer https://example.com/webhooks/events
```

The command returns an application ID (which you should make a note of) and your public key information (which you can safely ignore for the purposes of this tutorial).

## Link your number

You need to link your Nexmo number to the Voice API application that you just created. Use the following command:

```sh
nexmo link:app NEXMO_NUMBER NEXMO_APPLICATION_ID
```

You're now ready to write your application code.


## Sign up Weatherstack account

In this tutorial, we use Weatherstack API to get weather info. To make a request, you have to [sign up](https://weatherstack.com/signup/free) for a free account to get the API key.

## Create the project

Make a directory for your application, `cd` into the directory and then use the Node.js package manager `npm` to create a `package.json` file for your application's dependencies:

```sh
$ mkdir myapp
$ cd myapp
$ npm init
```

Press [Enter] to accept each of the defaults.

Then, install the [express](https://expressjs.com) web application framework and [body-parser](https://www.npmjs.com/package/body-parser) packages:

```sh
$ npm install express body-parser
```

## Write your answer webhook

When Nexmo receives an inbound call on your virtual number, it will make a request to your `/webhooks/answer` route. This route should accept an HTTP `GET` request and return a [Nexmo Call Control Object (NCCO)](/voice/voice-api/ncco-reference) that tells Nexmo how to handle the call.

Your NCCO should use the `talk` action to greet the caller, and the `input` action to start listening:

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
      speech: {
        uuid: [request.query.uuid],
        language: 'en-us'
      }
    },
    {
      action: 'talk',
      text: 'Sorry, I don\'t hear you'
    }
  ]

  response.json(ncco)
})
```

Speech recognition requires specifying the call leg identifier, in order to do that we use the `uuid` we get in the callback request: `request.query.uuid`, which is the identifier of the inbound PSTN leg we want to listen to.

## Write your event webhook

Implement a webhook that captures call events so that you can observe the lifecycle of the call in the console:

```js
app.post('/webhooks/events', (request, response) => {
  console.log(request.body)
  response.sendStatus(200);
})
```

Nexmo makes a `POST` request to this endpoint every time the call status changes.

## Write your ASR webhook

Speech recognition results will be sent to the specific URL we set in the input action: `/webhooks/asr`. Let’s add a webhook to process the result and add some user interaction.

In case of a successful recognition, the request payload will look as follows:

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

So we should use the first element of the `speech.results` array for further analysis. To get the weather conditions data, you should make an HTTP `GET` request to the following URL:

`http://api.weatherstack.com/current?access_key=<key>&query=<location>`

where `access_key` is your Weatherstack API key and `query` is what the user said (or at least what we expected them to say). Weatherstack provides a lot of interesting data in the response body:

```json
{
  request: {
    type: 'City',
    query: 'New York, United States of America',
    language: 'en',
    unit: 'm'
  },
  location: {
    name: 'New York',
    country: 'United States of America',
    region: 'New York',
    lat: '40.714',
    lon: '-74.006',
    timezone_id: 'America/New_York',
    localtime: '2020-04-17 13:33',
    localtime_epoch: 1587130380,
    utc_offset: '-4.0'
  },
  current: {
    observation_time: '05:33 PM',
    temperature: 9,
    weather_code: 113,
    weather_icons: [
      'http://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png'
    ],
    weather_descriptions: [ 'Sunny' ],
    wind_speed: 15,
    wind_degree: 250,
    wind_dir: 'WSW',
    pressure: 1024,
    precip: 0,
    humidity: 28,
    cloudcover: 0,
    feelslike: 7,
    uv_index: 5,
    visibility: 16,
    is_day: 'yes'
  }
}
```

In our app, we will use just the very simple parameters like `description` (“Sunny”) and `temperature`. It’d be nice to get weather forecast rather than the actual temperature, however since the free Weatherstack account allows us to get only `current` conditions - that’s what we will use.

Once we received the response from Weatherstack, we will return a new NCCO with the talk action to say “Today in New York: it’s sunny, 9 degrees Celcius”.

Finally, add the code to handle the ASR callback:

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
You may add some additional logic to the bot, for example - convert temperature to Fahrenheit if the location is in the US. Add this code snippet before creating the NCCO:

```js
if (weather.location.country == 'United States of America') {
  temperature = Math.round((temperature * 9 / 5) + 32) + '°F'
} else {
  temperature = temperature + '°C'
}
```
and don't forget to remove degrees symbol from the message text since it’s now included to the `temperature` variable value:

```js
text: `Today in ${location}: it's ${description}, ${temperature}`
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

2. Call your Nexmo number and listen to the welcome message.

3. Say your city name.

4. Hear your actual weather conditions back.

## Conclusion

In this tutorial, you created an application that uses the Voice API to interact with caller by asking and answering with voice messages.

The bot you created was pretty simple, but it was able to listen to the caller and respond with some relevant information. You may use it as a basis for your IVR or some customer self-service app just by adding appropriate business logic relevant to your case and the services you are using.

As you see, speech recognition (ASR) is an effortless way to implement dialogue-style voice bot or IVR/IVA quickly. If you need more flexibility or almost real-time interaction, take a look at and try our [WebSockets](https://developer.nexmo.com/voice/voice-api/guides/websockets) feature, which is extremely powerful and can empower some very sophisticated use cases, such as artificial intelligence, analysis and transcription of call audio.


## Where Next?

Here are a few more suggestions of resources that you might enjoy as the next step after this tutorial:

* Learn more about [speech recognition](https://developer.nexmo.com/voice/voice-api/guides/speech-recognition) feature;
* Make the bot sound more natural by [customizing text-to-speech](https://developer.nexmo.com/voice/voice-api/guides/customizing-tts) messages with SSML;
* Find out how to get and send back the raw media through [WebSocket](https://developer.nexmo.com/use-cases/voice-call-websocket-node) connection.