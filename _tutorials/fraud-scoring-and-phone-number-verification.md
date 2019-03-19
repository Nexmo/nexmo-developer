---
title: Fraud Scoring and Phone Number Verification
products: number-insight
description: You can use the Number Insight Advanced and Verify APIs together to build your own fraud detection system. With this approach, you can protect your organisation against fraudulent transactions while making the process frictionless for most customers.
languages:
    - Node
---

# Fraud Scoring and Phone Number Verification

You can use the [Number Insight Advanced](/number-insight) and [Verify API](/verify/api-reference/)s together to build your own fraud detection system. With this approach, you can protect your organisation against fraudulent transactions while making the process frictionless for most customers.

## In this tutorial

In this tutorial you learn how to pre-screen customer-provided numbers using the Number Insight Advanced API, verifying those numbers with a PIN code only when your checks indicate possible fraud.

You will build an application that enables a user to register for an account by providing their phone number. You will check that number using the Number Insight Advanced API to determine if it is in the same country as their IP address. If the country (or roaming country) the number belongs to and that of the user's IP do not match you will flag the number as being potentially fraudulent. Then, you will use the Verify API's two-factor authentication (2FA) capability to confirm that the user owns the number.

To do this:

* [Create an application](#create-an-application) - create an application that accepts a user's phone number.
* [Install the Nexmo REST Client API for Node](#install-the-nexmo-rest-client-api-for-node) - add Nexmo functionality to your application.
* [Configure the application](#configure-the-application) - read your API key and secret and other settings from a configuration file.
* [Process a phone number](#process-a-phone-number) - build the logic that processes the number submitted by a user.
* [Check for possible fraud](#check-for-possible-fraud) - use the Number Insight API to determine where the associated device is located.
* [Send a verification code](#send-a-verification-code) - when the number triggers the verification step send a code to the user's phone using the Nexmo Verify API.
* [Check the verification code](#check-the-verification-code) - check that the verification code provided by the user is valid.

## Prerequisites

To complete this tutorial, you need:

* The `api_key` and `api_secret` for your [Nexmo account](https://dashboard.nexmo.com/sign-up)  - sign up for an account if you do not already have one.
* Basic knowledge of Node.js and the `express` package.
* A publicly accessible Web server so Nexmo can make webhook requests to your app. For local development, we recommend [ngrok](https://ngrok.com/).

> [Learn how to use `ngrok`](https://developer.nexmo.com/concepts/guides/webhooks#using-ngrok-for-local-development)

## Create an application

You will build the application so that the server and fraud detection business logic are separate.

1. Create the basic application directory.

    ```sh
    $ mkdir fraudapp;
    $ cd fraudapp;
    $ mkdir lib views 
    ```
2. Use `npm init` to create a `package.json` file for your project and specify `lib/server.js` file as the entry point when prompted.

3. Install the dependencies:

    ```javascript
    $ npm install express dotenv pug body-parser --save
    ```

4. Create the `lib/server.js` file. This will be the starting point of the application and brings all the other parts into play. It will load the `lib/app.js` file, instantiate the `FraudDetection` class and incorporate the routes from `lib/routes.js`, all of which you will create shortly.

    Include the following code in `lib/server.js`:

    ```javascript
    // start a new app
    var app = require('./app')

    // load our fraud prevention module
    var FraudDetection = require('./FraudDetection');
    var fraudDetection = new FraudDetection();

    // handle all routes
    require('./routes')(app, fraudDetection);
    ```

### Define the initial route

Create the `lib/routes.js` file to define the routes for the application. Code a handler that displays the form for the user to enter their number when your homepage (`/`) recieves a [GET] request: 

```javascript
module.exports = function(app, detector) {
  app.get('/', function(req, res) {
    res.render('index');
  });
};
```

### Start the web server

Create the `lib/app.js` file to start the web server. The code shown below starts the server on the port specified by the `PORT` environment variable, or port 5000 if the `PORT` environment variable is not set:

```javascript
var express = require('express');
var bodyParser = require('body-parser');

// create a new express server
var app = express();
app.set('port', (process.env.PORT || 5000));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'))
app.set('view engine', 'pug')

// start the app and listen on port 5000
app.listen(app.get('port'), '127.0.0.1', function() {
  console.log('Fraud app listening on port', app.get('port'));
});

module.exports = app;
```

### Create the registration form

You will use the `pug` templating engine to create the HTML forms that the application requires.

1. Create the basic view in the `views/layout.pug` file, with the following contents:

    ```pug
    doctype html
    html(lang="en")
      head
        title Nexmo Fraud Detection
        link(href='style.css', rel='stylesheet')
      body
        #container
          block content
    ```

2. Create the `views/index.pug` file that will enable the user to enter their number to register:

    ```pug
    extends ./layout

    block content
      h1 Register your number
      form(method='post')
        .field
          label(for='number') Phone number
          input(type='text', name='number', placeholder='1444555666')
        .actions
          input(type='submit', value='Register')
    ```

## Install the Nexmo REST Client API for Node

Add the [Nexmo REST Client API](https://github.com/Nexmo/nexmo-node) package to your project by executing the following command at a terminal prompt:

```sh
$ npm install nexmo --save
```

## Configure the application

Configure your application to load your credentials from a `.env` file, by incorporating the following `require` statement at the top of the `lib/server.js` file:

```javascript
require('dotenv').config();
```

Add the following entries to an `.env` file in the root of your application folder, replacing `YOUR_NEXMO_API_KEY` and `YOUR_NEXMO_API_SECRET` with your API key and secret from the [Developer Dashboard](https://dashboard.nexmo.com) 

```
NEXMO_API_KEY=YOUR_NEXMO_API_KEY
NEXMO_API_SECRET=YOUR_NEXMO_API_SECRET
IP=216.58.212.78 # USA IP
# IP=212.58.244.22 # UK IP
```

The `IP` entries are what we will use in a later step to simulate a user's current IP address so that we can determine which country they are accessing your application from. One is in the UK and the other is in the US. The US `IP` is commented out so that you can change your user's location for testing.

## Process a phone number

### How you will determine potential fraud

Now that you have a basic application up and running, you can write the logic that processes the number.

You will use information from the Number Insight API to check for potentially fraudulent numbers. Among many other things, the Number Insight Advanced API can tell you which country a number belongs to and (if it is a mobile number and the user is roaming) in which country the associated device is currently located.

In a production environment, you would determine the user's IP address programmatically. In this sample application, you will read the user's current IP address from the `IP` entry in the `.env` file and use the [MaxMind GeoIP](https://www.maxmind.com) database to geolocate it. 

Download the [MaxMind GeoLite 2 Country Database](https://dev.maxmind.com/geoip/geoip2/geolite2/), and extract the `Geolite2-Country.mmdb` file to the root of your application directory. Install it by executing the following at a terminal prompt:

```sh
$ npm install maxmind --save
```

If the user's current IP address is different from that reported by Number Insight, you can force them to verify ownership of the number by using the Verify API. In this way, you are only enforcing the verification step if the number provided is in a different country than the device it belongs to.

Your application therefore must trigger the following sequence of events:

```js_sequence_diagram
Participant Browser
Participant App
Participant Nexmo
Note over App,Nexmo: Initialization
Browser->App: User registers by \nsubmitting number
App->Nexmo: Number Insight request
Nexmo-->App: Number Insight response
Note over App,Nexmo: If Number Insight shows that the \nuser and their phone are in different \ncountries, start the verification process
App->Nexmo: Send verification code to user's phone
Nexmo-->App: Receive acknowledgement that \nverification code was sent
App->Browser: Request the code from the user
Browser->App: User submits the code they received
App->Nexmo: Check verification code
Nexmo-->App: Code Verification status
Note over Browser,App: If either Number Insight response or verification step \nis satisfactory, continue registration
App->Browser: Confirm registration
```

### Creating the fraud detection logic

Create the `FraudDetection.js` file for the `FraudDetection` class in the application's `lib` folder. In the class constructor, first create an instance of `Nexmo`, providing it with your Nexmo API key and secret from the `.env` configuration file:

```javascript
var Nexmo = require('nexmo');

var FraudDetection = function(config) {
  this.nexmo = new Nexmo({
    apiKey: process.env.NEXMO_API_KEY,
    apiSecret: process.env.NEXMO_API_SECRET
  });
};

module.exports = FraudDetection;
```

Then, create the IP lookup by modifying the `FraudDetection.js` file to read as follows:

```javascript
var Nexmo = require('nexmo');
var maxmind = require('maxmind');

var FraudDetection = function(config) {
  this.nexmo = new Nexmo({
    apiKey: process.env.NEXMO_API_KEY,
    apiSecret: process.env.NEXMO_API_SECRET
  });

  maxmind.open(__dirname + '/../GeoLite2-Country.mmdb', (err, countryLookup) => {
    this.countryLookup = countryLookup;
  });
};

module.exports = FraudDetection;
```

When the user submits their phone number, pass it to your fraud detection code together with the user's current IP. If the fraud detection logic determines that there is a mismatch between the location of the phone and the location of the user, send a verification code. Implement this by adding a `/` route handler for a [POST] request in `lib/routes.js` as follows:

```javascript
  app.post('/', function(req, res) {
    var number = req.body.number;

    detector.matchesLocation(number, req, function(matches){
      if (matches) {
        res.redirect('/registered');
      } else {
        detector.startVerification(number, function(error, result){
          res.redirect('/confirm?request_id='+result.request_id);
        });
      }
    });
  });
```

## Check for possible fraud

In the `FraudDetection` class, extract the user's IP from the request and use the MaxMind country database to determine the country in which the user is accessing your application.

Then, make an aysnchronous request to the Number Insight Advanded API to see if the number that the user registered is currently roaming and thereby determine the correct country for comparison.

By combining all this data you can build a simple risk model, and if the countries do not match trigger a next step.

Add the following method to the `FraudDetection` class in `lib\FraudDetection.js`:

```javascript
FraudDetection.prototype.matchesLocation = function(number, request, callback) {
  var ip = process.env['IP'] || req.headers["x-forwarded-for"] || req.connection.remoteAddress;
  var geoData = this.countryLookup.get(ip);

  this.nexmo.numberInsight.get({
    level: 'advancedSync',
    number: number
  }, function(error, insight) {
    var isRoaming = insight.roaming.status !== 'not_roaming';

    if (isRoaming) {
      var matches = insight.roaming.roaming_country_code == geoData.country.iso_code;
    } else {
      var matches = insight.country_code == geoData.country.iso_code;

    }
    callback(matches)
  });
}
```

## Send a verification code

1. Modify `lib\FraudDetection.js` so that when the risk model detects a possibly fraudulent number you send a verification code to the phone using Nexmo's Verify API. Add the following method to the class:

    ```javascript
    FraudDetection.prototype.startVerification = function(number, callback) {
      this.nexmo.verify.request({
        number: number,
        brand: 'ACME Corp'
      }, callback);
    };
    ```

2. In `lib/routes.js`, add a new route to enable the user to enter the verification code that they received on their phone: 

    ```javascript
    app.get('/confirm', function(req, res) {
      res.render('confirm', {
        request_id: req.query.request_id
      });
    });
    ```

3. Create the view for the user to enter the confirmation code in `views/confirm.pug`:

    ```pug
    extends ./layout

    block content
      h1 Confirm the code
      #flash_alert We have sent a confirmation code to your phone number. Please fill in the code below to continue.
      form(method='post')
        .field
          label(for='code') Code
          input(type='text', name='code', placeholder='1234')
          input(type='hidden', name='request_id', value=request_id)
        .actions
          input(type='submit', value='Confirm')
    ```

## Check the verification code

1. In `lib/routes.js`, if the user correctly entered the verification code, redirect them to `/registered`. Otherwise, send them back to `/confirm`:

    ```javascript
    app.post('/confirm', function(req, res) {
      var code = req.body.code;
      var request_id = req.body.request_id;

      detector.checkVerification(request_id, code, function(error, result) {
        if (result.status == '0') {
          res.redirect('/registered');
        } else {
          res.redirect('/confirm');
        }
      });
    });
    ```

2. In `lib/FraudDetection.js`, check the code that the user submits against the request ID for the verification that was sent:

    ```javascript
    FraudDetection.prototype.checkVerification = function(request_id, code, callback) {
      this.nexmo.verify.check({
        code: code,
        request_id: request_id
      }, callback);
    };
    ```

3. Show a user who passed these steps a friendly message to confirm their registration, by adding the following route to `lib/routes.js`:

    ```javascript
    app.get('/registered', function(req, res) {
      res.render('registered');
    });
    ```

4. Create the view as `lib/registered.pug`:

    ```pug
    extends ./layout

    block content
      h1 Registered
      #flash_notice You are now fully signed up. Thank you for providing your phone number.
    ```

## Test the application

1. Launch the application:

    ```sh
    $ node lib/server.js
    ```

2. Run `ngrok`:

    ```sh
    $ ./ngrok http 5000
    ```

3. Navigate to the address that `ngrok` provides in your browser. For example: `https://7db5972b.ngrok.io`.

4. Enter your phone number. If the `IP` entry in `.env` matches the current location of your mobile device, you should see your device successfully registered. If not, you will be sent a verification code and prompted to enter it before you can register. 

## Conclusion

In this tutorial, you built a very basic fraud detection system. You used the following information from the [Number Insight Advanced API](/verify/api-reference/) to flag potentially fraudulent numbers:

* The country of their current IP
* The country the phone number belongs to
* The roaming status of the number
* The roaming country

You also learned how to verify a number using the [Verify API](/verify).

## Next Steps

Here are a few resources that might help you build this type of application:

* The [source code](https://github.com/Nexmo/node-verify-fraud-detection) for this tutorial on GitHub
* Code samples, showing you how to:
  * [Request](/number-insight/code-snippets/number-insight-advanced-async) and [receive](/number-insight/code-snippets/number-insight-advanced-async-callback) Number Insight Advanced API data asynchronously
  * [Send](/verify/code-snippets/send-verify-request) and [check](/verify/code-snippets/check-verify-request) verification codes using the Verify API
* Blog posts:
  * [Number Insight API](https://www.nexmo.com/?s=number+insight)
  * [Verify API](https://www.nexmo.com/?s=verify)
* API reference documentation:
  * [Number Insight API](/number-insight/api-reference)
  * [Verify API](/verify/api-reference)
  
