require('dotenv').config({path: __dirname + '/../.env'});

var NEXMO_API_KEY = process.env.NEXMO_API_KEY;
var NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;
var NEXMO_TO_NUMBER = process.env.NEXMO_TO_NUMBER;
var BRAND_NAME = process.env.NEXMO_BRAND_NAME;

var Nexmo = require('nexmo');
var nexmo = new Nexmo({apiKey: NEXMO_API_KEY, apiSecret: NEXMO_API_SECRET});

var verifyRequestId = null; // use in the check process

nexmo.verify.request({number: NEXMO_TO_NUMBER, brand: BRAND_NAME}, function(err, result) {
  if(err) { console.error(err); }
  else {
    verifyRequestId = result.request_id;
    console.log('request_id', verifyRequestId);
  }
});