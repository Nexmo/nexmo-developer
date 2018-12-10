require('dotenv').config({
  path: __dirname + '/../.env'
});

const NEXMO_API_KEY = process.env.NEXMO_API_KEY;
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;

const REQUEST_ID = process.argv[2];
if (!REQUEST_ID) {
  console.error('Please supply the `request_id`');
  return;
}

const CODE = process.argv[3];
if (!CODE) {
  console.error('Please supply the confirmation code');
  return;
}

const Nexmo = require('nexmo');
const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET
}, {
  debug: true
});

nexmo.verify.check({
  request_id: REQUEST_ID,
  code: CODE
}, (err, result) => {
  if (err) {
    console.error(err);
  } else {
    console.log(result);
  }
});
