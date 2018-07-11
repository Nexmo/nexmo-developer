/* Tutorial 1: Nexmo SMS outcoming messages demo with ExpressJS */

'use strict';

require('dotenv').config({path: __dirname + '/../.env'});

const NEXMO_API_KEY = process.env.NEXMO_API_KEY;
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;
const NEXMO_FROM_NUMBER = process.env.NEXMO_FROM_NUMBER;

const express = require('express');
const bodyParser = require('body-parser');
const Nexmo = require('nexmo');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
const server = app.listen(process.env.PORT || 3000);

const nexmo = new Nexmo({
  apiKey: NEXMO_.API_KEY,
  apiSecret: NEXMO_API_SECRET,
}, {debug: true});

app.post('/send', (req, res) => {
  // Sending SMS via Nexmo
  nexmo.message.sendSms(
    NEXMO_FROM_NUMBER, req.body.toNumber, req.body.message, {type: 'unicode'},
    (err, responseData) => {if (responseData) {console.log(responseData)}}
  );
});
