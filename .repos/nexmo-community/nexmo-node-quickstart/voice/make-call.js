/* Voice Tutorial 1: Using Nexmo API to call your phone
   Before running this code, you must create an Application using the Nexmo CLI.
   Then run this node code with a phone number starts with an country code as the argument.
   e.g. Run it with a US number, start with the country code 1:
   $ node make-call.js 12025559999

   API Referene: https://docs.nexmo.com/voice/voice-api/api-reference
 */

'use strict';

require('dotenv').config({path: __dirname + '/../.env'});

const NEXMO_API_KEY = process.env.NEXMO_API_KEY;
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;
const NEXMO_PRIVATE_KEY = __dirname +"/../"+ process.env.NEXMO_PRIVATE_KEY;
const NEXMO_APPLICATION_ID = process.env.NEXMO_APPLICATION_ID;

const NEXMO_TO_NUMBER = process.argv[2];
const NEXMO_FROM_NUMBER = process.env.NEXMO_FROM_NUMBER;

if(!NEXMO_TO_NUMBER) {
  console.error('Please provide a number to call as a command line argument');
  return;
}

const Nexmo = require('nexmo');

const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET,
  applicationId: NEXMO_APPLICATION_ID,
  privateKey: NEXMO_PRIVATE_KEY
});

nexmo.calls.create({
  to: [{
    type: 'phone',
    number: NEXMO_TO_NUMBER
  }],
  from: {
    type: 'phone',
    number: NEXMO_FROM_NUMBER
  },
  answer_url: ['https://nexmo-community.github.io/ncco-examples/first_call_talk.json']
}, (err, res) => {
  if(err) { console.error(err); }
  else { console.log(res); }
});
