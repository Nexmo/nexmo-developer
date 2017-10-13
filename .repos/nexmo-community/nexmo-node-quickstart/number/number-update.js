require('dotenv').config({path: __dirname + '/../.env'});

const NEXMO_API_KEY = process.env.NEXMO_API_KEY;
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;
const NEXMO_APPLICATION_ID = process.env.NEXMO_APPLICATION_ID;
const NEXMO_NUMBER_TO_UPDATE = process.env.NEXMO_NUMBER_TO_UPDATE;

var Nexmo = require('nexmo');

var nexmo = new Nexmo({apiKey: NEXMO_API_KEY, apiSecret: NEXMO_API_SECRET}, {debug: true});

nexmo.number.update(
  'US',
  NEXMO_NUMBER_TO_UPDATE,
  {
    voiceCallbackType: 'app',
    voiceCallbackValue: NEXMO_APPLICATION_ID,
    moHttpUrl: 'https://example.com'
  },
  (err, res) => {
    if(err) {
      console.error(err)
    }
    else {
      console.log(res);
    }
});
