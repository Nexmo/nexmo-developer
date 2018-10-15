---
title: Fraud scoring and phone number verification
products: number-insight
description: While it would be easy to confirm a phone number with Nexmo Verify every time a user provides you with their number this is hardly always necessary. By combining Nexmo Verify with Nexmo Number Insight, and applying your own fraud scoring logic, it is easy to build your own fraud detection system.
languages:
    - Node
---

# Fraud scoring and phone number verification

While it would be easy to confirm a phone number with Nexmo Verify every time a user provides you with their number this is not always necessary. By combining Nexmo Verify with Nexmo Number Insight, and applying your own fraud scoring logic, it is easy to build your own fraud detection system.

## In this tutorial

By following this tutorial, you can see how to build a number verification system using Nexmo APIs and libraries. For this tutorial, the fraud rating logic extracts the user's current country from their IP and request their phone's current (roaming) country. The number is flagged as potentially fraudulent if the user's phone number location and IP location don't match.

To do this:

* [Create an application](#create-an-application) - create an application that can accept a user's phone number.
* [Set up nexmo](#set-up-nexmo) - set up nexmo in the application.
* [Analyze a phone number](#analyze-a-phone-number) - analyze the user's number using Nexmo Number Insight.
* [Send a verification code](#send-a-verification-code) - when the number triggers the verification step send a code to the user's phone.
* [Check verification code](#check-verification-code) - check the verification code the user provides us to ensure it's valid.

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* A publicly accessible Web server so Nexmo can make webhook requests to your app. If you're developing locally you must use a tool such as [ngrok](https://ngrok.com/)
* The source code for this tutorial from <https://github.com/Nexmo/node-verify-fraud-detection>.

## Create an application

For this tutorial you require a web server to be running. Keep the server and fraud detection business logic separate.

**lib/server.js**

```javascript
// start a new app
var app = require('./app')

// load our fraud prevention module
var FraudDetection = require('./FraudDetection');
var fraudDetection = new FraudDetection();

// handle all routes
require('./routes')(app, fraudDetection);
```

**lib/app.js**

```javascript
var express = require('express');
var bodyParser = require('body-parser');

// create a new express server
var app = express();
app.set('port', (process.env.PORT || 5000));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'))
app.set('view engine', 'jade')

// start the app and listen on port 5000
app.listen(app.get('port'), '127.0.0.1', function() {
  console.log('SMS Proxy App listening on port', app.get('port'));
});

module.exports = app;
```

Add the form to collect the user's phone number.

**lib/routes.js**

```javascript
// render a registration form
app.get('/', function(req, res) {
  res.render('index');
});
```

**views/index.jade**

```jade
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

With this form in place you can start processing the number and detect any potential fraud. Firstly though, you need to add Nexmo to the project.

## Set up Nexmo

Start by adding Nexmo to your project.

```sh
npm install nexmo dotenv --save
```

Configure your app to load your credentials from a `.env` file.

**lib/server.js**

```javascript
// load environment variable
// from .env file
require('dotenv').config();
```

With this in place you can initialize the Node library in the fraud detector.

**lib/FraudDetection.js**

```javascript
this.nexmo = new Nexmo({
  apiKey: process.env.NEXMO_API_KEY,
  apiSecret: process.env.NEXMO_API_SECRET
});
```

## Analyze a phone number

You use Nexmo APIs and the user's IP to compare a few different sets of data. Start by extracting the user's location by their IP and then comparing this to the data that Nexmo Number Insight provides the app about their phone's current location.

The Nexmo Number Insight API can tell the app the phone's original location, whether they are roaming, and what the current roaming location of their phone number is (if applicable). The app compares their IP's location to that of their phone's location, and force further verification if they do not match.

```js_sequence_diagram
Participant Browser
Participant App
Participant Nexmo
Participant Phone
Note over App,Nexmo: Initialization
Browser->App: Submit number
App->Nexmo: Number Insight Request
Nexmo-->App: Number Insight Response
App->Nexmo: Verify Request
Nexmo-->App: Verify Response
App-->Browser: Request for Code
Browser-->App: Submit code
App-->Nexmo: Code Verification Request
Nexmo->App: Code Verification Status
Nexmo-->Browser: Continue Registration
```

When the user submits their phone number the app passes this to the fraud detection code together with the user's current IP. If the fraud detection comes back as not matching, send a verification code.

**lib/routes.js**

```javascript
// process the number for fraud
// detection and if it fails
// try to verify the number
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

To determine the country for an IP use the [MaxMind GeoIP](https://www.maxmind.com) database.

```sh
npm install maxmind --save
```

**lib/FraudDetection.js**

```javascript
var maxmind = require('maxmind');

/**
 * Create a new FraudDetection object
 */
var FraudDetection = function(config) {
  this.nexmo = new Nexmo({
    apiKey: process.env.NEXMO_API_KEY,
    apiSecret: process.env.NEXMO_API_SECRET
  });

  maxmind.open(__dirname + '/../GeoLite2-Country.mmdb', (err, countryLookup) => {
    this.countryLookup = countryLookup;
  });
};
```

In your fraud detection code extract the user's IP from the request and then determine the country. Also submit the phone number to Nexmo's Number Insight API to extract the current roaming status and the current and roaming countries for the phone number.

By combining all this data you can build a simple risk model, and if the countries do not match trigger a next step.

**lib/FraudDetection.js**

```javascript
/**
 * Determines if a number is potentially fraudulant
 * by comparing the number's country status to
 * the IP location
 */
FraudDetection.prototype.matchesLocation = function(number, request, callback) {
  var ip = process.env['IP'] || req.headers["x-forwarded-for"] || req.connection.remoteAddress;
  var geoData = this.countryLookup.get(ip);

  this.nexmo.numberInsight.get({
    level: 'advancedSync',
    number: number
  }, function(error, insight) {
    var isRoaming   = insight.roaming.status !== 'not_roaming';

    if (isRoaming) {
      var matches = insight.roaming.roaming_country_code
                      == geoData.country.iso_code;
    } else {
      var matches = insight.country_code
                      == geoData.country.iso_code;

    }
    callback(matches)
  });
}
```

## Send a verification code

When the risk model determines it's necessary send a verification code to the phone to verify the user owns this number.

**lib/FraudDetection.js**

```javascript
/**
 * Starts the verification of a number
 */
FraudDetection.prototype.startVerification = function(number, callback) {
  this.nexmo.verify.request({
    number: number,
    brand: 'ACME Corp'
  }, callback);
};
```

Redirect the user to a view to collect the code they received on their phone.

**lib/routes.js**

```javascript
res.redirect('/confirm?request_id='+result.request_id);
```

**lib/routes.js**

```javascript
// show the confirmation page
// where a user can fill in
// the code they received via sms
app.get('/confirm', function(req, res) {
  res.render('confirm', {
    request_id: req.query.request_id
  });
});
```

**views/confirm.jade**

```jade
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

## Check verification code

In the final step check the code the user submits against the request ID for the verification that was passed.

**lib/routes.js**

```javascript
// process the code provided
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

**lib/FraudDetection.js**

```javascript
/**
 * Checks the verification of a number
 */
FraudDetection.prototype.checkVerification = function(request_id, code, callback) {
  this.nexmo.verify.check({
    code: code,
    request_id: request_id
  }, callback);
};
```

On the last page show a user who passed these steps a friendly message to confirm that they have made it through.

**lib/routes.js**

```javascript
// show the page when the
// user is fully registered
app.get('/registered', function(req, res) {
  res.render('registered');
});
```

**views/registered.jade**

```jade
extends ./layout

block content
  h1 Registered
  #flash_notice You are now fully signed up. Thank you for providing your phone number.
```

## Conclusion

And that's it. You have built a fraud detection system using Nexmo Number Insight and Verify. In this tutorial the following combination was used to flag potentially fraudulent numbers:

* roaming status of the number
* roaming country
* country of their current IP
* country of origin

You have also learned how to verify a number by sending it a code and verifying the code on submission.

Most importantly you can use the Nexmo Number Insight and Verify APIs, the data and workflows covered in this tutorial, along with any other data that you require to build your own fraud detection and prevention system.

## Get the Code

All the code for this tutorial and more is [available on GitHub](https://github.com/Nexmo/node-verify-fraud-detection).

## Resources

* [Nexmo Client Library for Node](https://github.com/Nexmo/nexmo-node)
* [Verify API](/verify/api-reference/)
* [Verify API reference guide](/api/verify)
* [Number Insight API](/number-insight)
* [Number Insight Advanced API](/number-insight)
* [Number Insight Advanced API Reference](/api/number-insight)
