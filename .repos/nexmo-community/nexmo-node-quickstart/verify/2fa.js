/* Two-Factor Auth Tutorial Code Sample
  `nexmo.verify.request` to send a temp code to a user's phone, then
  `nexmo.verify.check` to validate the code entered by the user (on the web interface)

  In this sample app, upon user registration, store the user's phone number
  (as a key) and the generated request ID (as the value) in the persist storage.

  When the user enter the PIN code, look the info up and match the PIN with the
  request ID from the storage to verify.

  Verify API Reference: https://developer.nexmo.com/api/verify
*/

'use strict';

require('dotenv').config({
  path: __dirname + '/../.env'
});

const express = require('express');
const bodyParser = require('body-parser');
const ejs = require('ejs');
const app = express();

app.use(bodyParser.json()); // for parsing POST req
app.use(bodyParser.urlencoded({
  extended: true
}));

app.set('views', __dirname + '/views'); // Render on browser
app.set('view engine', 'html');
app.engine('html', ejs.renderFile);
app.use(express.static(__dirname + '/views'));

const server = app.listen(process.env.PORT || 5000, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});

const BRAND_NAME = process.env.NEXMO_BRAND_NAME;
const NEXMO_API_KEY = process.env.NEXMO_API_KEY;
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;

const Nexmo = require('nexmo');
const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET
});

// Web UI ("Registration Form")
app.get('/', (req, res) => {
  res.render('index');
});

app.post('/register', (req, res) => {
  // A user registers with a mobile phone number
  let phoneNumber = req.body.number;
  console.log(phoneNumber);
  nexmo.verify.request({
    number: phoneNumber,
    brand: BRAND_NAME
  }, (err, result) => {
    if (err) {
      //res.sendStatus(500);
      res.render('status', {
        message: 'Server Error'
      });
    } else {
      console.log(result);
      let requestId = result.request_id;
      if (result.status == '0') {
        res.render('verify', {
          requestId: requestId
        });
      } else {
        //res.status(401).send(result.error_text);
        res.render('status', {
          message: result.error_text,
          requestId: requestId
        });
      }
    }
  });
});

app.post('/verify', (req, res) => {
  // Checking to see if the code matches
  let pin = req.body.pin;
  let requestId = req.body.requestId;

  nexmo.verify.check({
    request_id: requestId,
    code: pin
  }, (err, result) => {
    if (err) {
      //res.status(500).send(err);
      res.render('status', {
        message: 'Server Error'
      });
    } else {
      console.log(result);
      // Error status code: https://developer.nexmo.com/api/verify#verify-check
      if (result && result.status == '0') {
        //res.status(200).send('Account verified!');
        res.render('status', {
          message: 'Account verified! 🎉'
        });
      } else {
        //res.status(401).send(result.error_text);
        res.render('status', {
          message: result.error_text,
          requestId: requestId
        });
      }
    }
  });
});
